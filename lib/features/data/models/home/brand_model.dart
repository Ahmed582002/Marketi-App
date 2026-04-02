class BrandModel {
  String? name;
  String? emoji;

  BrandModel({this.name, this.emoji});

  factory BrandModel.fromJson(Map<String, dynamic> json) {
    return BrandModel(name: json['name'], emoji: json['emoji']);
  }
}
