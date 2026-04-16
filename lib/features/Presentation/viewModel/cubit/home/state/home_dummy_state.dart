abstract class HomeDummyState {}

class HomeInitial extends HomeDummyState {}

class HomeLoading extends HomeDummyState {}

class HomeSuccess extends HomeDummyState {
  final List products;

  HomeSuccess(this.products);
}

class HomeError extends HomeDummyState {
  final String message;

  HomeError(this.message);
}
