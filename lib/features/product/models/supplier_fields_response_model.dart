class SupplierFieldsResponseModel {
  bool? success;
  String? message;
  List<SupplierFieldsData>? data;

  SupplierFieldsResponseModel({this.success, this.message, this.data});

  SupplierFieldsResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <SupplierFieldsData>[];
      json['data'].forEach((v) {
        data!.add(SupplierFieldsData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SupplierFieldsData {
  int? id;
  String? name;
  String? image;

  SupplierFieldsData({this.id, this.name, this.image});

  SupplierFieldsData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['image'] = image;
    return data;
  }
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'image': image,
    };
  }
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is SupplierFieldsData &&
              runtimeType == other.runtimeType &&
              id == other.id;

  @override
  int get hashCode => id.hashCode;

}