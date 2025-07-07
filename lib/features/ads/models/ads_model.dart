import 'package:faker/faker.dart';

class AdsModel {
  int? id;
  String? title;
  String? description;
  String? image;
  int? userId;
  bool? isActive;

  AdsModel({
    this.id,
    this.title,
    this.description,
    this.image,
    this.userId,
    this.isActive,
  });

  AdsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    image = json['image'];
    userId = json['user_id'];
    isActive = json['is_active'];
  }

  static List<AdsModel> fromJsonList(List<dynamic> jsonList) {
    return (jsonList).map((item) => AdsModel.fromJson(item)).toList();
  }

  factory AdsModel.fake({int id = 0}) {
    final faker = Faker();
    return AdsModel(
      id: id,
      isActive: faker.randomGenerator.boolean(),
      title: faker.lorem.sentence(),
      description: faker.lorem.sentence(),
      userId: faker.randomGenerator.integer(1000, min: 1),
    );
  }

  static List<AdsModel> generateFakeList({int count = 10}) {
    return List.generate(
      count,
          (index) => AdsModel.fake(id: index),
    );
  }
}
