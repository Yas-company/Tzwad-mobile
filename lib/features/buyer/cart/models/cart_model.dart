import 'package:faker/faker.dart';

import 'cart_product_model.dart';

class CartModel {
  int? id;
  int? userId;
  List<CartProductModel>? products;

  CartModel({
    this.id,
    this.userId,
    this.products,
  });

  CartModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    if (json['products'] != null) {
      products = <CartProductModel>[];
      products = CartProductModel.fromJsonList(json['products']);
    }
  }

  static List<CartModel> fromJsonList(List<dynamic> jsonList) {
    return (jsonList).map((item) => CartModel.fromJson(item)).toList();
  }

  factory CartModel.fake({int id = 0}) {
    final faker = Faker();
    return CartModel(
      id: id,
      userId: faker.randomGenerator.integer(1000, min: 1),
      products: CartProductModel.generateFakeList(count: 5),
    );
  }

  static List<CartModel> generateFakeList({int count = 10}) {
    return List.generate(
      count,
      (index) => CartModel.fake(id: index),
    );
  }
}
