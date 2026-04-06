import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store/core/constants/routes.dart';
import 'package:store/features/Presentation/viewModel/cubit/home/state/home_state.dart';
import 'package:store/features/data/repositories/home_repository.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeRepository repo;

  HomeCubit(this.repo) : super(HomeInitial());

  int currentIndex = 0;
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
    emit(
      HomeSuccess(
        categories: categories,
        brands: brands,
        products: products,
        hasMore: hasMore,
      ),
    );
  }

  //! ================= INITIAL LOAD =================
  Future<void> loadHome() async {
    emit(HomeLoading());

    final catRes = await repo.getCategories();
    final brandRes = await repo.getBrands();
    final prodRes = await repo.getProducts();

    catRes.fold((e) => emit(HomeError(e)), (cats) {
      brandRes.fold((e) => emit(HomeError(e)), (brs) {
        prodRes.fold((e) => emit(HomeError(e)), (prods) {
          categories = cats;
          brands = brs;
          products = prods;
          skip = prods.length;

          emit(
            HomeSuccess(
              categories: categories,
              brands: brands,
              products: products,
              hasMore: true,
            ),
          );
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

        emit(
          HomeSuccess(
            categories: categories,
            brands: brands,
            products: products,
            hasMore: hasMore,
          ),
        );
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
      emit(
        HomeSuccess(
          categories: currentState.categories,
          brands: currentState.brands,
          products: data["products"],
          hasMore: data["total"] > data["products"].length,
        ),
      );
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
    emit(HomeLoading());

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

      emit(
        HomeSuccess(
          categories: categories,
          brands: brands,
          products: products,
          hasMore: hasMore,
        ),
      );
    });
  }

  //! ========== Navigate To Product Details ============
  void goToProductDetails(BuildContext context, int productId) {
    Navigator.pushNamed(context, AppRoute.productDetails, arguments: productId);
  }

  //! ========== Navigate To Categories ============
  void goToCategories(BuildContext context, List categories) {
    Navigator.pushNamed(context, AppRoute.categories, arguments: categories);
  }

  //! ========== Navigate To Brands ============
  void goToBrands(BuildContext context, List brands) {
    Navigator.pushNamed(context, AppRoute.brands, arguments: brands);
  }
}
