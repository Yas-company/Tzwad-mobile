// To parse this JSON data, do
//
//     final searchResultDataModel = searchResultDataModelFromJson(jsonString);

import 'dart:convert';

SearchResultDataModel searchResultDataModelFromJson(String str) =>
    SearchResultDataModel.fromJson(json.decode(str));

String searchResultDataModelToJson(SearchResultDataModel data) =>
    json.encode(data.toJson());

class SearchResultDataModel {
  SearchResultDataModel({
    required this.data,
    required this.links,
    required this.meta,
  });

  List<Datum> data;
  Links links;
  Meta meta;

  factory SearchResultDataModel.fromJson(Map<String, dynamic> json) =>
      SearchResultDataModel(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        links: Links.fromJson(json["links"]),
        meta: Meta.fromJson(json["meta"]),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "links": links.toJson(),
        "meta": meta.toJson(),
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
    // required this.attributes,
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
  // List<dynamic> attributes;
  String? badge;
  bool campaignProduct;
  int stockCount;
  dynamic avgRatting;
  bool isCartAble;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        prdId: json["prd_id"],
        title: json["title"],
        imgUrl: json["img_url"],
        campaignPercentage: json["campaign_percentage"].toDouble(),
        price:
            json["price"] is String ? num.parse(json["price"]) : json["price"],
        discountPrice: json["discount_price"] is String
            ? num.parse(json["discount_price"])
            : json["discount_price"]
        // attributes: List<dynamic>.from(json["attributes"].map((x) => x)),
        ,
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
        // "attributes": List<dynamic>.from(attributes.map((x) => x)),
        "badge": badge,
        "campaign_product": campaignProduct,
        "stock_count": stockCount,
        "avg_ratting": avgRatting,
        "is_cart_able": isCartAble,
      };
}

class Links {
  Links({
    required this.first,
    required this.last,
    this.prev,
    this.next,
  });

  String first;
  String last;
  dynamic prev;
  String? next;

  factory Links.fromJson(Map<String, dynamic> json) => Links(
        first: json["first"],
        last: json["last"],
        prev: json["prev"],
        next: json["next"],
      );

  Map<String, dynamic> toJson() => {
        "first": first,
        "last": last,
        "prev": prev,
        "next": next,
      };
}

class Meta {
  Meta({
    required this.currentPage,
    this.from,
    required this.lastPage,
    required this.links,
    required this.path,
    required this.perPage,
    required this.to,
    required this.total,
  });

  dynamic currentPage;
  dynamic? from;
  dynamic lastPage;
  dynamic links;
  dynamic path;
  dynamic perPage;
  dynamic? to;
  dynamic total;

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        currentPage: json["current_page"],
        from: json["from"],
        lastPage: json["last_page"],
        links: List<Link>.from(json["links"].map((x) => Link.fromJson(x))),
        path: json["path"],
        perPage: json["per_page"],
        to: json["to"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "from": from,
        "last_page": lastPage,
        "links": List<dynamic>.from(links.map((x) => x.toJson())),
        "path": path,
        "per_page": perPage,
        "to": to,
        "total": total,
      };
}

class Link {
  Link({
    this.url,
    required this.label,
    required this.active,
  });

  String? url;
  String label;
  bool active;

  factory Link.fromJson(Map<String, dynamic> json) => Link(
        url: json["url"],
        label: json["label"],
        active: json["active"],
      );

  Map<String, dynamic> toJson() => {
        "url": url,
        "label": label,
        "active": active,
      };
}
