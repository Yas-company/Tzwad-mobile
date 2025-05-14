import 'package:tzwad_mobile/features/auth/models/user_model.dart';

class RegisterModel {
  UserModel? user;
  String? message;
  bool? requiresVerification;

  RegisterModel({
    this.user,
    this.message,
    this.requiresVerification,
  });

  RegisterModel.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? UserModel.fromJson(json['user']) : null;
    message = json['message'];
    requiresVerification = json['requires_verification'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (user != null) {
      data['user'] = user!.toJson();
    }
    data['message'] = message;
    data['requires_verification'] = requiresVerification;
    return data;
  }
}
