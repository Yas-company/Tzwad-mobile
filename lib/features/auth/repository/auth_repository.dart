import 'package:tzwad_mobile/core/network/api_service.dart';
import 'package:tzwad_mobile/core/network/constants_api.dart';
import 'package:tzwad_mobile/core/network/error_handler.dart';
import 'package:tzwad_mobile/core/network/failure.dart';
import 'package:tzwad_mobile/core/util/state_render/result.dart';
import 'package:tzwad_mobile/core/util/unit.dart';
import 'package:tzwad_mobile/features/auth/models/login_model.dart';
import 'package:tzwad_mobile/features/auth/models/otp_flow_type.dart';
import 'package:tzwad_mobile/features/auth/models/register_model.dart';
import 'package:tzwad_mobile/features/auth/models/reset_password_model.dart';
import 'package:tzwad_mobile/features/auth/models/role_enum.dart';
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

  //region Buyer

  Future<Result<Failure, Unit>> loginBuyer({
    required String phoneNumber,
    required String password,
    required RoleEnum role,
  }) async {
    try {
      final response = await apiService.post<LoginModel>(
        url: ConstantsApi.loginUrl,
        data: {
          'phone': phoneNumber,
          'password': password,
          'role': role.value,
        },
        fromJsonT: LoginModel.fromJson,
      );
      _saveData(
        user: response.data?.user,
        token: response.data?.token,
      );
      return const Right(unit);
    } catch (error) {
      return Left(ErrorHandler.handle(error).failure);
    }
  }

  Future<Result<Failure, Unit>> registerBuyer({
    required String name,
    required String phoneNumber,
    required String businessName,
    required String password,
    required RoleEnum role,
    required String nameAddress,
    required String street,
    required String city,
    required double latitude,
    required double longitude,
  }) async {
    try {
      await apiService.post<RegisterModel>(
        url: ConstantsApi.registerUrl,
        data: {
          'name': name,
          'phone': phoneNumber,
          'country_code': '966',
          'latitude': latitude,
          'longitude': longitude,
          'business_name': businessName,
          'email': '',
          'password': password,
          'password_confirmation': password,
          'role': role.value,
          'address': {
            'name': nameAddress,
            'street': street,
            'city': city,
            'phone': phoneNumber,
            'latitude': latitude,
            'longitude': longitude,
          }
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
      final response = await apiService.post<ResetPasswordModel>(
        url: ConstantsApi.resetPasswordUrl,
        data: {
          'phone': phoneNumber,
          'password': newPassword,
          'password_confirmation': newPassword,
        },
        fromJsonT: ResetPasswordModel.fromJson,
      );
      _saveData(
        user: response.data?.user,
        token: response.data?.token,
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
      await _clearData();
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
      await _clearData();
      return const Right(unit);
    } catch (error) {
      return Left(ErrorHandler.handle(error).failure);
    }
  }

  //endregion

  //region Supplier

  Future<Result<Failure, Unit>> loginSupplier({
    required String phoneNumber,
    required String password,
    required RoleEnum role,
  }) async {
    try {
      final response = await apiService.post<LoginModel>(
        url: ConstantsApi.loginUrl,
        data: {
          'phone': phoneNumber,
          'password': password,
          'role': role.value,
        },
        fromJsonT: LoginModel.fromJson,
      );
      _saveData(
        user: response.data?.user,
        token: response.data?.token,
      );
      return const Right(unit);
    } catch (error) {
      return Left(ErrorHandler.handle(error).failure);
    }
  }

  Future<Result<Failure, Unit>> registerSupplier({
    required String name,
    required String phoneNumber,
    required String businessName,
    required String address,
    required String password,
    required double latitude,
    required double longitude,
    required RoleEnum role,
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
          'email': '',
          'password': password,
          'password_confirmation': password,
          'role': role.value,
        },
        fromJsonT: RegisterModel.fromJson,
      );
      return const Right(unit);
    } catch (error) {
      return Left(ErrorHandler.handle(error).failure);
    }
  }

  //endregion

  //region Shared Methods

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

  Future<void> _clearData() async {
    await Future.wait(
      [
        userLocalData.clearBox(),
        settingLocalData.clearBox(),
      ],
    );
  }

//endregion
}
