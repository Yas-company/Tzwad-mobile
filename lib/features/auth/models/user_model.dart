import 'package:faker/faker.dart';

class UserModel {
  final int? id;
  final String? name;
  final String? email;
  final String? phone;
  final String? image;
  final String? token;

  UserModel({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.image,
    this.token,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      image: json['image'],
      token: json['token'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'image': image,
      'token': token,
    };
  }

  factory UserModel.fake({int id = 0}) {
    final faker = Faker();
    return UserModel(
      id: id,
      name: faker.person.name(),
      email: faker.internet.email(),
      phone: faker.phoneNumber.toString(),
      image: '',
      token: faker.guid.guid(),
    );
  }

  static List<UserModel> generateFakeList({int count = 10}) {
    return List.generate(
      count,
      (index) => UserModel.fake(id: index),
    );
  }
}
