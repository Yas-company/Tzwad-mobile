import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:tzwad_mobile/core/network/base_response_model.dart';
import 'package:tzwad_mobile/core/local_data/app_preferences.dart';

import 'constants_api.dart';
import 'logger_interceptor.dart';

enum MethodEnum {
  get('GET'),
  post('POST'),
  put('PUT'),
  patch('PATCH'),
  delete('DELETE');

  final String name;

  const MethodEnum(this.name);
}

const String applicationJson = "application/json";
const int apiTimeOut = 60000;

class ApiService {
  final Dio dio = Dio();
  final AppPreferences appPrefs;

  ApiService(this.appPrefs) {
    Map<String, String> headers = {
      'content-type': applicationJson,
      'accept': applicationJson,
    };

    dio.options = BaseOptions(
      baseUrl: ConstantsApi.baseUrl,
      headers: headers,
      receiveTimeout: const Duration(milliseconds: apiTimeOut),
      sendTimeout: const Duration(milliseconds: apiTimeOut),
      connectTimeout: const Duration(milliseconds: apiTimeOut),
    );
    if (!kReleaseMode) {
      dio.interceptors.add(
        LoggerInterceptor(
          requestHeader: true,
          requestBody: true,
          responseHeader: true,
          error: true,
        ),
      );
    }
  }

  Future<dynamic> customRequest(
    MethodEnum method, {
    required String url,
    dynamic data,
    dynamic params,
    Map<String, String>? header,
  }) async {
    final response = await dio.request(
      url,
      data: data,
      queryParameters: params,
      options: Options(
        method: method.name,
        headers: header,
      ),
    );
    return response.data;
  }

  Future<T?> _request<T>(
    MethodEnum method, {
    required String url,
    dynamic data,
    dynamic params,
    Map<String, String>? customHeaders,
    T Function(Map<String, dynamic>)? fromJsonT,
  }) async {
    final token = appPrefs.getToken();
    final language = appPrefs.getAppLanguage();
    Map<String, String> header = {
      'Authorization': token.isNotEmpty ? 'Bearer $token' : '',
      'Accept-Language': language,
    };
    if (customHeaders != null) {
      header.addAll(customHeaders);
    }
    final response = await dio.request(
      url,
      data: data,
      queryParameters: params,
      options: Options(
        method: method.name,
        headers: header,
      ),
    );
    final result = BaseResponseModel<T>.fromJson(
      json: response.data,
      fromJsonT: fromJsonT,
    );
    // if (!result.success) {
    //   final options = RequestOptions(path: url, method: method);
    //   throw DioException(
    //     requestOptions: options,
    //     response: Response(
    //       requestOptions: options,
    //       statusCode: ResponseCode.unSuccess, // if success but success flag is false
    //       statusMessage: result.message,
    //     ),
    //     error: result.message,
    //   );
    // }
    return result.data;
  }

  Future<T?> get<T>({
    required String url,
    dynamic data,
    dynamic params,
    Map<String, String>? customHeaders,
    T Function(Map<String, dynamic>)? fromJsonT,
  }) =>
      _request(
        MethodEnum.get,
        url: url,
        data: data,
        params: params,
        customHeaders: customHeaders,
      );

  Future<T?> post<T>({
    required String url,
    dynamic data,
    dynamic params,
    Map<String, String>? customHeaders,
    T Function(Map<String, dynamic>)? fromJsonT,
  }) =>
      _request(
        MethodEnum.post,
        url: url,
        data: data,
        params: params,
        customHeaders: customHeaders,
      );

  Future<T?> put<T>({
    required String url,
    dynamic data,
    dynamic params,
    Map<String, String>? customHeaders,
    T Function(Map<String, dynamic>)? fromJsonT,
  }) =>
      _request(
        MethodEnum.post,
        url: url,
        data: data,
        params: params,
        customHeaders: customHeaders,
      );

  Future<T?> patch<T>({
    required String url,
    dynamic data,
    dynamic params,
    Map<String, String>? customHeaders,
    T Function(Map<String, dynamic>)? fromJsonT,
  }) =>
      _request(
        MethodEnum.patch,
        url: url,
        data: data,
        params: params,
        customHeaders: customHeaders,
      );

  Future<T?> delete<T>({
    required String url,
    dynamic data,
    dynamic params,
    Map<String, String>? customHeaders,
    T Function(Map<String, dynamic>)? fromJsonT,
  }) =>
      _request(
        MethodEnum.delete,
        url: url,
        data: data,
        params: params,
        customHeaders: customHeaders,
      );
}
