import 'dart:convert';

OrderDetailsModel orderDetailsModelFromJson(String str) =>
    OrderDetailsModel.fromJson(json.decode(str));

String orderDetailsModelToJson(OrderDetailsModel data) =>
    json.encode(data.toJson());

class OrderDetailsModel {
  OrderDetailsModel({
    required this.orderInfo,
    this.shippingAddress,
    required this.product,
    this.country,
    this.state,
  });

  OrderInfo orderInfo;
  dynamic shippingAddress;
  List<Product> product;
  String? country;
  String? state;

  factory OrderDetailsModel.fromJson(Map<String, dynamic> json) =>
      OrderDetailsModel(
        orderInfo: OrderInfo.fromJson(json["order_info"]),
        shippingAddress: json["shipping_address"],
        product:
            List<Product>.from(json["product"].map((x) => Product.fromJson(x))),
        country: json["country"],
        state: json["state"],
      );

  Map<String, dynamic> toJson() => {
        "order_info": orderInfo.toJson(),
        "shipping_address": shippingAddress,
        "product": List<dynamic>.from(product.map((x) => x.toJson())),
        "country": country,
        "state": state,
      };
}

class OrderInfo {
  OrderInfo({
    required this.id,
    required this.name,
    this.email,
    this.userId,
    this.phone,
    this.country,
    this.address,
    this.city,
    this.state,
    this.zipcode,
    this.productId,
    this.coupon,
    required this.couponDiscounted,
    required this.totalAmount,
    required this.status,
    this.paymentStatus,
    this.paymentGateway,
    this.paymentTrack,
    this.transactionId,
    required this.orderDetails,
    this.paymentMeta,
    this.shippingAddressId,
    this.selectedShippingOption,
    this.checkoutType,
    this.checkoutImagePath,
    required this.createdAt,
    required this.updatedAt,
  });

  dynamic id;
  String name;
  String? email;
  int? userId;
  String? phone;
  String? country;
  String? address;
  String? city;
  String? state;
  String? zipcode;
  dynamic productId;
  dynamic coupon;
  String couponDiscounted;
  String totalAmount;
  String status;
  String? paymentStatus;
  String? paymentGateway;
  String? paymentTrack;
  String? transactionId;
  Map<String, List<OrderDetail>> orderDetails;
  PaymentMeta? paymentMeta;
  dynamic shippingAddressId;
  String? selectedShippingOption;
  dynamic checkoutType;
  String? checkoutImagePath;
  DateTime createdAt;
  DateTime updatedAt;

