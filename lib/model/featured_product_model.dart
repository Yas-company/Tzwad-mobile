// To parse this JSON data, do
//
//     final featuredCardProducts = featuredCardProductsFromJson(jsonString);

import 'dart:convert';

FeaturedCardProducts featuredCardProductsFromJson(String str) =>
    FeaturedCardProducts.fromJson(json.decode(str));

String featuredCardProductsToJson(FeaturedCardProducts data) =>
    json.encode(data.toJson());

class FeaturedCardProducts {
  FeaturedCardProducts({
    required this.data,
  });

  List<Datum> data;

  factory FeaturedCardProducts.fromJson(Map<String, dynamic> json) =>
      FeaturedCardProducts(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    required this.prdId,
    required this.title,
    required this.imgUrl,
    required this.campaignPercentage,
    required this.price,
    required this.discountPrice,
    this.attributes,
    required this.badge,
    required this.campaignProduct,
    required this.stockCount,
    this.avgRatting,
    required this.isCartAble,
  });

  dynamic prdId;
  String title;
  String imgUrl;
  int campaignPercentage;
  int price;
  num discountPrice;
  dynamic attributes;
  String badge;
  bool campaignProduct;
  int stockCount;
  dynamic avgRatting;
  bool isCartAble;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        prdId: json["prd_id"],
        title: json["title"],
        imgUrl: json["img_url"],
        campaignPercentage: json["campaign_percentage"],
        price:
            json["price"] is String ? num.parse(json["price"]) : json["price"],
        discountPrice: json["discount_price"] is String
            ? num.parse(json["discount_price"])
            : json["discount_price"],
        attributes: json["attributes"],
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
        "attributes": attributes,
        "badge": badge,
        "campaign_product": campaignProduct,
        "stock_count": stockCount,
        "avg_ratting": avgRatting,
        "is_cart_able": isCartAble,
      };
}

class AttributesClass {
  AttributesClass({
    required this.color,
    this.size,
  });

  List<Color> color;
  List<Color>? size;

  factory AttributesClass.fromJson(Map<String, dynamic> json) =>
      AttributesClass(
        color: List<Color>.from(json["Color"].map((x) => Color.fromJson(x))),
        size: json["Size"] == null
            ? null
            : List<Color>.from(json["Size"].map((x) => Color.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Color": List<dynamic>.from(color.map((x) => x.toJson())),
        "Size": size == null
            ? null
            : List<dynamic>.from(size!.map((x) => x.toJson())),
      };
}

class Color {
  Color({
    required this.type,
    required this.name,
    required this.additionalPrice,
    required this.attributeImage,
  });

  String type;
  String name;
  String additionalPrice;
  String attributeImage;

  factory Color.fromJson(Map<String, dynamic> json) => Color(
        type: json["type"],
        name: json["name"],
        additionalPrice: json["additional_price"],
        attributeImage: json["attribute_image"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "name": name,
        "additional_price": additionalPrice,
        "attribute_image": attributeImage,
      };
}
