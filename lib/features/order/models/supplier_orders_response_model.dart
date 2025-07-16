import 'package:faker/faker.dart';
import 'package:tzwad_mobile/features/order/ui/order_supplier/widgets/supplier_order_widget.dart';

class SupplierOrdersResponseModel {
  bool? success;
  String? message;
  List<SupplierOrdersData>? data;
  Links? links;

  SupplierOrdersResponseModel(
      {this.success, this.message, this.data, this.links});

  SupplierOrdersResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <SupplierOrdersData>[];
      json['data'].forEach((v) {
        data!.add(new SupplierOrdersData.fromJson(v));
      });
    }
    links = json['links'] != null ? new Links.fromJson(json['links']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    if (this.links != null) {
      data['links'] = this.links!.toJson();
    }
    return data;
  }
}

class SupplierOrdersData {
  int? id;
  String? status;
  String? createdAt;
  String? buyerName;
  int? productsCount;
  dynamic trackingNumber;
  int? shippingMethod;
  String? paymentStatus;
  OrderStatus? orderStatus;

  SupplierOrdersData(
      {this.id,
        this.status,
        this.createdAt,
        this.buyerName,
        this.productsCount,
        this.trackingNumber,
        this.orderStatus,
        this.shippingMethod,
        this.paymentStatus});

  SupplierOrdersData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
    createdAt = json['created_at'];
    buyerName = json['buyer_name'];
    productsCount = json['products_count'];
    trackingNumber = json['tracking_number'];
    shippingMethod = json['shipping_method'];
    paymentStatus = json['payment_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = this.id;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['buyer_name'] = this.buyerName;
    data['products_count'] = this.productsCount;
    data['tracking_number'] = this.trackingNumber;
    data['shipping_method'] = this.shippingMethod;
    data['payment_status'] = this.paymentStatus;
    return data;
  }

  static List<SupplierOrdersData> fromJsonList(List<dynamic> jsonList) {
    return (jsonList).map((item) => SupplierOrdersData.fromJson(item)).toList();
  }

  factory SupplierOrdersData.fake({int id = 0}) {
    final faker = Faker();
    return SupplierOrdersData(
      id: id,
      createdAt:faker.randomGenerator.string(10),
      productsCount: 0,
      shippingMethod: 0,
      status: faker.randomGenerator.string(10),
      buyerName: faker.randomGenerator.string(10),
      paymentStatus:faker.randomGenerator.string(10),
      trackingNumber: 0
    );
  }

  static List<SupplierOrdersData> generateFakeList({int count = 10}) {
    return List.generate(
      count, (index) => SupplierOrdersData.fake(id: index),
    );
  }
}

class Links {
  String? first;
  String? last;
  Null? next;
  Null? prev;

  Links({this.first, this.last, this.next, this.prev});

  Links.fromJson(Map<String, dynamic> json) {
    first = json['first'];
    last = json['last'];
    next = json['next'];
    prev = json['prev'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['first'] = this.first;
    data['last'] = this.last;
    data['next'] = this.next;
    data['prev'] = this.prev;
    return data;
  }
}