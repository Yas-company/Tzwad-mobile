import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:tzwad_mobile/core/util/data_models/data_model.dart';
import 'package:tzwad_mobile/core/util/data_models/network_response_model.dart';
import 'package:tzwad_mobile/features/generic/local_data/setting_local_data.dart';

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
  final SettingLocalData settingLocalData;

  // final AppPreferences appPrefs;

  ApiService({
    required this.settingLocalData,
  }) {
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

  Future<DataModel<T>> _request<T>(
    MethodEnum method, {
    required String url,
    dynamic data,
    dynamic params,
    Map<String, String>? customHeaders,
    T Function(Map<String, dynamic>)? fromJsonT,
    T Function(List<dynamic>)? fromJsonListT,
  }) async {
    final token = settingLocalData.getToken();
    final language = settingLocalData.getLanguageApp();
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
    final result = NetworkResponseModel<T>.fromJson(
      json: response.data,
      fromJsonT: fromJsonT,
      formJsonList: fromJsonListT,
    );

    return DataModel(
      data: result.data,
      hasMore: result.pageInfo != null && result.pageInfo!.next != null,
    );
  }

  Future<DataModel<T>> get<T>({
    required String url,
    dynamic data,
    dynamic params,
    Map<String, String>? customHeaders,
    T Function(Map<String, dynamic>)? fromJsonT,
    T Function(List<dynamic>)? fromJsonListT,
  }) =>
      _request(
        MethodEnum.get,
        url: url,
        data: data,
        params: params,
        customHeaders: customHeaders,
        fromJsonT: fromJsonT,
        fromJsonListT: fromJsonListT,
      );

  Future<DataModel<T>> post<T>({
    required String url,
    dynamic data,
    dynamic params,
    Map<String, String>? customHeaders,
    T Function(Map<String, dynamic>)? fromJsonT,
    T Function(List<dynamic>)? fromJsonListT,
  }) =>
      _request(
        MethodEnum.post,
        url: url,
        data: data,
        params: params,
        customHeaders: customHeaders,
        fromJsonT: fromJsonT,
        fromJsonListT: fromJsonListT,
      );

  Future<DataModel<T>> put<T>({
    required String url,
    dynamic data,
    dynamic params,
    Map<String, String>? customHeaders,
    T Function(Map<String, dynamic>)? fromJsonT,
    T Function(List<dynamic>)? fromJsonListT,
  }) =>
      _request(
        MethodEnum.post,
        url: url,
        data: data,
        params: params,
        customHeaders: customHeaders,
        fromJsonT: fromJsonT,
        fromJsonListT: fromJsonListT,
      );

  Future<DataModel<T>> patch<T>({
    required String url,
    dynamic data,
    dynamic params,
    Map<String, String>? customHeaders,
    T Function(Map<String, dynamic>)? fromJsonT,
    T Function(List<dynamic>)? fromJsonListT,
  }) =>
      _request(
        MethodEnum.patch,
        url: url,
        data: data,
        params: params,
        customHeaders: customHeaders,
        fromJsonT: fromJsonT,
        fromJsonListT: fromJsonListT,
      );

  Future<DataModel<T>> delete<T>({
    required String url,
    dynamic data,
    dynamic params,
    Map<String, String>? customHeaders,
    T Function(Map<String, dynamic>)? fromJsonT,
    T Function(List<dynamic>)? fromJsonListT,
  }) =>
      _request(
        MethodEnum.delete,
        url: url,
        data: data,
        params: params,
        customHeaders: customHeaders,
        fromJsonT: fromJsonT,
        fromJsonListT: fromJsonListT,
      );
}
