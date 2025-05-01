import 'dart:convert';

MobileSliderModel mobileSliderModelFromJson(String str) =>
    MobileSliderModel.fromJson(json.decode(str));

String mobileSliderModelToJson(MobileSliderModel data) =>
    json.encode(data.toJson());

class MobileSliderModel {
  MobileSliderModel({
    required this.currentPage,
    required this.data,
    required this.firstPageUrl,
    required this.from,
    required this.lastPage,
    required this.lastPageUrl,
    required this.links,
    this.nextPageUrl,
    required this.path,
    required this.perPage,
    this.prevPageUrl,
    required this.to,
    required this.total,
  });

  int currentPage;
  List<Datum> data;
  String firstPageUrl;
  int from;
  int lastPage;
  String lastPageUrl;
  List<Link> links;
  dynamic nextPageUrl;
  String path;
  int perPage;
  dynamic prevPageUrl;
  int to;
  int total;

  factory MobileSliderModel.fromJson(Map<String, dynamic> json) =>
      MobileSliderModel(
        currentPage: json["current_page"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        firstPageUrl: json["first_page_url"],
        from: json["from"],
        lastPage: json["last_page"],
        lastPageUrl: json["last_page_url"],
        links: List<Link>.from(json["links"].map((x) => Link.fromJson(x))),
        nextPageUrl: json["next_page_url"],
        path: json["path"],
        perPage: json["per_page"],
        prevPageUrl: json["prev_page_url"],
        to: json["to"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "first_page_url": firstPageUrl,
        "from": from,
        "last_page": lastPage,
        "last_page_url": lastPageUrl,
        "links": List<dynamic>.from(links.map((x) => x.toJson())),
        "next_page_url": nextPageUrl,
        "path": path,
        "per_page": perPage,
        "prev_page_url": prevPageUrl,
        "to": to,
        "total": total,
      };
}

class Datum {
  Datum({
    required this.title,
    required this.description,
    required this.image,
    required this.buttonUrl,
    required this.buttonText,
    this.campaign,
    this.category,
  });

  String title;
  String description;
  String image;
  String buttonUrl;
  String buttonText;
  int? campaign;
  int? category;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        title: json["title"],
        description: json["description"],
        image: json["image"],
        buttonUrl: json["button_url"],
        buttonText: json["button_text"],
        campaign: json["campaign"],
        category: json["category"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "description": description,
        "image": image,
        "button_url": buttonUrl,
        "button_text": buttonText,
        "campaign": campaign,
        "category": category,
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
        url: json["url"] == null ? null : json["url"],
        label: json["label"],
        active: json["active"],
      );

  Map<String, dynamic> toJson() => {
        "url": url == null ? null : url,
        "label": label,
        "active": active,
      };
}
