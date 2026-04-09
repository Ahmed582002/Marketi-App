abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomePaginationLoading extends HomeState {}

class HomeSuccess extends HomeState {
  final List categories;
  final List brands;
  final List products;
  final List favoriteProducts;
  final List cartProducts;

  HomeSuccess({
    required this.categories,
    required this.brands,
    required this.products,
    required this.favoriteProducts,
    required this.cartProducts,
  });

  HomeSuccess copyWith({
    List? categories,
    List? brands,
    List? products,
    List? favoriteProducts,
    List? cartProducts,
  }) {
    return HomeSuccess(
      categories: categories ?? this.categories,
      brands: brands ?? this.brands,
      products: products ?? this.products,
      favoriteProducts: favoriteProducts ?? this.favoriteProducts,
      cartProducts: cartProducts ?? this.cartProducts,
    );
  }
}

class HomeError extends HomeState {
  final String message;

  HomeError(this.message);
}
