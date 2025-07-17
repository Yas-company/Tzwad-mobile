import 'package:faker/faker.dart';

class AddressModel {
  int? id;
  String? name;
  String? street;
  String? city;
  String? phone;
  String? latitude;
  String? longitude;
  bool? isDefault;
  String? createdAt;
  String? updatedAt;

  AddressModel({
    this.id,
    this.name,
    this.street,
    this.city,
    this.phone,
    this.latitude,
    this.longitude,
    this.isDefault,
    this.createdAt,
    this.updatedAt,
  });

  AddressModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    street = json['street'];
    city = json['city'];
    phone = json['phone'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    isDefault = json['is_default'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  static List<AddressModel> fromJsonList(List<dynamic> jsonList) {
    return (jsonList).map((item) => AddressModel.fromJson(item)).toList();
  }

  factory AddressModel.fake({int id = 0}) {
    final faker = Faker();
    return AddressModel(
      id: id,
      name: faker.address.streetAddress(),
      street: faker.address.streetName(),
      city: faker.address.city(),
      latitude: faker.geo.latitude().toString(),
      longitude: faker.geo.longitude().toString(),
    );
  }

  static List<AddressModel> generateFakeList({int count = 10}) {
    return List.generate(
      count,
      (index) => AddressModel.fake(id: index),
    );
  }
}
