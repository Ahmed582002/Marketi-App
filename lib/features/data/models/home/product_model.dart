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
      id: json['id'],
      title: json['title'],
      description: json['description'],
      category: json['category'],
      price: (json['price'] as num?)?.toDouble(),
      discountPercentage: (json['discountPercentage'] as num?)?.toDouble(),
      rating: (json['rating'] as num?)?.toDouble(),
      stock: json['stock'],
      tags: List<String>.from(json['tags'] ?? []),
      brand: json['brand'],
      thumbnail: json['thumbnail'],
      images: List<String>.from(json['images'] ?? []),
      reviews: (json['reviews'] as List?)
          ?.map((e) => ReviewModel.fromJson(e))
          .toList(),
    );
  }
}
