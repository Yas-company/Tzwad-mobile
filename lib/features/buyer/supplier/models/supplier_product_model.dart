import 'package:faker/faker.dart';
import 'package:tzwad_mobile/features/buyer/supplier/models/field_model.dart';
import 'package:tzwad_mobile/features/buyer/supplier/models/supplier_category_model.dart';

class SupplierProductModel {
  int? id;
  String? name;
  String? image;
  String? price;
  String? priceBeforeDiscount;
  String? quantity;
  int? stockQty;
  int? status;
  bool? isFavorite;
  int? unitType;
  SupplierCategoryModel? category;
  int? avgRating;
  bool isLoading = false;

  SupplierProductModel({
    this.id,
    this.name,
    this.image,
    this.price,
    this.priceBeforeDiscount,
    this.quantity,
    this.stockQty,
    this.status,
    this.isFavorite,
    this.unitType,
    this.category,
    this.avgRating,
  });

  SupplierProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    price = json['price'];
    priceBeforeDiscount = json['price_before_discount'];
    quantity = json['quantity'];
    stockQty = json['stock_qty'];
    status = json['status'];
    isFavorite = json['is_favorite'];
    unitType = json['unit_type'];
    category = json['category'] != null ? SupplierCategoryModel.fromJson(json['category']) : null;
    avgRating = json['avg_rating'];
  }

  static List<SupplierProductModel> fromJsonList(List<dynamic> jsonList) {
    return (jsonList).map((item) => SupplierProductModel.fromJson(item)).toList();
  }

  factory SupplierProductModel.fake({int id = 0}) {
    final faker = Faker();
    return SupplierProductModel(
      id: id,
      name: faker.person.name(),
      image: faker.image.image(),
      price: faker.randomGenerator.decimal(min: 1, scale: 100).toString(),
      priceBeforeDiscount: faker.randomGenerator.decimal(min: 1, scale: 100).toString(),
      quantity: faker.randomGenerator.integer(10, min: 1).toString(),
      stockQty: faker.randomGenerator.integer(100, min: 1),
      status: faker.randomGenerator.integer(2, min: 0),
      // Assuming status can be 0 or 1
      isFavorite: faker.randomGenerator.boolean(),
      unitType: faker.randomGenerator.integer(3, min: 1),
      // Assuming unit types are 1, 2, or 3
      category: SupplierCategoryModel.fake(),
    );
  }

  static List<SupplierProductModel> generateFakeList({int count = 10}) {
    return List.generate(
      count,
      (index) => SupplierProductModel.fake(id: index),
    );
  }
}
