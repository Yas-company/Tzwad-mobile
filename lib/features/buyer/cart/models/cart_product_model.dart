import 'package:faker/faker.dart';

class CartProductModel {
  int? id;
  String? productName;
  String? productImage;
  String? productPrice;
  String? priceBeforeDiscount;
  int? quantity;
  String? price;
  int? total;

  CartProductModel({
    this.id,
    this.productName,
    this.productImage,
    this.productPrice,
    this.priceBeforeDiscount,
    this.quantity,
    this.price,
    this.total,
  });

  CartProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productName = json['product_name'];
    productImage = json['product_image'];
    productPrice = json['product_price'];
    priceBeforeDiscount = json['price_before_discount'];
    quantity = json['quantity'];
    price = json['price'];
    total = json['total'];
  }

  static List<CartProductModel> fromJsonList(List<dynamic> jsonList) {
    return (jsonList).map((item) => CartProductModel.fromJson(item)).toList();
  }

  factory CartProductModel.fake({int id = 0}) {
    final faker = Faker();
    return CartProductModel(
      id: id,
      productName: faker.food.dish(),
      productImage: faker.image.image(),
      productPrice: faker.randomGenerator.decimal(min: 1, scale: 100).toString(),
      priceBeforeDiscount: faker.randomGenerator.decimal(min: 1, scale: 100).toString(),
      quantity: faker.randomGenerator.integer(10, min: 1),
      price: faker.randomGenerator.decimal(min: 1, scale: 100).toString(),
      total: faker.randomGenerator.decimal(min: 1, scale: 100).toInt(),
    );
  }

  static List<CartProductModel> generateFakeList({int count = 10}) {
    return List.generate(
      count,
      (index) => CartProductModel.fake(id: index),
    );
  }
}
