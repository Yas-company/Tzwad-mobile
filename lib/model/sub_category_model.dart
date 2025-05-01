import 'dart:convert';

SubcategoryModel subcategoryModelFromJson(String str) =>
    SubcategoryModel.fromJson(json.decode(str));

String subcategoryModelToJson(SubcategoryModel data) =>
    json.encode(data.toJson());

class SubcategoryModel {
  SubcategoryModel({
    this.subcategory,
  });

  Subcategory? subcategory;

  factory SubcategoryModel.fromJson(Map<String, dynamic> json) =>
      SubcategoryModel(
        subcategory: Subcategory.fromJson(json["subcategory"]),
      );

  Map<String, dynamic> toJson() => {
        "subcategory": subcategory!.toJson(),
      };
}

class Subcategory {
  Subcategory({
    required this.id,
    required this.title,
    this.image,
    required this.categoryId,
    this.imageUrl,
  });

  dynamic id;
  String title;
  String? image;
  dynamic categoryId;
  String? imageUrl;

  factory Subcategory.fromJson(Map<String, dynamic> json) => Subcategory(
        id: json["id"],
        title: json["title"],
        image: json["image"],
        categoryId: json["category_id"],
        imageUrl: json["image_url"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "image": image,
        "category_id": categoryId,
        "image_url": imageUrl,
      };
}
