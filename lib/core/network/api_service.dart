import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import 'constants_api.dart';
import 'logger_interceptor.dart';

const String applicationJson = "application/json";
const int apiTimeOut = 60000;

class ApiService {
  final Dio dio = Dio();

  ApiService() {
    Map<String, String> headers = {
      'Authorization': 'Bearer token',
      'Accept-Language': 'en',
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

  Future<dynamic> _request(
    String method, {
    required String url,
    dynamic data,
    dynamic params,
    Map<String, String>? customHeaders,
  }) async {
    Map<String, String> header = {
      'Authorization': "Bearer token",
      'Accept-Language': 'en',
    };
    if (customHeaders != null) {
      header.addAll(customHeaders);
    }
    final response = await dio.request(
      url,
      data: data,
      queryParameters: params,
      options: Options(
        method: method,
        headers: header,
      ),
    );
    return response.data;
  }

  Future<dynamic> get({
    required String url,
    dynamic data,
    dynamic params,
    Map<String, String>? customHeaders,
  }) =>
      _request(
        'GET',
        url: url,
        data: data,
        params: params,
        customHeaders: customHeaders,
      );

  Future<dynamic> post({
    required String url,
    dynamic data,
    dynamic params,
    Map<String, String>? customHeaders,
  }) =>
      _request('POST', url: url, data: data, params: params, customHeaders: customHeaders);

  Future<dynamic> put({
    required String url,
    dynamic data,
    dynamic params,
    Map<String, String>? customHeaders,
  }) =>
      _request('PUT', url: url, data: data, params: params, customHeaders: customHeaders);

  Future<dynamic> patch({
    required String url,
    dynamic data,
    dynamic params,
    Map<String, String>? customHeaders,
  }) =>
      _request('PATCH', url: url, data: data, params: params, customHeaders: customHeaders);

  Future<dynamic> delete({
    required String url,
    dynamic data,
    dynamic params,
    Map<String, String>? customHeaders,
  }) =>
      _request('DELETE', url: url, data: data, params: params, customHeaders: customHeaders);
}
