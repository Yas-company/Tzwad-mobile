import 'package:dio/dio.dart';
import 'package:tzwad_mobile/core/resource/language_manager.dart';
import 'package:tzwad_mobile/core/resource/string_manager.dart';
import 'package:tzwad_mobile/core/util/app_context.dart';

import 'failure.dart';

class ErrorHandler implements Exception {
  late Failure failure;

  ErrorHandler.handle(dynamic error) {
    if (error is DioException) {
      // dio error so its an error from response of the API or from dio itself
      failure = _handleError(error);
    } else {
      // default error
      failure = DataSource.defaultError.getFailure();
    }
  }

  _handleError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return DataSource.connectTimeout.getFailure();
      case DioExceptionType.sendTimeout:
        return DataSource.sendTimeout.getFailure();
      case DioExceptionType.receiveTimeout:
        return DataSource.receiveTimeout.getFailure();
      case DioExceptionType.badResponse:
        return _handleBadResponse(error);
      case DioExceptionType.cancel:
        return DataSource.cancel.getFailure();
      case DioExceptionType.connectionError:
        return DataSource.connectionError.getFailure();
      default:
        return _handleDefaultError(error);
    }
  }

  _handleBadResponse(DioException error) {
    try {
      final code = error.response?.statusCode ?? ResponseCode.defaultError;
      String message = '';
      switch (code) {
        case ResponseCode.unauthorised:
          return DataSource.unauthorised.getFailure();
        case ResponseCode.forbidden:
          return DataSource.forbidden.getFailure();
        case ResponseCode.notFound:
          return DataSource.notFound.getFailure();
        default:
          message = _extractErrorMessage(error.response?.data);
          return Failure(
            code: code,
            message: message,
          );
      }
    } catch (e) {
      return DataSource.defaultError.getFailure();
    }
  }

  _handleDefaultError(DioException error) {
    if (error.response?.statusCode == ResponseCode.noInternetConnection) {
      return DataSource.noInternetConnection.getFailure();
    } else if (error.response?.statusCode == ResponseCode.unSuccess) {
      return Failure(
        code: error.response?.statusCode ?? 0,
        message: error.response?.statusMessage ?? '',
      );
    } else {
      return DataSource.defaultError.getFailure();
    }
  }

  String _extractErrorMessage(dynamic data) {
    // String message = '';
    // data.forEach((key, value) {
    //   if (value is List) {
    //     message += value.join('\n');
    //   } else if (value is String) {
    //     message += value;
    //   } else {
    //     message += value.toString();
    //   }
    // });
    return data['message'];
  }
}

enum DataSource {
  success,
  noContent,
  badRequest,
  forbidden,
  unauthorised,
  notFound,
  internetServerError,
  connectTimeout,
  connectionError,
  cancel,
  receiveTimeout,
  sendTimeout,
  cacheError,
  noInternetConnection,
  defaultError
}

extension DataSourceExtension on DataSource {
  Failure getFailure() {
    final context = AppContext.context;
    switch (this) {
      case DataSource.success:
        return Failure(code: ResponseCode.success, message: ResponseMessage.success.tr(context));
      case DataSource.noContent:
        return Failure(code: ResponseCode.noContent, message: ResponseMessage.noContent.tr(context));
      case DataSource.badRequest:
        return Failure(code: ResponseCode.badRequest, message: ResponseMessage.badRequest.tr(context));
      case DataSource.forbidden:
        return Failure(code: ResponseCode.forbidden, message: ResponseMessage.forbidden.tr(context));
      case DataSource.unauthorised:
        return Failure(code: ResponseCode.unauthorised, message: ResponseMessage.unauthorised.tr(context));
      case DataSource.notFound:
        return Failure(code: ResponseCode.notFound, message: ResponseMessage.notFound.tr(context));
      case DataSource.internetServerError:
        return Failure(code: ResponseCode.internalServerError, message: ResponseMessage.internalServerError.tr(context));
      case DataSource.connectTimeout:
        return Failure(code: ResponseCode.connectTimeout, message: ResponseMessage.connectTimeout.tr(context));
      case DataSource.connectionError:
        return Failure(code: ResponseCode.connectionError, message: ResponseMessage.connectionError.tr(context));
      case DataSource.cancel:
        return Failure(code: ResponseCode.cancel, message: ResponseMessage.cancel.tr(context));
      case DataSource.receiveTimeout:
        return Failure(code: ResponseCode.receiveTimeout, message: ResponseMessage.receiveTimeout.tr(context));
      case DataSource.sendTimeout:
        return Failure(code: ResponseCode.sendTimeout, message: ResponseMessage.sendTimeout.tr(context));
      case DataSource.cacheError:
        return Failure(code: ResponseCode.cacheError, message: ResponseMessage.cacheError.tr(context));
      case DataSource.noInternetConnection:
        return Failure(code: ResponseCode.noInternetConnection, message: ResponseMessage.noInternetConnection.tr(context));
      case DataSource.defaultError:
        return Failure(code: ResponseCode.defaultError, message: ResponseMessage.defaultError.tr(context));
    }
  }
}

class ResponseCode {
  static const int unSuccess = -200; // success with data
  static const int success = 200; // success with data
  static const int noContent = 201; // success with no data (no content)
  static const int badRequest = 400; // failure, API rejected request
  static const int unauthorised = 401; // failure, user is not authorised
  static const int forbidden = 403; //  failure, API rejected request
  static const int internalServerError = 500; // failure, crash in server side
  static const int notFound = 404; // failure, not found
  static const int invalidData = 422; // failure, not found

  // local_db status code
  static const int connectTimeout = -1;
  static const int cancel = -2;
  static const int receiveTimeout = -3;
  static const int sendTimeout = -4;
  static const int cacheError = -5;
  static const int noInternetConnection = -6;
  static const int locationDenied = -7;
  static const int defaultError = -8;
  static const int connectionError = -9;
}

class ResponseMessage {
  static const String success = AppStrings.strSuccess; // success with data
  static const String noContent = AppStrings.strNoContent; // success with no data (no content)
  static const String badRequest = AppStrings.strBadRequestError; // failure, API rejected request
  static const String unauthorised = AppStrings.strUnauthorizedError; // failure, user is not authorised
  static const String forbidden = AppStrings.strForbiddenError; //  failure, API rejected request
  static const String internalServerError = AppStrings.strInternalServerError; // failure, crash in server side
  static const String notFound = AppStrings.strNotFoundError; // failure, crash in server side

  // local_db status code
  static const String connectTimeout = AppStrings.strTimeoutError;
  static const String cancel = AppStrings.strDefaultError;
  static const String receiveTimeout = AppStrings.strTimeoutError;
  static const String sendTimeout = AppStrings.strTimeoutError;
  static const String cacheError = AppStrings.strCacheError;
  static const String noInternetConnection = AppStrings.strNoInternetError;
  static const String locationDenied = AppStrings.strLocationDenied;
  static const String defaultError = AppStrings.strDefaultError;
  static const String connectionError = AppStrings.strDefaultError;
}

class ApiInternalStatus {
  static const String success = "200";
  static const String failure = "400";
}
