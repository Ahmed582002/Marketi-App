import 'package:store/core/api/end_ponits.dart';
import 'package:store/features/data/models/home/review_model.dart';

class ProductModel {
  int? id;
  String? title;
  String? description;
  String? category;
  double? price;
  double? discountPercentage;
  double? rating;
  int? stock;
  List<String>? tags;
  String? brand;
  String? thumbnail;
  List<String>? images;
  List<ReviewModel>? reviews;

  ProductModel({
    this.id,
    this.title,
    this.description,
    this.category,
    this.price,
    this.discountPercentage,
    this.rating,
    this.stock,
    this.tags,
    this.brand,
    this.thumbnail,
    this.images,
    this.reviews,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json[ApiKey.productId],
      title: json[ApiKey.productTitle],
      description: json[ApiKey.productDescription],
      category: json[ApiKey.productCategory],
      price: (json[ApiKey.productPrice] as num?)?.toDouble(),
      discountPercentage: (json[ApiKey.productDiscountPercentage] as num?)
          ?.toDouble(),
      rating: (json[ApiKey.productRating] as num?)?.toDouble(),
      stock: json[ApiKey.productStock],
      tags: List<String>.from(json[ApiKey.productTags] ?? []),
      brand: json[ApiKey.productBrand],
      thumbnail: json[ApiKey.productThumbnail],
      images: List<String>.from(json[ApiKey.productImages] ?? []),
      reviews: (json[ApiKey.productReviews] as List?)
          ?.map((e) => ReviewModel.fromJson(e))
          .toList(),
    );
  }
}
