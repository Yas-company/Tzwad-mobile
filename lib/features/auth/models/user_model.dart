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

  @HiveField(7)
  String? licId;

  @HiveField(8)
  String? address;

  @HiveField(9)
  String? location;

  @HiveField(10)
  String? createdAt;

  @HiveField(11)
  String? updatedAt;

  UserModel({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.role,
    this.isVerified,
    this.businessName,
    this.licId,
    this.address,
    this.location,
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
    licId = json['lic_id'];
    address = json['address'];
    location = json['location'];
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
    data['lic_id'] = licId;
    data['address'] = address;
    data['location'] = location;
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
      phone: faker.phoneNumber.us(),
      role: faker.randomGenerator.string(10),
      isVerified: faker.randomGenerator.boolean(),
      businessName: faker.randomGenerator.string(10),
      licId: faker.randomGenerator.string(10),
      address: faker.randomGenerator.string(10),
      location: faker.randomGenerator.string(10),
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
