import 'package:either_dart/either.dart';
import 'package:tzwad_mobile/core/network/api_service.dart';
import 'package:tzwad_mobile/core/network/error_handler.dart';
import 'package:tzwad_mobile/core/network/failure.dart';
import 'package:tzwad_mobile/core/util/constants.dart';

class GenericRepository {
  final ApiService apiService;

  GenericRepository({
    required this.apiService,
  });

  Future<Either<Failure, String>> getTermsConditions() async {
    try {
      final response = await apiService.customRequest(
        MethodEnum.get,
        url: Constants.termsConditionsUrl,
      );
      final html = response['content'].toString();
      return Right(html);
    } catch (error) {
      return Left(ErrorHandler.handle(error).failure);
    }
  }
}
