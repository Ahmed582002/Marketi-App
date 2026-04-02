import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store/core/constants/home_dummy_data.dart';
import 'package:store/features/Presentation/viewModel/cubit/home/state/categories_state.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  CategoriesCubit() : super(CategoriesInitial());

  void getCategories() {
    emit(CategoriesLoaded(HomeDummyData.categories));
  }
}
