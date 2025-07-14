import 'package:faker/faker.dart';
import 'package:tzwad_mobile/features/buyer/supplier/models/field_model.dart';

class SupplierCategoryModel {
  int? id;
  String? name;
  String? image;
  int? supplierId;
  int? fieldId;
  int? productsCount;
  FieldModel? field;
  bool isSelected = false;

  SupplierCategoryModel({
    this.id,
    this.name,
    this.image,
    this.supplierId,
    this.fieldId,
    this.productsCount,
    this.field,
    this.isSelected = false
  });

  SupplierCategoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    supplierId = json['supplier_id'];
    fieldId = json['field_id'];
    productsCount = json['products_count'];
    field = json['field'] != null ? FieldModel.fromJson(json['field']) : null;
  }

  static List<SupplierCategoryModel> fromJsonList(List<dynamic> jsonList) {
    return (jsonList).map((item) => SupplierCategoryModel.fromJson(item)).toList();
  }

  factory SupplierCategoryModel.fake({int id = 0}) {
    final faker = Faker();
    return SupplierCategoryModel(
      id: id,
      name: faker.person.name(),
      image: faker.image.image(),
      supplierId: faker.randomGenerator.integer(1000, min: 1),
      fieldId: faker.randomGenerator.integer(100, min: 1),
      productsCount: faker.randomGenerator.integer(50, min: 0),
      field: FieldModel.fake(id: id),
    );
  }

  static List<SupplierCategoryModel> generateFakeList({int count = 10}) {
    return List.generate(
      count,
      (index) => SupplierCategoryModel.fake(id: index),
    );
  }
}
