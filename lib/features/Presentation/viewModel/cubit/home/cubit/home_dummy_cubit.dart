import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store/core/constants/home_dummy_data.dart';
import 'package:store/features/Presentation/viewModel/cubit/home/state/home_dummy_state.dart';

class HomeDummyCubit extends Cubit<HomeDummyState> {
  HomeDummyCubit() : super(HomeInitial());

  void getProducts() async {
    emit(HomeLoading());

    await Future.delayed(const Duration(seconds: 1)); // simulate API

    try {
      final products = HomeDummyData.products;
      emit(HomeSuccess(products));
    } catch (e) {
      emit(HomeError("Something went wrong"));
    }
  }
}
