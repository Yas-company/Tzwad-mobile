import 'package:either_dart/either.dart';
import 'package:tzwad_mobile/core/extension/string_extension.dart';
import 'package:tzwad_mobile/core/network/api_service.dart';
import 'package:tzwad_mobile/core/network/error_handler.dart';
import 'package:tzwad_mobile/core/network/failure.dart';
import 'package:tzwad_mobile/core/util/constants.dart';

class GenericRepository extends ApiService {
  Future<Either<Failure, String>> getTermsConditions() async {
    try {
      final response = await get(url: Constants.termsConditionsUrl);
      // html = jsonDecode(response.body)["content"];
      response['content'].toString().log();
      return Right(response['content']);
    } catch (error) {
      return Left(ErrorHandler.handle(error).failure);
    }
  }
}
