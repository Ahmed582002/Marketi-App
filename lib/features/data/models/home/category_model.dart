import 'package:store/core/api/end_ponits.dart';

class CategoryModel {
  String? slug;
  String? name;
  String? url;
  String? image;

  CategoryModel({this.slug, this.name, this.url, this.image});

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      slug: json[ApiKey.categorieSlug],
      name: json[ApiKey.categorieName],
      url: json[ApiKey.categorieUrl],
      image: json[ApiKey.categorieImage],
    );
  }
}
