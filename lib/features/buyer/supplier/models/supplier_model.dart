import 'package:faker/faker.dart';

import 'field_model.dart';

class SupplierModel {
  int? id;
  String? name;
  String? image;
  double? rating;
  List<FieldModel>? fields;

  SupplierModel({
    this.id,
    this.name,
    this.image,
    this.rating,
    this.fields,
  });

  SupplierModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    rating = json['rating'];
    if (json['fields'] != null) {
      fields = <FieldModel>[];
      fields = FieldModel.fromJsonList(json['fields']);
    }
  }

  static List<SupplierModel> fromJsonList(List<dynamic> jsonList) {
    return (jsonList).map((item) => SupplierModel.fromJson(item)).toList();
  }

  factory SupplierModel.fake({int id = 0}) {
    final faker = Faker();
    return SupplierModel(
      id: id,
      name: faker.person.name(),
      image: faker.image.image(),
      rating: 0.4,
      fields: FieldModel.generateFakeList(),
    );
  }

  static List<SupplierModel> generateFakeList({int count = 10}) {
    return List.generate(
      count,
          (index) => SupplierModel.fake(id: index),
    );
  }
}
