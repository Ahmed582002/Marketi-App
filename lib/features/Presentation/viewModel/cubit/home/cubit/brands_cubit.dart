import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store/core/constants/home_dummy_data.dart';
import 'package:store/features/Presentation/viewModel/cubit/home/state/brands_state.dart';

class BrandsCubit extends Cubit<BrandsState> {
  BrandsCubit() : super(BrandsInitial());

  void getBrands() {
    emit(BrandsLoaded(HomeDummyData.brands));
  }
}
