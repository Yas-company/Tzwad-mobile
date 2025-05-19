import 'package:faker/faker.dart';
import 'package:hive/hive.dart';
import 'package:tzwad_mobile/features/category/models/category_model.dart';

part 'product_model.g.dart';

@HiveType(typeId: 2)
class ProductModel extends HiveObject {
  @HiveField(0)
  int? id;

  @HiveField(1)
  String? name;

  @HiveField(2)
  String? image;

  @HiveField(3)
  String? price;

  @HiveField(4)
  int? stockQty;

  // @HiveField(5)
  CategoryModel? category;

  @HiveField(5)
  String? createdAt;

  @HiveField(6)
  String? updatedAt;

  @HiveField(7)
  bool isFavorite = false;

  @HiveField(8)
  int quantity = 1;

  ProductModel({
    this.id,
    this.name,
    this.image,
    this.price,
    this.stockQty,
    this.category,
    this.createdAt,
    this.updatedAt,
  });

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    price = json['price'];
    stockQty = json['stock_qty'];
    category = json['category'] != null ? CategoryModel.fromJson(json['category']) : null;
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  static List<ProductModel> fromJsonList(List<dynamic> jsonList) {
    return (jsonList).map((item) => ProductModel.fromJson(item)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['image'] = image;
    data['price'] = price;
    data['stock_qty'] = stockQty;
    if (category != null) {
      data['category'] = category!.toJson();
    }
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }

  factory ProductModel.fake({int id = 0}) {
    final faker = Faker();
    return ProductModel(
      id: id,
      name: faker.randomGenerator.string(10),
      image: faker.randomGenerator.string(10),
      price: faker.randomGenerator.string(10),
      stockQty: faker.randomGenerator.integer(10),
      createdAt: faker.date.dateTime().toString(),
      updatedAt: faker.date.dateTime().toString(),
    );
  }

  static List<ProductModel> generateFakeList({int count = 10}) {
    return List.generate(
      count,
      (index) => ProductModel.fake(id: index),
    );
  }
}
