import 'package:faker/faker.dart';

class CategoryModel {
  int? id;
  String? name;
  String? image;
  bool? isActive;

  CategoryModel({
    this.id,
    this.name,
    this.image,
    this.isActive,
  });

  CategoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    isActive = json['is_active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['image'] = image;
    data['is_active'] = isActive;
    return data;
  }

  static List<CategoryModel> fromJsonList(List<dynamic> jsonList) {
    return (jsonList).map((item) => CategoryModel.fromJson(item)).toList();
  }

  factory CategoryModel.fake({int id = 0}) {
    final faker = Faker();
    return CategoryModel(
      id: id,
      name: faker.randomGenerator.string(10),
      image: faker.randomGenerator.string(10),
      isActive: faker.randomGenerator.boolean(),
    );
  }

  static List<CategoryModel> generateFakeList({int count = 10}) {
    return List.generate(
      count,
      (index) => CategoryModel.fake(id: index),
    );
  }
}
