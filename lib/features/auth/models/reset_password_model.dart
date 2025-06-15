import 'package:tzwad_mobile/features/auth/models/user_model.dart';

class ResetPasswordModel {
  UserModel? user;
  String? token;

  ResetPasswordModel({
    this.user,
    this.token,
  });

  ResetPasswordModel.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? UserModel.fromJson(json['user']) : null;
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