  factory OrderInfo.fromJson(Map<String, dynamic> json) => OrderInfo(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        userId: json["user_id"],
        phone: json["phone"],
        country: json["country"],
        address: json["address"],
        city: json["city"],
        state: json["state"],
        zipcode: json["zipcode"],
        productId: json["product_id"],
        coupon: json["coupon"],
        couponDiscounted: json["coupon_discounted"],
        totalAmount: json["total_amount"],
        status: json["status"],
        paymentStatus: json["payment_status"],
        paymentGateway: json["payment_gateway"],
        paymentTrack: json["payment_track"],
        transactionId: json["transaction_id"],
        orderDetails: Map.from(json["order_details"]).map((k, v) =>
            MapEntry<String, List<OrderDetail>>(k,
                List<OrderDetail>.from(v.map((x) => OrderDetail.fromJson(x))))),
        paymentMeta: PaymentMeta.fromJson(json["payment_meta"]),
        shippingAddressId: json["shipping_address_id"],
        selectedShippingOption: json["selected_shipping_option"],
        checkoutType: json["checkout_type"],
        checkoutImagePath: json["checkout_image_path"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "user_id": userId,
        "phone": phone,
        "country": country,
        "address": address,
        "city": city,
        "state": state,
        "zipcode": zipcode,
        "product_id": productId,
        "coupon": coupon,
        "coupon_discounted": couponDiscounted,
        "total_amount": totalAmount,
        "status": status,
        "payment_status": paymentStatus,
        "payment_gateway": paymentGateway,
        "payment_track": paymentTrack,
        "transaction_id": transactionId,
        "order_details": Map.from(orderDetails).map((k, v) =>
            MapEntry<String, dynamic>(
                k, List<dynamic>.from(v.map((x) => x.toJson())))),
        "payment_meta": paymentMeta!.toJson(),
        "shipping_address_id": shippingAddressId,
        "selected_shipping_option": selectedShippingOption,
        "checkout_type": checkoutType,
        "checkout_image_path": checkoutImagePath,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

class OrderDetail {
  OrderDetail({
    required this.id,
    required this.quantity,
    this.hash,
    this.attributes,
  });

  dynamic id;
  int quantity;
  String? hash;
  dynamic attributes;

  factory OrderDetail.fromJson(Map<String, dynamic> json) => OrderDetail(
        id: json["id"],
        quantity: json["quantity"] is String
            ? int.parse(json["quantity"])
            : json["quantity"],
        hash: json["hash"],
        attributes: json["attributes"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "quantity": quantity,
        "hash": hash,
        "attributes": attributes,
      };
}

class Productdetail {
  Productdetail({
    required this.id,
    required this.quantity,
    required this.hash,
    required this.attributes,
  });

  dynamic id;
  int quantity;
  String hash;
  dynamic attributes;

  factory Productdetail.fromJson(Map<String, dynamic> json) => Productdetail(
        id: json["id"],
        quantity: json["quantity"],
        hash: json["hash"],
        attributes: json["attributes"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "quantity": quantity,
        "hash": hash,
        "attributes": attributes.toJson(),
      };
}

class PaymentMeta {
  PaymentMeta({
    required this.total,
    required this.subtotal,
    required this.shippingCost,
    required this.taxAmount,
    required this.couponAmount,
  });

  String total;
  String subtotal;
  String shippingCost;
  String taxAmount;
  String couponAmount;

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

class Product {
  Product({
    required this.id,
    required this.title,
    required this.image,
    required this.price,
    required this.salePrice,
    required this.badge,
    required this.slug,
    required this.attributes,
    required this.campaignPercentage,
    this.category,
    // this.campaignProduct,
  });

  dynamic id;
  String title;
  String image;
  num price;
  num salePrice;
  String badge;
  String slug;
  String attributes;
  double campaignPercentage;
  dynamic category;
  // CampaignProduct? campaignProduct;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        title: json["title"],
        image: json["image"],
        price:
            json["price"] is String ? num.parse(json["price"]) : json["price"],
        salePrice: (json["sale_price"] is num)
            ? (json["sale_price"])
            : num.parse(json["sale_price"]),
        badge: json["badge"],
        slug: json["slug"],
        attributes: json["attributes"],
        campaignPercentage: json["campaign_percentage"].toDouble(),
        category: json["category"],
        // campaignProduct:
        // CampaignProduct.fromJson(json["campaign_product"] ?? {}),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "image": image,
        "price": price,
        "sale_price": salePrice,
        "badge": badge,
        "slug": slug,
        "attributes": attributes,
        "campaign_percentage": campaignPercentage,
        "category": category,
        // "campaign_product": campaignProduct!.toJson(),
      };
}

// class CampaignProduct {
//   CampaignProduct({
//     this.id,
//     this.productId,
//     this.campaignId,
//     this.campaignPrice,
//     this.unitsForSale,
//     this.startDate,
//     this.endDate,
//     this.createdAt,
//     this.updatedAt,
//   });

//   int? id;
//   int? productId;
//   int? campaignId;
//   String? campaignPrice;
//   int? unitsForSale;
//   DateTime? startDate;
//   DateTime? endDate;
//   dynamic createdAt;
//   dynamic updatedAt;

//   factory CampaignProduct.fromJson(Map<String, dynamic> json) =>
//       CampaignProduct(
//         id: json["id"],
//         productId: json["product_id"],
//         campaignId: json["campaign_id"],
//         campaignPrice: json["campaign_price"],
//         unitsForSale: json["units_for_sale"],
//         startDate: DateTime.parse(json["start_date"]),
//         endDate: DateTime.parse(json["end_date"]),
//         createdAt: json["created_at"],
//         updatedAt: json["updated_at"],
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "product_id": productId,
//         "campaign_id": campaignId,
//         "campaign_price": campaignPrice,
//         "units_for_sale": unitsForSale,
//         "start_date": startDate.toIso8601String(),
//         "end_date": endDate.toIso8601String(),
//         "created_at": createdAt,
//         "updated_at": updatedAt,
//       };
// }
