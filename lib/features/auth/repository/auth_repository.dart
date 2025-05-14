import 'package:tzwad_mobile/core/network/api_service.dart';
import 'package:tzwad_mobile/core/network/constants_api.dart';
import 'package:tzwad_mobile/core/network/error_handler.dart';
import 'package:tzwad_mobile/core/network/failure.dart';
import 'package:tzwad_mobile/core/local_data/app_preferences.dart';
import 'package:tzwad_mobile/core/util/state_render/result.dart';
import 'package:tzwad_mobile/core/util/unit.dart';
import 'package:tzwad_mobile/features/auth/models/login_model.dart';
import 'package:tzwad_mobile/features/auth/models/otp_flow_type.dart';
import 'package:tzwad_mobile/features/auth/models/register_model.dart';
import 'package:tzwad_mobile/features/auth/models/user_model.dart';
import 'package:tzwad_mobile/features/auth/models/verify_otp_model.dart';

class AuthRepository {
  final ApiService apiService;
  final AppPreferences appPrefs;

  AuthRepository({
    required this.apiService,
    required this.appPrefs,
  });

  Future<Result<Failure, Unit>> login({
    required String phoneNumber,
    required String password,
    required bool isRememberMe,
  }) async {
    try {
      final response = await apiService.post<LoginModel>(
        url: ConstantsApi.loginUrl,
        data: {
          'phone': phoneNumber,
          'password': password,
        },
        fromJsonT: LoginModel.fromJson,
      );
      if (response != null) {
        _saveData(
          user: response.user,
          token: response.token,
          isRememberMe: isRememberMe,
        );
      }
      return const Right(unit);
    } catch (error) {
      return Left(ErrorHandler.handle(error).failure);
    }
  }

  Future<Result<Failure, Unit>> register({
    required String name,
    required String phoneNumber,
    required String businessName,
    required String address,
    required String password,
    double latitude = 0.0,
    double longitude = 0.0,
  }) async {
    try {
      await apiService.post<RegisterModel>(
        url: ConstantsApi.registerUrl,
        data: {
          'name': name,
          'phone': phoneNumber,
          'country_code': '966',
          'address': address,
          'location': '$latitude, $longitude',
          'business_name': businessName,
          'lic_id': '$name, $businessName',
          'email': '$name@$businessName.com',
          'password': password,
          'password_confirmation': password,
        },
        fromJsonT: RegisterModel.fromJson,
      );
      return const Right(unit);
    } catch (error) {
      return Left(ErrorHandler.handle(error).failure);
    }
  }

  Future<Result<Failure, Unit>> verifyOtp({
    required String phoneNumber,
    required String otp,
    required OtpFlowType otpFlowType,
  }) async {
    try {
      final response = await apiService.post<VerifyOtpModel>(
        url: ConstantsApi.verifyOtpUrl,
        data: {
          'phone': phoneNumber,
          'otp': otp,
        },
        fromJsonT: otpFlowType == OtpFlowType.register ? VerifyOtpModel.fromJson : null,
      );
      if (otpFlowType == OtpFlowType.register && response != null) {
        _saveData(
          user: response.user,
          token: response.token,
        );
      }
      return const Right(unit);
    } catch (error) {
      return Left(ErrorHandler.handle(error).failure);
    }
  }

  Future<Result<Failure, Unit>> forgetPassword({
    required String phoneNumber,
  }) async {
    try {
      await apiService.post(
        url: ConstantsApi.forgotPasswordUrl,
        data: {
          'phone': phoneNumber,
        },
      );
      return const Right(unit);
    } catch (error) {
      return Left(ErrorHandler.handle(error).failure);
    }
  }

  Future<Result<Failure, Unit>> resetPassword({
    required String phoneNumber,
    required String newPassword,
  }) async {
    try {
      await apiService.post(
        url: ConstantsApi.resetPasswordUrl,
        data: {
          'phone': phoneNumber,
          'password': newPassword,
          'password_confirmation': newPassword,
        },
      );
      return const Right(unit);
    } catch (error) {
      return Left(ErrorHandler.handle(error).failure);
    }
  }

  void _saveData({
    required UserModel? user,
    required String? token,
    bool isRememberMe = true,
  }) {
    if (user != null || token != null) {
      appPrefs.setUserInfo(
        user!,
        token ?? '',
      );
    }
    if (isRememberMe) {
      appPrefs.setUserLogged();
    }
  }
}
