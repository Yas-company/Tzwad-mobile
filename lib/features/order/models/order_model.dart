import 'package:faker/faker.dart';
import 'package:tzwad_mobile/features/product/models/product_model.dart';

class OrderModel {
  int? id;
  int? userId;
  int? supplierId;
  String? status;
  String? totalAmount;
  String? shippingAddress;
  String? shippingLatitude;
  String? shippingLongitude;
  String? notes;
  String? paymentStatus;
  String? paymentMethod;
  String? paymentId;
  String? trackingNumber;
  String? estimatedDeliveryDate;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  String? receipt;

  // Supplier? supplier;
  List<ProductModel>? items;

  OrderModel({
    this.id,
    this.userId,
    this.supplierId,
    this.status,
    this.totalAmount,
    this.shippingAddress,
    this.shippingLatitude,
    this.shippingLongitude,
    this.notes,
    this.paymentStatus,
    this.paymentMethod,
    this.paymentId,
    this.trackingNumber,
    this.estimatedDeliveryDate,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.receipt,
    // this.supplier,
    this.items,
  });

  OrderModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    supplierId = json['supplier_id'];
    status = json['status'];
    totalAmount = json['total_amount'];
    shippingAddress = json['shipping_address'];
    shippingLatitude = json['shipping_latitude'];
    shippingLongitude = json['shipping_longitude'];
    notes = json['notes'];
    paymentStatus = json['payment_status'];
    paymentMethod = json['payment_method'];
    paymentId = json['payment_id'];
    trackingNumber = json['tracking_number'];
    estimatedDeliveryDate = json['estimated_delivery_date'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    receipt = json['receipt'];
    // supplier = json['supplier'] != null
    //     ? new Supplier.fromJson(json['supplier'])
    //     : null;
    if (json['items'] != null) {
      items = <ProductModel>[];
      items!.addAll(ProductModel.fromJsonList(json['items']));
    }
  }

  static List<OrderModel> fromJsonList(List<dynamic> jsonList) {
    return (jsonList).map((item) => OrderModel.fromJson(item)).toList();
  }

  factory OrderModel.fake({int id = 0}) {
    final faker = Faker();
    return OrderModel(
      id: id,
      userId: faker.randomGenerator.integer(10),
      supplierId: faker.randomGenerator.integer(10),
      status: faker.randomGenerator.string(10),
      totalAmount: faker.randomGenerator.string(10),
      shippingAddress: faker.randomGenerator.string(10),
      shippingLatitude: faker.randomGenerator.string(10),
      shippingLongitude: faker.randomGenerator.string(10),
      notes: faker.randomGenerator.string(10),
      paymentStatus: faker.randomGenerator.string(10),
      paymentMethod: faker.randomGenerator.string(10),
      paymentId: faker.randomGenerator.string(10),
      trackingNumber: faker.randomGenerator.string(10),
      estimatedDeliveryDate: faker.randomGenerator.string(10),
      createdAt: faker.date.dateTime().toString(),
      updatedAt: faker.date.dateTime().toString(),
      deletedAt: faker.date.dateTime().toString(),
      receipt: faker.randomGenerator.string(10),
      items: ProductModel.generateFakeList(count: 6),
    );
  }

  static List<OrderModel> generateFakeList({int count = 10}) {
    return List.generate(
      count,
      (index) => OrderModel.fake(id: index),
    );
  }
}
