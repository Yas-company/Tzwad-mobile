import 'package:faker/faker.dart';
import 'package:hive/hive.dart';

part 'user_model.g.dart';

@HiveType(typeId: 0)
class UserModel extends HiveObject {
  @HiveField(0)
  int? id;

  @HiveField(1)
  String? name;

  @HiveField(2)
  String? email;

  @HiveField(3)
  String? phone;

  @HiveField(4)
  String? role;

  @HiveField(5)
  bool? isVerified;

  @HiveField(6)
  String? businessName;

  @HiveField(8)
  String? address;

  @HiveField(9)
  String? licenseAttachment;

  @HiveField(10)
  String? commercialRegisterAttachment;

  @HiveField(11)
  String? image;

  @HiveField(12)
  String? status;

  @HiveField(13)
  String? fieldId;

  @HiveField(14)
  String? createdAt;

  @HiveField(15)
  String? updatedAt;

  UserModel({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.role,
    this.isVerified,
    this.businessName,
    this.address,
    this.licenseAttachment,
    this.commercialRegisterAttachment,
    this.image,
    this.status,
    this.fieldId,
    this.createdAt,
    this.updatedAt,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    role = json['role'];
    isVerified = json['is_verified'];
    businessName = json['business_name'];
    address = json['address'];
    licenseAttachment = json['license_attachment'];
    commercialRegisterAttachment = json['commercial_register_attachment'];
    image = json['image'];
    status = json['status'];
    fieldId = json['field_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['phone'] = phone;
    data['role'] = role;
    data['is_verified'] = isVerified;
    data['business_name'] = businessName;
    data['address'] = address;
    data['license_attachment'] = licenseAttachment;
    data['commercial_register_attachment'] = commercialRegisterAttachment;
    data['image'] = image;
    data['status'] = status;
    data['field_id'] = fieldId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }

  factory UserModel.fake({int id = 0}) {
    final faker = Faker();
    return UserModel(
      id: id,
      name: faker.person.name(),
      email: faker.internet.email(),
      phone: faker.lorem.word(),
      role: faker.randomGenerator.integer(2).toString(),
      isVerified: faker.randomGenerator.boolean(),
      businessName: faker.company.name(),
      address: faker.address.streetAddress(),
      licenseAttachment: faker.randomGenerator.string(10),
      commercialRegisterAttachment: faker.randomGenerator.string(10),
      status: faker.randomGenerator.string(10),
      fieldId: faker.randomGenerator.string(10),
      createdAt: faker.date.dateTime().toString(),
      updatedAt: faker.date.dateTime().toString(),
    );
  }

  static List<UserModel> generateFakeList({int count = 10}) {
    return List.generate(
      count,
      (index) => UserModel.fake(id: index),
    );
  }
}
