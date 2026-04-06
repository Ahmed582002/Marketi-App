import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store/features/Presentation/viewModel/cubit/home/state/product_details_state.dart';
import 'package:store/features/data/repositories/home_repository.dart';

class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  final HomeRepository repo;

  ProductDetailsCubit(this.repo) : super(ProductDetailsInitial());

  Future<void> getProduct(int id) async {
    emit(ProductDetailsLoading());

    final result = await repo.getSingleProduct(id);

    result.fold(
      (e) => emit(ProductDetailsError(e)),
      (product) => emit(ProductDetailsSuccess(product)),
    );
  }
}
