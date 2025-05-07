import 'package:either_dart/either.dart';
import 'package:tzwad_mobile/core/network/api_service.dart';
import 'package:tzwad_mobile/core/network/error_handler.dart';
import 'package:tzwad_mobile/core/network/failure.dart';

class AuthRepository extends ApiService {
  Future<Either<Failure, String>> login({
    required String phoneNumber,
    required String password,
  }) async {
    try {
      await Future.delayed(const Duration(seconds: 10));
      return const Right('result');
    } catch (error) {
      return Left(ErrorHandler.handle(error).failure);
    }
  }

  Future<Either<Failure, String>> register() async {
    try {
      await Future.delayed(const Duration(seconds: 2));
      return const Right('result');
    } catch (error) {
      return Left(ErrorHandler.handle(error).failure);
    }
  }
}
