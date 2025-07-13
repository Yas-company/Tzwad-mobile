import 'package:faker/faker.dart';

class CartProductModel {
  int? id;
  String? name;

  CartProductModel({
    this.id,
    this.name,
  });

  CartProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  static List<CartProductModel> fromJsonList(List<dynamic> jsonList) {
    return (jsonList).map((item) => CartProductModel.fromJson(item)).toList();
  }

  factory CartProductModel.fake({int id = 0}) {
    final faker = Faker();
    return CartProductModel(
      id: id,
      name: faker.person.name(),
    );
  }

  static List<CartProductModel> generateFakeList({int count = 10}) {
    return List.generate(
      count,
          (index) => CartProductModel.fake(id: index),
    );
  }
}
