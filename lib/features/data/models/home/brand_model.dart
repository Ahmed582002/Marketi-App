import 'package:store/core/api/end_ponits.dart';

class BrandModel {
  String? name;
  String? emoji;

  BrandModel({this.name, this.emoji});

  factory BrandModel.fromJson(Map<String, dynamic> json) {
    return BrandModel(
      name: json[ApiKey.brandName],
      emoji: json[ApiKey.brandEmoji],
    );
  }
}
