import 'package:either_dart/either.dart';
import 'package:tzwad_mobile/core/network/api_service.dart';
import 'package:tzwad_mobile/core/network/error_handler.dart';
import 'package:tzwad_mobile/core/network/failure.dart';
import 'package:tzwad_mobile/features/auth/models/user_model.dart';

class AuthRepository extends ApiService {
  Future<Either<Failure, UserModel>> login({
    required String phoneNumber,
    required String password,
  }) async {
    try {
      await Future.delayed(const Duration(seconds: 3));
      return Right(UserModel.fake());
    } catch (error) {
      return Left(ErrorHandler.handle(error).failure);
    }
  }

  Future<Either<Failure, UserModel>> register({
    required String name,
    required String phoneNumber,
    required String address,
    required String password,
  }) async {
    try {
      await Future.delayed(const Duration(seconds: 2));
      return Right(UserModel.fake());
    } catch (error) {
      return Left(ErrorHandler.handle(error).failure);
    }
  }
}
