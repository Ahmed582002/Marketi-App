import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store/features/Presentation/viewModel/cubit/home/state/home_state.dart';
import 'package:store/features/data/repositories/home_repository.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeRepository repo;

  HomeCubit(this.repo) : super(HomeInitial());

  int currentIndex = 0;

  void changeBottomNav(int index) {
    currentIndex = index;
    emit(state); // refresh UI
  }

  // Load All Data
  Future<void> loadHome() async {
    emit(HomeLoading());

    final categoriesResult = await repo.getCategories();
    final brandsResult = await repo.getBrands();
    final productsResult = await repo.getProducts();

    categoriesResult.fold((error) => emit(HomeError(error)), (categories) {
      brandsResult.fold((error) => emit(HomeError(error)), (brands) {
        productsResult.fold((error) => emit(HomeError(error)), (products) {
          emit(
            HomeSuccess(
              categories: categories,
              brands: brands,
              products: products,
            ),
          );
        });
      });
    });
  }
}
