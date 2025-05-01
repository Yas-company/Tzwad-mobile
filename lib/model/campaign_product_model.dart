// To parse this JSON data, do
//
//     final campaignProductModel = campaignProductModelFromJson(jsonString);

import 'dart:convert';

CampaignProductModel campaignProductModelFromJson(String str) =>
    CampaignProductModel.fromJson(json.decode(str));

String campaignProductModelToJson(CampaignProductModel data) =>
    json.encode(data.toJson());

class CampaignProductModel {
  CampaignProductModel({
    required this.products,
    required this.campaignInfo,
  });

  List<Product> products;
  CampaignInfo campaignInfo;

  factory CampaignProductModel.fromJson(Map<String, dynamic> json) =>
      CampaignProductModel(
        products: List<Product>.from(
            json["products"].map((x) => Product.fromJson(x))),
        campaignInfo: CampaignInfo.fromJson(json["campaign_info"]),
      );

  Map<String, dynamic> toJson() => {
        "products": List<dynamic>.from(products.map((x) => x.toJson())),
        "campaign_info": campaignInfo.toJson(),
      };
}

class CampaignInfo {
  CampaignInfo({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.image,
    required this.startDate,
    required this.endDate,
    required this.status,
    required this.createdAt,
    this.updatedAt,
  });

  dynamic id;
  String title;
  String subtitle;
  int image;
  DateTime? startDate;
  DateTime? endDate;
  String status;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory CampaignInfo.fromJson(Map<String, dynamic> json) => CampaignInfo(
        id: json["id"],
        title: json["title"],
        subtitle: json["subtitle"],
        image: json["image"],
        startDate: json["start_date"] == null
            ? null
            : DateTime.parse(json["start_date"]),
        endDate:
            json["end_date"] == null ? null : DateTime.parse(json["end_date"]),
        status: json["status"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "subtitle": subtitle,
        "image": image,
        "start_date": startDate!.toIso8601String(),
        "end_date": endDate!.toIso8601String(),
        "status": status,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
      };
}

class Product {
  Product({
    required this.prdId,
    required this.title,
    required this.imgUrl,
    required this.campaignPercentage,
    required this.price,
    required this.discountPrice,
    required this.attributes,
    required this.badge,
    required this.campaignProduct,
    required this.stockCount,
    this.avgRatting,
    required this.isCartAble,
  });

  dynamic prdId;
  String title;
  String imgUrl;
  double campaignPercentage;
  num price;
  num discountPrice;
  List<dynamic> attributes;
  String badge;
  bool campaignProduct;
  int stockCount;
  dynamic avgRatting;
  bool isCartAble;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        prdId: json["prd_id"],
        title: json["title"],
        imgUrl: json["img_url"],
        campaignPercentage: json["campaign_percentage"].toDouble(),
        price:
            json["price"] is String ? num.parse(json["price"]) : json["price"],
        discountPrice: json["discount_price"] is String
            ? num.parse(json["discount_price"])
            : json["discount_price"],
        attributes: List<dynamic>.from(json["attributes"].map((x) => x)),
        badge: json["badge"],
        campaignProduct: json["campaign_product"],
        stockCount: json["stock_count"],
        avgRatting: json["avg_ratting"],
        isCartAble: json["is_cart_able"],
      );

  Map<String, dynamic> toJson() => {
        "prd_id": prdId,
        "title": title,
        "img_url": imgUrl,
        "campaign_percentage": campaignPercentage,
        "price": price,
        "discount_price": discountPrice,
        "attributes": List<dynamic>.from(attributes.map((x) => x)),
        "badge": badge,
        "campaign_product": campaignProduct,
        "stock_count": stockCount,
        "avg_ratting": avgRatting,
        "is_cart_able": isCartAble,
      };
}
