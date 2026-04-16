import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store/core/constants/routes.dart';
import 'package:store/features/Presentation/viewModel/cubit/home/state/home_state.dart';
import 'package:store/features/data/repositories/home_repository.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeRepository repo;

  HomeCubit(this.repo) : super(HomeInitial()) {
    loadHome();
  }

  int currentIndex = 0;
  List favoriteProducts = [];
  List cartProducts = [];

  TextEditingController searchController = TextEditingController();
  Timer? _debounce;

  int skip = 0;
  final int limit = 10;
  bool isLoadingMore = false;
  bool hasMore = true;

  List products = [];
  List categories = [];
  List brands = [];

  //! ================= NAV =================
  void changeBottomNav(int index) {
    currentIndex = index;

    if (state is HomeSuccess) {
      final current = state as HomeSuccess;

      emit(current.copyWith());
    }
  }

  //! ================= LOAD HOME =================
  Future<void> loadHome() async {
    emit(HomeLoading());

    final catRes = await repo.getCategories();
    final brandRes = await repo.getBrands();
    final prodRes = await repo.getProducts();
    final favRes = await repo.getFavorites();
    final cartRes = await repo.getCart();

    catRes.fold((e) => emit(HomeError(e)), (cats) {
      brandRes.fold((e) => emit(HomeError(e)), (brs) {
        prodRes.fold((e) => emit(HomeError(e)), (prods) {
          favRes.fold((e) => emit(HomeError(e)), (favProds) {
            cartRes.fold((e) => emit(HomeError(e)), (cartProds) {
              categories = cats;
              brands = brs;
              products = prods;
              favoriteProducts = favProds;
              cartProducts = cartProds;

              emit(
                HomeSuccess(
                  categories: categories,
                  brands: brands,
                  products: products,
                  favoriteProducts: favoriteProducts,
                  cartProducts: cartProducts,
                ),
              );
            });
          });
        });
      });
    });
  }

  //! ================= PAGINATION =================
  Future<void> loadMore() async {
    if (isLoadingMore || !hasMore) return;

    isLoadingMore = true;

    final result = await repo.getProducts(skip: skip, limit: limit);

    result.fold(
      (error) {
        isLoadingMore = false;
        emit(HomeError(error));
      },
      (newProducts) {
        if (newProducts.isEmpty) {
          hasMore = false;
        } else {
          products.addAll(newProducts);
          skip += newProducts.length;
        }

        isLoadingMore = false;

        final current = state as HomeSuccess;

        emit(current.copyWith(products: List.from(products)));
      },
    );
  }

  //! ================= SEARCH =================
  Future<void> search(String query) async {
    final currentState = state;

    if (currentState is! HomeSuccess) return;

    final result = await repo.filterProducts(
      search: query,
      skip: 0,
      limit: limit,
    );

    result.fold((e) => emit(HomeError(e)), (data) {
      emit(currentState.copyWith(products: data["products"]));
    });
  }

  void onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    _debounce = Timer(const Duration(milliseconds: 500), () {
      search(query);
    });
  }

  //! ================= FILTER =================
  Future<void> applyFilter({String? brand, String? category}) async {
    final currentState = state;

    if (currentState is! HomeSuccess) return;

    final result = await repo.filterProducts(
      brand: brand,
      category: category,
      skip: 0,
      limit: limit,
    );

    result.fold((e) => emit(HomeError(e)), (data) {
      products = data["products"];
      skip = data["skip"];
      hasMore = data["total"] > products.length;

      emit(currentState.copyWith(products: products));
    });
  }

  //! ================= TOGGLE FAVORITE =================
  Future<void> toggleFavorite(int productId) async {
    if (state is! HomeSuccess) return;

    final currentState = state as HomeSuccess;

    final isFav = currentState.favoriteProducts.any((e) => e.id == productId);

    if (isFav) {
      //! REMOVE
      final result = await repo.removeFavorite(productId);

      result.fold((e) => emit(HomeError(e)), (_) {
        final updatedFavs = currentState.favoriteProducts
            .where((e) => e.id != productId)
            .toList();

        emit(currentState.copyWith(favoriteProducts: updatedFavs));
      });
    } else {
      //! ADD
      final result = await repo.addFavorite(productId);

      result.fold((e) => emit(HomeError(e)), (_) {
        final product = currentState.products.firstWhere(
          (e) => e.id == productId,
        );

        final updatedFavs = List.from(currentState.favoriteProducts)
          ..add(product);

        emit(currentState.copyWith(favoriteProducts: updatedFavs));
      });
    }
  }

  //! ================= TOGGLE Cart =================
  Future<bool> toggleCart(int productId) async {
    final result = await repo.addToCart(productId);

    return result.fold((e) => false, (_) async {
      await refreshCart();
      return true;
    });
  }

  //! ================= REMOVE FROM CART =================
  Future<void> removeFromCart(int productId) async {
    final result = await repo.removeFromCart(productId);

    result.fold((e) => emit(HomeError(e)), (_) async {
      await refreshCart();
    });
  }

  //! ================= Refres Cart =================
  Future<void> refreshCart() async {
    final result = await repo.getCart();

    result.fold((error) => emit(HomeError(error)), (cartProds) {
      cartProducts = cartProds;

      final currentState = state;
      if (currentState is HomeSuccess) {
        emit(currentState.copyWith(cartProducts: cartProducts));
      }
    });
  }

  //! ================= CHECK Cart =================
  bool isInCart(int productId) {
    return cartProducts.any((e) => e.id == productId);
  }

  //! ================= CHECK FAVORITE =================
  bool isFavorite(int productId) {
    if (state is! HomeSuccess) return false;

    final currentState = state as HomeSuccess;

    return currentState.favoriteProducts.any((e) => e.id == productId);
  }

  //! ================= NAVIGATIONS =================
  void goToProductDetails(BuildContext context, int productId) {
    Navigator.pushNamed(
      context,
      AppRoute.productDetails,
      arguments: {"id": productId, "cubit": this},
    );
  }

  void goToCategories(BuildContext context, List categories) {
    Navigator.pushNamed(context, AppRoute.categories, arguments: categories);
  }

  void goToBrands(BuildContext context, List brands) {
    Navigator.pushNamed(context, AppRoute.brands, arguments: brands);
  }

  @override
  Future<void> close() {
    searchController.dispose();
    _debounce?.cancel();
    return super.close();
  }
}
