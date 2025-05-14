import 'package:tzwad_mobile/features/auth/models/user_model.dart';

class LoginModel {
  UserModel? user;
  String? token;

  LoginModel({
    this.user,
    this.token,
  });

  LoginModel.fromJson(Map<String, dynamic> json) {
    user = json['user1'] != null ? UserModel.fromJson(json['user']) : null;
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (user != null) {
      data['user'] = user!.toJson();
    }
    data['token'] = token;
    return data;
  }
}
