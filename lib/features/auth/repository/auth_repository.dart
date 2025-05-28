import 'package:tzwad_mobile/core/network/api_service.dart';
import 'package:tzwad_mobile/core/network/constants_api.dart';
import 'package:tzwad_mobile/core/network/error_handler.dart';
import 'package:tzwad_mobile/core/network/failure.dart';
import 'package:tzwad_mobile/core/util/state_render/result.dart';
import 'package:tzwad_mobile/core/util/unit.dart';
import 'package:tzwad_mobile/features/auth/models/login_model.dart';
import 'package:tzwad_mobile/features/auth/models/otp_flow_type.dart';
import 'package:tzwad_mobile/features/auth/models/register_model.dart';
import 'package:tzwad_mobile/features/auth/models/user_model.dart';
import 'package:tzwad_mobile/features/auth/models/verify_otp_model.dart';
import 'package:tzwad_mobile/features/auth/local_data/user_local_data.dart';
import 'package:tzwad_mobile/features/generic/local_data/setting_local_data.dart';

class AuthRepository {
  final ApiService apiService;
  final UserLocalData userLocalData;
  final SettingLocalData settingLocalData;

  AuthRepository({
    required this.apiService,
    required this.userLocalData,
    required this.settingLocalData,
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
      _saveData(
        user: response.data?.user,
        token: response.data?.token,
        isRememberMe: isRememberMe,
      );
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
          'latitude': latitude,
          'longitude': longitude,
          'business_name': businessName,
          'lic_id': '',
          'email': '',
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
      if (otpFlowType == OtpFlowType.register) {
        _saveData(
          user: response.data?.user,
          token: response.data?.token,
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

  Future<Result<Failure, Unit>> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    try {
      await apiService.post(
        url: ConstantsApi.changePasswordUrl,
        data: {
          'current_password': currentPassword,
          'password': newPassword,
          'password_confirmation': newPassword,
        },
      );
      return const Right(unit);
    } catch (error) {
      return Left(ErrorHandler.handle(error).failure);
    }
  }

  Future<Result<Failure, Unit>> deleteAccount() async {
    try {
      await apiService.delete<Unit>(
        url: ConstantsApi.deleteAccountUrl,
      );
      return const Right(unit);
    } catch (error) {
      return Left(ErrorHandler.handle(error).failure);
    }
  }

  Future<Result<Failure, Unit>> logout() async {
    try {
      await apiService.post<Unit>(
        url: ConstantsApi.logoutUrl,
      );
      _clearData();
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
      userLocalData.setUserInfo(user!);
      settingLocalData.setToken(token!);
    }
    if (isRememberMe) {
      settingLocalData.setUserLogged();
    }
  }

  void _clearData() {}
}
