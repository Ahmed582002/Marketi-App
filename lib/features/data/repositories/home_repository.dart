import 'package:dartz/dartz.dart';
import 'package:store/core/api/api_consumer.dart';
import 'package:store/core/errors/exceptions.dart';
import 'package:store/features/data/models/home/brand_model.dart';
import 'package:store/features/data/models/home/category_model.dart';
import 'package:store/features/data/models/home/product_model.dart';

class HomeRepository {
  final ApiConsumer api;

  HomeRepository({required this.api});

  //! ================== Categories ==================
  Future<Either<String, List<CategoryModel>>> getCategories() async {
    try {
      final response = await api.get("/home/categories");

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
      final response = await api.get("/home/brands");

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
        "/home/products",
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
  Future<Either<String, ProductModel>> getProductDetails(int id) async {
    try {
      final response = await api.get("/home/products/$id");

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
        "/home/products/category/$category",
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
        "/home/products/brand/$brand",
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
}
