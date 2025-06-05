import 'package:tzwad_mobile/features/product/models/product_model.dart';

class CartModel {
  int? id;
  int? userId;
  String? totalAmount;
  String? createdAt;
  String? updatedAt;
  List<ProductModel>? items;

  CartModel({
    this.id,
    this.userId,
    this.totalAmount,
    this.createdAt,
    this.updatedAt,
    this.items,
  });

  CartModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    totalAmount = json['total_amount'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['items'] != null) {
      items = <ProductModel>[];
      items!.addAll(ProductModel.fromJsonList(json['items']));
    }
  }

// Map<String, dynamic> toJson() {
//   final Map<String, dynamic> data = <String, dynamic>{};
//   data['id'] = id;
//   data['user_id'] = userId;
//   data['total_amount'] = totalAmount;
//   data['created_at'] = createdAt;
//   data['updated_at'] = updatedAt;
//   if (items != null) {
//     data['items'] = items!.map((v) => v.toJson()).toList();
//   }
//   return data;
// }
}
