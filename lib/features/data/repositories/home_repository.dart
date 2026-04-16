import 'package:dartz/dartz.dart';
import 'package:store/core/api/api_consumer.dart';
import 'package:store/core/api/end_ponits.dart';
import 'package:store/core/errors/exceptions.dart';
import 'package:store/features/Presentation/viewModel/cache/cache_helper.dart';
import 'package:store/features/data/models/home/brand_model.dart';
import 'package:store/features/data/models/home/category_model.dart';
import 'package:store/features/data/models/home/product_model.dart';

class HomeRepository {
  final ApiConsumer api;

  HomeRepository({required this.api});

  //! ================== Categories ==================
  Future<Either<String, List<CategoryModel>>> getCategories() async {
    try {
      final response = await api.get(EndPoint.categories);

      final list = (response['list'] as List)
          .map((e) => CategoryModel.fromJson(e))
          .toList();

      return Right(list);
    } on ServerException catch (e) {
      return Left(e.errModel.errorMessage);
    }
  }

  //! ================== Brands ==================
  Future<Either<String, List<BrandModel>>> getBrands() async {
    try {
      final response = await api.get(EndPoint.brands);

      final list = (response['list'] as List)
          .map((e) => BrandModel.fromJson(e))
          .toList();

      return Right(list);
    } on ServerException catch (e) {
      return Left(e.errModel.errorMessage);
    }
  }

  //! ================== Products ==================
  Future<Either<String, List<ProductModel>>> getProducts({
    int skip = 0,
    int limit = 10,
  }) async {
    try {
      final response = await api.get(
        EndPoint.products,
        queryParameters: {"skip": skip, "limit": limit},
      );

      final list = (response['list'] as List)
          .map((e) => ProductModel.fromJson(e))
          .toList();

      return Right(list);
    } on ServerException catch (e) {
      return Left(e.errModel.errorMessage);
    }
  }

  //! ================== Product Details ==================
  Future<Either<String, ProductModel>> getSingleProduct(int id) async {
    try {
      final response = await api.get("${EndPoint.products}/$id");

      return Right(ProductModel.fromJson(response));
    } on ServerException catch (e) {
      return Left(e.errModel.errorMessage);
    }
  }

  //! ================== Products By Category ==================
  Future<Either<String, List<ProductModel>>> getProductsByCategory({
    required String category,
    int skip = 0,
    int limit = 10,
  }) async {
    try {
      final response = await api.get(
        "${EndPoint.productsByCategory}/$category",
        queryParameters: {"skip": skip, "limit": limit},
      );

      final list = (response['list'] as List)
          .map((e) => ProductModel.fromJson(e))
          .toList();

      return Right(list);
    } on ServerException catch (e) {
      return Left(e.errModel.errorMessage);
    }
  }

  //! ================== Products By Brand ==================
  Future<Either<String, List<ProductModel>>> getProductsByBrand({
    required String brand,
    int skip = 0,
    int limit = 10,
  }) async {
    try {
      final response = await api.get(
        "${EndPoint.productsByBrand}/$brand",
        queryParameters: {"skip": skip, "limit": limit},
      );

      final list = (response['list'] as List)
          .map((e) => ProductModel.fromJson(e))
          .toList();

      return Right(list);
    } on ServerException catch (e) {
      return Left(e.errModel.errorMessage);
    }
  }

  //! ================== Filter ==================
  Future<Either<String, Map<String, dynamic>>> filterProducts({
    int skip = 0,
    int limit = 10,
    String? search,
    String? brand,
    String? category,
    String? rating,
    String? price,
    String? discount,
    bool? popular,
  }) async {
    try {
      final response = await api.post(
        EndPoint.productsFilter,
        data: {
          "skip": skip,
          "limit": limit,
          "search": search,
          "brand": brand,
          "category": category,
          "rating": rating,
          "price": price,
          "discount": discount,
          "popular": popular,
        },
      );

      final list = (response['list'] as List)
          .map((e) => ProductModel.fromJson(e))
          .toList();

      return Right({
        "products": list,
        "total": response['total'],
        "skip": response['skip'],
        "limit": response['limit'],
      });
    } on ServerException catch (e) {
      return Left(e.errModel.errorMessage);
    }
  }

  //! ================== Add To Favorite ==================
  Future<Either<String, String>> addFavorite(int productId) async {
    try {
      final response = await api.post(
        EndPoint.addFavorite,
        data: {"productId": productId},
      );

      return Right(response["message"]);
    } on ServerException catch (e) {
      return Left(e.errModel.errorMessage);
    }
  }

  //! ================== Remove From Favorite ==================
  Future<Either<String, String>> removeFavorite(int productId) async {
    try {
      final response = await api.delete(
        EndPoint.deleteFavorite,
        data: {"productId": productId},
      );

      return Right(response["message"]);
    } on ServerException catch (e) {
      return Left(e.errModel.errorMessage);
    }
  }

  //! ================== Get Favorite ==================
  Future<Either<String, List<ProductModel>>> getFavorites() async {
    try {
      final response = await api.get(EndPoint.getFavorite);

      final list = (response['list'] as List)
          .map((e) => ProductModel.fromJson(e))
          .toList();

      return Right(list);
    } on ServerException catch (e) {
      return Left(e.errModel.errorMessage);
    }
  }

  //! ================== Add To Cart ==================
  Future<Either<String, String>> addToCart(int productId) async {
    try {
      final response = await api.post(
        EndPoint.addCart,
        data: {"productId": productId},
      );

      return Right(response["message"]);
    } on ServerException catch (e) {
      return Left(e.errModel.errorMessage);
    }
  }

  //! ================== Remove From Cart ==================
  Future<Either<String, String>> removeFromCart(int productId) async {
    try {
      final response = await api.delete(
        EndPoint.deleteCart,
        data: {"productId": productId.toString()},
      );

      return Right(response["message"]);
    } on ServerException catch (e) {
      return Left(e.errModel.errorMessage);
    }
  }

  //! ================== Get Cart ==================
  Future<Either<String, List<ProductModel>>> getCart() async {
    try {
      final response = await api.get(EndPoint.getCart);

      final list = (response['list'] as List)
          .map((e) => ProductModel.fromJson(e))
          .toList();

      return Right(list);
    } on ServerException catch (e) {
      return Left(e.errModel.errorMessage);
    }
  }

  void saveFavorites(List<int> ids) {
    CacheHelper().saveData(key: "favorites", value: ids);
  }

  List<int> getSavedFavorites() {
    return List<int>.from(CacheHelper().getData(key: "favorites") ?? []);
  }
}
