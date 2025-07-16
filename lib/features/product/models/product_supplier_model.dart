import '../../category/models/category_model.dart';

class ProductSupplierModel {
  final int id;
  final String name;
  final String image;
  final String price;
  final String? priceBeforeDiscount;
  final String quantity;
  final int stockQty;
  final int status;
  final bool isFavorite;
  final int unitType;
  final CategoryModel? category;

  // خصائص داخل التطبيق
  int? cartQuantity;
  bool isLoading;

  ProductSupplierModel({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
    this.priceBeforeDiscount,
    required this.quantity,
    required this.stockQty,
    required this.status,
    required this.isFavorite,
    required this.unitType,
    this.category,
    this.cartQuantity,
    this.isLoading = false,
  });

  factory ProductSupplierModel.fromJson(Map<String, dynamic> json) {
    return ProductSupplierModel(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      price: json['price'],
      priceBeforeDiscount: json['price_before_discount'],
      quantity: json['quantity'],
      stockQty: json['stock_qty'],
      status: json['status'],
      isFavorite: json['is_favorite'],
      unitType: json['unit_type'],
      category: json['category'] != null
          ? CategoryModel.fromJson(json['category'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'price': price,
      'price_before_discount': priceBeforeDiscount,
      'quantity': quantity,
      'stock_qty': stockQty,
      'status': status,
      'is_favorite': isFavorite,
      'unit_type': unitType,
      'category': category?.toJson(),
    };
  }

  static List<ProductSupplierModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList
        .map((item) => ProductSupplierModel.fromJson(item))
        .toList();
  }
}