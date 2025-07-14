import 'package:faker/faker.dart';

import 'cart_model.dart';
import 'supplier_requirement_model.dart';

class CartInfoModel {
  CartModel? cart;
  int? total;
  int? totalDiscount;
  List<SupplierRequirementModel>? supplierRequirements;

  CartInfoModel({
    this.cart,
    this.total,
    this.totalDiscount,
    this.supplierRequirements,
  });

  CartInfoModel.fromJson(Map<String, dynamic> json) {
    cart = json['cart'] != null ? CartModel.fromJson(json['cart']) : null;
    total = json['total'];
    totalDiscount = json['total_discount'];
    if (json['supplier_requirements'] != null) {
      supplierRequirements = <SupplierRequirementModel>[];
      supplierRequirements = SupplierRequirementModel.fromJsonList(json['supplier_requirements']);
    }
  }

  factory CartInfoModel.fake({int id = 0}) {
    final faker = Faker();
    return CartInfoModel(
      cart: CartModel.fake(id: id),
      total: faker.randomGenerator.integer(1000, min: 1),
      totalDiscount: faker.randomGenerator.integer(100, min: 0),
      // supplierRequirements: [],
    );
  }

  static List<CartInfoModel> generateFakeList({int count = 10}) {
    return List.generate(
      count,
      (index) => CartInfoModel.fake(id: index),
    );
  }
}
