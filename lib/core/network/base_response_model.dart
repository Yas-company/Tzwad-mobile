class BaseResponseModel<T> {
  final bool? success;
  final String? message;
  final T? data;

  BaseResponseModel({
    required this.success,
    required this.message,
    this.data,
  });

  factory BaseResponseModel.fromJson({
    required Map<String, dynamic> json,
    T Function(Map<String, dynamic> json)? fromJsonT,
  }) {
    return BaseResponseModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: _getData(json, fromJsonT),
    );
  }

  static T? _getData<T>(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic> json)? fromJsonT,
  ) {
    if (fromJsonT != null && json['data'] != null && json['data'] is Map) {
      return fromJsonT(
        json['data'],
      );
    }
    return null;
  }
}
