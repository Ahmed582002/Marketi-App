abstract class CategoriesState {}

class CategoriesInitial extends CategoriesState {}

class CategoriesLoaded extends CategoriesState {
  final List categories;

  CategoriesLoaded(this.categories);
}
