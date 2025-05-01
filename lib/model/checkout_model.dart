// To parse this JSON data, do
//
//     final mobileSliderModel = mobileSliderModelFromJson(jsonString);

import 'dart:convert';

CheckoutModel checkoutModelFromJson(String str) =>
    CheckoutModel.fromJson(json.decode(str));

String checkoutModelToJson(CheckoutModel data) => json.encode(data.toJson());

class CheckoutModel {
  CheckoutModel({
    required this.name,
    required this.email,
    required this.userId,
    this.country,
    this.address,
    this.city,
    this.state,
    this.zipcode,
    required this.phone,
    required this.shippingAddressId,
    this.selectedShippingOption,
    this.coupon,
    this.couponDiscounted,
    required this.totalAmount,
    required this.orderDetails,
    required this.paymentMeta,
    required this.paymentGateway,
    required this.paymentTrack,
    this.transactionId,
    required this.paymentStatus,
    required this.status,
    this.checkoutImagePath,
    required this.updatedAt,
    required this.createdAt,
    required this.id,
  });

  String name;
  String email;
  int userId;
  String? country;
  String? address;
  String? city;
  String? state;
  String? zipcode;
  String phone;
  String shippingAddressId;
  int? selectedShippingOption;
  String? coupon;
  String? couponDiscounted;
  String totalAmount;
  dynamic orderDetails;
  dynamic paymentMeta;
  String paymentGateway;
  String paymentTrack;
  String? transactionId;
  String paymentStatus;
  String status;
  String? checkoutImagePath;
  DateTime updatedAt;
  DateTime createdAt;
  dynamic id;

  factory CheckoutModel.fromJson(Map<String, dynamic> json) => CheckoutModel(
        name: json["name"],
        email: json["email"],
        userId: json["user_id"],
        country: json["country"],
        address: json["address"],
        city: json["city"],
        state: json["state"],
        zipcode: json["zipcode"],
        phone: json["phone"],
        shippingAddressId: json["shipping_address_id"],
        selectedShippingOption: json["selected_shipping_option"],
        coupon: json["coupon"],
        couponDiscounted: json["coupon_discounted"],
        totalAmount: json["total_amount"],
        orderDetails: json["order_details"],
        paymentMeta: json["payment_meta"],
        paymentGateway: json["payment_gateway"],
        paymentTrack: json["payment_track"],
        transactionId: json["transaction_id"],
        paymentStatus: json["payment_status"],
        status: json["status"],
        checkoutImagePath: json["checkout_image_path"],
        updatedAt: DateTime.parse(json["updated_at"]),
        createdAt: DateTime.parse(json["created_at"]),
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "user_id": userId,
        "country": country,
        "address": address,
        "city": city,
        "state": state,
        "zipcode": zipcode,
        "phone": phone,
        "shipping_address_id": shippingAddressId,
        "selected_shipping_option": selectedShippingOption,
        "coupon": coupon,
        "coupon_discounted": couponDiscounted,
        "total_amount": totalAmount,
        "order_details": orderDetails.toJson(),
        "payment_meta": paymentMeta.toJson(),
        "payment_gateway": paymentGateway,
        "payment_track": paymentTrack,
        "transaction_id": transactionId,
        "payment_status": paymentStatus,
        "status": status,
        "checkout_image_path": checkoutImagePath,
        "updated_at": updatedAt.toIso8601String(),
        "created_at": createdAt.toIso8601String(),
        "id": id,
      };
}

class OrderDetails {
  OrderDetails({
    required this.elements,
  });

  List<Elements> elements;

  factory OrderDetails.fromJson(Map<String, dynamic> json) => OrderDetails(
        elements:
            List<Elements>.from(json["48"].map((x) => Elements.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "48": List<dynamic>.from(elements.map((x) => x.toJson())),
      };
}

class Elements {
  Elements({
    required this.id,
    required this.quantity,
    this.attributes,
  });

  dynamic id;
  int quantity;
  Attributes? attributes;

  factory Elements.fromJson(Map<String, dynamic> json) => Elements(
        id: json["id"],
        quantity: json["quantity"],
        attributes: Attributes.fromJson(json["attributes"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "quantity": quantity,
        "attributes": attributes!.toJson(),
      };
}

class Attributes {
  Attributes({
    this.mayo,
    this.cheese,
    this.sauce,
    this.price,
  });

  String? mayo;
  String? cheese;
  String? sauce;
  int? price;

  factory Attributes.fromJson(Map<String, dynamic> json) => Attributes(
        mayo: json["Mayo"],
        cheese: json["Cheese"],
        sauce: json["Sauce"],
        price:
            json["price"] is String ? num.parse(json["price"]) : json["price"],
      );

  Map<String, dynamic> toJson() => {
        "Mayo": mayo,
        "Cheese": cheese,
        "Sauce": sauce,
        "price": price,
      };
}

class PaymentMeta {
  PaymentMeta({
    required this.total,
    required this.subtotal,
    required this.shippingCost,
    this.taxAmount,
    this.couponAmount,
  });

  String total;
  String subtotal;
  String shippingCost;
  String? taxAmount;
  String? couponAmount;

  factory PaymentMeta.fromJson(Map<String, dynamic> json) => PaymentMeta(
        total: json["total"],
        subtotal: json["subtotal"],
        shippingCost: json["shipping_cost"],
        taxAmount: json["tax_amount"],
        couponAmount: json["coupon_amount"],
      );

  Map<String, dynamic> toJson() => {
        "total": total,
        "subtotal": subtotal,
        "shipping_cost": shippingCost,
        "tax_amount": taxAmount,
        "coupon_amount": couponAmount,
      };
}
