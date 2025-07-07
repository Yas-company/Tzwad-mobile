import 'package:faker/faker.dart';

class FieldModel {
  int? id;
  String? name;
  String? image;

  FieldModel({this.id, this.name, this.image,});

  FieldModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }

  static List<FieldModel> fromJsonList(List<dynamic> jsonList) {
    return (jsonList).map((item) => FieldModel.fromJson(item)).toList();
  }

  factory FieldModel.fake({int id = 0}) {
    final faker = Faker();
    return FieldModel(
      id: id,
      name: faker.person.name(),
      image: faker.image.image(),
    );
  }

  static List<FieldModel> generateFakeList({int count = 10}) {
    return List.generate(
      count,
          (index) => FieldModel.fake(id: index),
    );
  }

}