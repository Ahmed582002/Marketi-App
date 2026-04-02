class CategoryModel {
  String? slug;
  String? name;
  String? url;
  String? image;

  CategoryModel({this.slug, this.name, this.url, this.image});

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      slug: json['slug'],
      name: json['name'],
      url: json['url'],
      image: json['image'],
    );
  }
}
