abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeSuccess extends HomeState {
  final List categories;
  final List brands;
  final List products;

  HomeSuccess({
    required this.categories,
    required this.brands,
    required this.products,
  });
}

class HomeError extends HomeState {
  final String message;

  HomeError(this.message);
}
