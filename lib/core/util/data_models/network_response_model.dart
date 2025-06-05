class NetworkResponseModel<T> {
  final bool? success;
  final String? message;
  final T? data;
  final PageInfoModel? pageInfo;

  NetworkResponseModel({
    required this.success,
    required this.message,
    this.data,
    this.pageInfo,
  });

  factory NetworkResponseModel.fromJson({
    required Map<String, dynamic> json,
    T Function(Map<String, dynamic> json)? fromJsonT,
    T Function(List<dynamic> jsonList)? formJsonList,
  }) {
    return NetworkResponseModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: _getData(json, fromJsonT, formJsonList),
      pageInfo: json['links'] != null && json['links'] is Map<String, dynamic> ? PageInfoModel.fromJson(json['links']) : null, //todo
    );
  }

  static dynamic _getData<T>(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic> json)? fromJsonT,
    T Function(List<dynamic> jsonList)? formJsonList,
  ) {
    final data = json['data'];
    if (data != null) {
      if (fromJsonT != null && data is Map) {
        return fromJsonT(
          json['data'],
        );
      }
      if (formJsonList != null && data is List) {
        return formJsonList(
          json['data'],
        );
      }
      // if (data is List) {
      //   return fromJsonT(data);
      //   return data
      //       .whereType<Map<String, dynamic>>() // Ensure each item is a Map
      //       .map((item) => fromJsonT(item))
      //       .toList();
      // }
    }

    return null;
  }
}

class PageInfoModel {
  String? first;
  String? last;
  String? prev;
  String? next;

  PageInfoModel({
    this.first,
    this.last,
    this.prev,
    this.next,
  });

  PageInfoModel.fromJson(Map<String, dynamic> json) {
    first = json['first'];
    last = json['last'];
    prev = json['prev'];
    next = json['next'];
  }
}
