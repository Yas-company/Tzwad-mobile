// To parse this JSON data, do
//
//     final productDetailsModel = productDetailsModelFromJson(jsonString);

import 'dart:convert';

ProductDetailsModel productDetailsModelFromJson(String str) =>
    ProductDetailsModel.fromJson(json.decode(str));

String productDetailsModelToJson(ProductDetailsModel data) =>
    json.encode(data.toJson());

class ProductDetailsModel {
  ProductDetailsModel({
    required this.product,
    required this.relatedProducts,
    required this.userHasItem,
    required this.ratings,
    this.avgRating,
    this.availableAttributes,
    required this.productInventorySet,
    this.additionalInfoStore,
    required this.productColors,
    required this.productSizes,
    required this.settingText,
    required this.userRatedAlready,
  });

  Product product;
  List<RelatedProduct> relatedProducts;
  bool? userHasItem;
  List<Rating> ratings;
  dynamic avgRating;
  AvailableAttributes? availableAttributes;
  List<dynamic> productInventorySet;
  Map<String, AdditionalInfoStore>? additionalInfoStore;
  dynamic productColors;
  dynamic productSizes;
  SettingText? settingText;
  bool userRatedAlready;

  factory ProductDetailsModel.fromJson(Map<String, dynamic> json) {
    return ProductDetailsModel(
      product: Product.fromJson(json["product"]),
      relatedProducts: List<RelatedProduct>.from(
          json["related_products"].map((x) => RelatedProduct(
                prdId: x['prd_id'],
                title: x['title'],
                price: x['price'],
                imgUrl: x['img_url'],
                discountPrice: x['discount_price'] ?? 0,
                campaignPercentage: x['campaign_percentage'],
                isCartAble: x['is_cart_able'],
              ))),
      userHasItem: json["user_has_item"],
      ratings:
          List<Rating>.from(json["ratings"].map((x) => Rating.fromJson(x))),
      avgRating: json["avg_rating"],
      availableAttributes: json["available_attributes"] is List
          ? null
          : AvailableAttributes.fromJson(json["available_attributes"]),
      productInventorySet: json["product_inventory_set"],
      additionalInfoStore: json["additional_info_store"] is List
          ? null
          : Map.from(json["additional_info_store"]).map((k, v) =>
              MapEntry<String, AdditionalInfoStore>(
                  k, AdditionalInfoStore.fromJson(v))),
      productColors: json["productColors"],
      productSizes: json["productSizes"],
      settingText: SettingText.fromJson(json["setting_text"]),
      userRatedAlready: json["user_rated_already"],
    );
  }

  Map<String, dynamic> toJson() => {
        "product": product.toJson(),
        "related_products": List<dynamic>.from(relatedProducts.map((x) => x)),
        "user_has_item": userHasItem,
        "ratings": List<dynamic>.from(ratings.map((x) => x.toJson())),
        "avg_rating": avgRating,
        "available_attributes":
            availableAttributes is List ? null : availableAttributes!.toJson(),
        "product_inventory_set": productInventorySet,
        "additional_info_store": additionalInfoStore == null
            ? null
            : Map.from(additionalInfoStore!)
                .map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
        "productColors":
            List<dynamic>.from(productColors.map((x) => x.toJson())),
        "productSizes": List<dynamic>.from(productSizes.map((x) => x.toJson())),
        "setting_text": settingText!.toJson(),
        "user_rated_already": userRatedAlready,
      };
}

class AdditionalInfoStore {
  AdditionalInfoStore({
    required this.pidId,
    required this.additionalPrice,
    required this.image,
  });

  int pidId;
  int additionalPrice;
  String image;

  factory AdditionalInfoStore.fromJson(Map<String, dynamic> json) =>
      AdditionalInfoStore(
        pidId: json["pid_id"],
        additionalPrice: json["additional_price"] is double
            ? json["additional_price"].toInt()
            : json["additional_price"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "pid_id": pidId,
        "additional_price": additionalPrice,
        "image": image,
      };
}

class AvailableAttributes {
  AvailableAttributes({
    this.sauce,
    this.mayo,
    this.cheese,
  });

  List<String>? sauce;
  List<String>? mayo;
  List<String>? cheese;

  factory AvailableAttributes.fromJson(Map<String, dynamic> json) =>
      AvailableAttributes(
        sauce: json["Sauce"] == null
            ? null
            : List<String>.from(json["Sauce"].map((x) => x)),
        mayo: json["Mayo"] == null
            ? null
            : List<String>.from(json["Mayo"].map((x) => x)),
        cheese: json["Cheese"] == null
            ? null
            : List<String>.from(json["Cheese"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "Sauce": List<dynamic>.from(sauce!.map((x) => x)),
        "Mayo": List<dynamic>.from(mayo!.map((x) => x)),
        "Cheese": List<dynamic>.from(cheese!.map((x) => x)),
      };
}

class Product {
  Product({
    required this.id,
    required this.title,
    required this.summary,
    required this.description,
    required this.categoryId,
    this.subCategoryId,
    required this.image,
    required this.productImageGallery,
    required this.price,
    required this.salePrice,
    this.taxPercentage,
    required this.uom,
    required this.unit,
    required this.badge,
    required this.status,
    required this.slug,
    required this.attributes,
    this.soldCount,
    this.deletedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.inventoryDetailsCount,
    required this.productGalleryImage,
    required this.inventory,
    this.campaign,
    this.category,
    this.campaignProduct,
    required this.additionalInfo,
    required this.tags,
    required this.inventoryDetails,
    required this.campaignPercentage,
  });

  dynamic id;
  String title;
  String summary;
  String description;
  dynamic categoryId;
  dynamic subCategoryId;
  String image;
  String productImageGallery;
  num price;
  num salePrice;
  dynamic taxPercentage;
  String uom;
  int unit;
  String badge;
  String status;
  String slug;
  String attributes;
  int? soldCount;
  dynamic deletedAt;
  DateTime createdAt;
  DateTime updatedAt;
  int inventoryDetailsCount;
  List<dynamic> productGalleryImage;
  Inventory inventory;
  Campaign? campaign;
  dynamic category;
  Campaign? campaignProduct;
  List<AdditionalInfo> additionalInfo;
  List<Tag> tags;
  List<InventoryDetail> inventoryDetails;
  dynamic campaignPercentage;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        title: json["title"],
        summary: json["summary"],
        description: json["description"],
        categoryId: json["category_id"],
        subCategoryId: json["sub_category_id"],
        image: json["image"],
        productImageGallery: json["product_image_gallery"],
        price: json["price"] is String
            ? double.parse(json["price"]).toInt()
            : json["price"] is String
                ? num.parse(json["price"])
                : json["price"],
        salePrice: json["sale_price"] is String
            ? double.parse(json["sale_price"]).toInt()
            : json["sale_price"],
        taxPercentage: json["tax_percentage"],
        uom: json["uom"],
        unit: json["unit"],
        badge: json["badge"],
        status: json["status"],
        slug: json["slug"],
        attributes: json["attributes"],
        soldCount: json["sold_count"],
        deletedAt: json["deleted_at"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        inventoryDetailsCount: json["inventory_details_count"],
        productGalleryImage:
            List<dynamic>.from(json["product_gallery_image"].map((x) => x)),
        inventory: Inventory.fromJson(json["inventory"]),
        campaign: json["campaign"] != null
            ? Campaign.fromJson(json["campaign"])
            : null,
        category: json["category"],
        campaignProduct: json["campaign_product"] != null
            ? Campaign.fromJson(json["campaign_product"])
            : null,
        additionalInfo: List<AdditionalInfo>.from(
            json["additional_info"].map((x) => AdditionalInfo.fromJson(x))),
        tags: List<Tag>.from(json["tags"].map((x) => Tag.fromJson(x))),
        inventoryDetails: List<InventoryDetail>.from(
            json["inventory_details"].map((x) => InventoryDetail.fromJson(x))),
        campaignPercentage: json['campaign_percentage'] is String
            ? double.parse(json['campaign_percentage'])
            : json['campaign_percentage'],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "summary": summary,
        "description": description,
        "category_id": categoryId,
        "sub_category_id": subCategoryId,
        "image": image,
        "product_image_gallery": productImageGallery,
        "price": price,
        "sale_price": salePrice,
        "tax_percentage": taxPercentage,
        "uom": uom,
        "unit": unit,
        "badge": badge,
        "status": status,
        "slug": slug,
        "attributes": attributes,
        "sold_count": soldCount,
        "deleted_at": deletedAt,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "inventory_details_count": inventoryDetailsCount,
        "product_gallery_image":
            List<dynamic>.from(productGalleryImage.map((x) => x)),
        "inventory": inventory.toJson(),
        "campaign": campaign!.toJson(),
        "category": category,
        "campaign_product": campaignProduct!.toJson(),
        "additional_info":
            List<dynamic>.from(additionalInfo.map((x) => x.toJson())),
        "tags": List<dynamic>.from(tags.map((x) => x.toJson())),
        "inventory_details":
            List<dynamic>.from(inventoryDetails.map((x) => x.toJson())),
      };
}

class AdditionalInfo {
  AdditionalInfo({
    required this.id,
    required this.productId,
    required this.title,
    required this.text,
    this.createdAt,
    this.updatedAt,
  });

  dynamic id;
  int productId;
  String title;
  String text;
  dynamic createdAt;
  dynamic updatedAt;

  factory AdditionalInfo.fromJson(Map<String, dynamic> json) => AdditionalInfo(
        id: json["id"],
        productId: json["product_id"],
        title: json["title"],
        text: json["text"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "product_id": productId,
        "title": title,
        "text": text,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}

class Campaign {
  Campaign({
    required this.id,
    required this.productId,
    required this.campaignId,
    required this.campaignPrice,
    required this.unitsForSale,
    required this.startDate,
    required this.endDate,
    this.createdAt,
    this.updatedAt,
  });

  dynamic id;
  int productId;
  int campaignId;
  num? campaignPrice;
  int unitsForSale;
  DateTime startDate;
  DateTime endDate;
  dynamic createdAt;
  dynamic updatedAt;

  factory Campaign.fromJson(Map<String, dynamic> json) => Campaign(
        id: json["id"],
        productId: json["product_id"],
        campaignId: json["campaign_id"],
        campaignPrice: json["campaign_price"] is String
            ? num.tryParse(json["campaign_price"])
            : json["campaign_price"],
        unitsForSale: json["units_for_sale"],
        startDate: DateTime.parse(json["start_date"]),
        endDate: DateTime.parse(json["end_date"]),
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "product_id": productId,
        "campaign_id": campaignId,
        "campaign_price": campaignPrice,
        "units_for_sale": unitsForSale,
        "start_date": startDate.toIso8601String(),
        "end_date": endDate.toIso8601String(),
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}

class Inventory {
  Inventory({
    required this.id,
    required this.productId,
    required this.sku,
    required this.stockCount,
    required this.soldCount,
    required this.createdAt,
    required this.updatedAt,
  });

  dynamic id;
  int productId;
  String sku;
  int stockCount;
  int soldCount;
  DateTime createdAt;
  DateTime updatedAt;

  factory Inventory.fromJson(Map<String, dynamic> json) => Inventory(
        id: json["id"],
        productId: json["product_id"],
        sku: json["sku"],
        stockCount: json["stock_count"],
        soldCount: json["sold_count"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "product_id": productId,
        "sku": sku,
        "stock_count": stockCount,
        "sold_count": soldCount,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

class InventoryDetail {
  InventoryDetail({
    required this.id,
    required this.inventoryId,
    required this.productId,
    required this.color,
    required this.size,
    this.hash,
    required this.additionalPrice,
    required this.image,
    required this.stockCount,
    required this.soldCount,
    required this.createdAt,
    required this.updatedAt,
    required this.productColor,
    required this.productSize,
    required this.includedAttributes,
  });

  dynamic id;
  int inventoryId;
  int productId;
  String color;
  String size;
  dynamic hash;
  int additionalPrice;
  String image;
  int stockCount;
  int soldCount;
  DateTime createdAt;
  DateTime updatedAt;
  ProductColorElement? productColor;
  ProductColorElement? productSize;
  List<IncludedAttribute> includedAttributes;

  factory InventoryDetail.fromJson(Map<String, dynamic> json) =>
      InventoryDetail(
        id: json["id"],
        inventoryId: json["inventory_id"],
        productId: json["product_id"],
        color: json["color"],
        size: json["size"],
        hash: json["hash"],
        additionalPrice: json["additional_price"] is double
            ? json["additional_price"].toInt()
            : json["additional_price"],
        image: json["image"],
        stockCount: json["stock_count"],
        soldCount: json["sold_count"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        productColor: json["product_color"] == null
            ? null
            : ProductColorElement.fromJson(json["product_color"]),
        productSize: json["product_size"] == null
            ? null
            : ProductColorElement.fromJson(json["product_size"]),
        includedAttributes: List<IncludedAttribute>.from(
            json["included_attributes"]
                .map((x) => IncludedAttribute.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "inventory_id": inventoryId,
        "product_id": productId,
        "color": color,
        "size": size,
        "hash": hash,
        "additional_price": additionalPrice,
        "image": image,
        "stock_count": stockCount,
        "sold_count": soldCount,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "product_color": productColor!.toJson(),
        "product_size": productSize!.toJson(),
        "included_attributes":
            List<dynamic>.from(includedAttributes.map((x) => x.toJson())),
      };
}

class IncludedAttribute {
  IncludedAttribute({
    required this.id,
    required this.productId,
    required this.inventoryDetailsId,
    required this.attributeName,
    required this.attributeValue,
    this.createdAt,
    this.updatedAt,
  });

  dynamic id;
  int productId;
  int inventoryDetailsId;
  String attributeName;
  String attributeValue;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory IncludedAttribute.fromJson(Map<String, dynamic> json) =>
      IncludedAttribute(
        id: json["id"],
        productId: json["product_id"],
        inventoryDetailsId: json["inventory_details_id"],
        attributeName: json["attribute_name"],
        attributeValue: json["attribute_value"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "product_id": productId,
        "inventory_details_id": inventoryDetailsId,
        "attribute_name": attributeName,
        "attribute_value": attributeValue,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
      };
}

class ProductColorElement {
  ProductColorElement({
    required this.id,
    required this.name,
    this.colorCode,
    required this.slug,
    required this.createdAt,
    required this.updatedAt,
    this.sizeCode,
  });

  dynamic id;
  String name;
  String? colorCode;
  String slug;
  DateTime createdAt;
  DateTime updatedAt;
  String? sizeCode;

  factory ProductColorElement.fromJson(Map<String, dynamic> json) =>
      ProductColorElement(
        id: json["id"],
        name: json["name"],
        colorCode: json["color_code"],
        slug: json["slug"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        sizeCode: json["size_code"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "color_code": colorCode,
        "slug": slug,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "size_code": sizeCode,
      };
}

class Tag {
  Tag({
    required this.id,
    required this.productId,
    required this.tag,
    required this.createdAt,
    required this.updatedAt,
  });

  dynamic id;
  int productId;
  String tag;
  DateTime createdAt;
  DateTime updatedAt;

  factory Tag.fromJson(Map<String, dynamic> json) => Tag(
        id: json["id"],
        productId: json["product_id"],
        tag: json["tag"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "product_id": productId,
        "tag": tag,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

class ProductInventorySet {
  ProductInventorySet({
    this.sauce,
    this.color,
    this.colorName,
    this.size,
    this.mayo,
    this.cheese,
  });

  String? sauce;
  String? color;
  String? colorName;
  String? size;
  String? mayo;
  String? cheese;

  factory ProductInventorySet.fromJson(Map<String, dynamic> json) =>
      ProductInventorySet(
        sauce: json["Sauce"],
        color: json["Color"],
        colorName: json["Color_name"],
        size: json["Size"],
        mayo: json["Mayo"],
        cheese: json["Cheese"],
      );

  Map<String, dynamic> toJson() => {
        "Sauce": sauce,
        "Color": color,
        "Color_name": colorName,
        "Size": size,
        "Mayo": mayo,
        "Cheese": cheese,
      };
}

class SettingText {
  SettingText({
    required this.productInStockText,
    required this.productOutOfStockText,
    required this.additionalInformationText,
    required this.reviewsText,
    required this.yourReviewsText,
    required this.writeYourFeedbackText,
    required this.postYourFeedbackText,
  });

  String productInStockText;
  String productOutOfStockText;
  String additionalInformationText;
  String reviewsText;
  String yourReviewsText;
  String writeYourFeedbackText;
  String postYourFeedbackText;

  factory SettingText.fromJson(Map<String, dynamic> json) => SettingText(
        productInStockText: json["product_in_stock_text"],
        productOutOfStockText: json["product_out_of_stock_text"],
        additionalInformationText: json["additional_information_text"],
        reviewsText: json["reviews_text"],
        yourReviewsText: json["your_reviews_text"],
        writeYourFeedbackText: json["write_your_feedback_text"],
        postYourFeedbackText: json["post_your_feedback_text"],
      );

  Map<String, dynamic> toJson() => {
        "product_in_stock_text": productInStockText,
        "product_out_of_stock_text": productOutOfStockText,
        "additional_information_text": additionalInformationText,
        "reviews_text": reviewsText,
        "your_reviews_text": yourReviewsText,
        "write_your_feedback_text": writeYourFeedbackText,
        "post_your_feedback_text": postYourFeedbackText,
      };
}

class RelatedProduct {
  dynamic prdId;
  String title;
  String imgUrl;
  num price;
  num? discountPrice;
  dynamic campaignPercentage;
  bool? isCartAble;
  String? badge;

  RelatedProduct(
      {required this.prdId,
      required this.title,
      required this.price,
      this.discountPrice,
      this.campaignPercentage,
      required this.imgUrl,
      this.isCartAble,
      this.badge});
}

class Rating {
  Rating({
    required this.id,
    required this.productId,
    required this.userId,
    required this.status,
    required this.rating,
    required this.reviewMsg,
    required this.createdAt,
    required this.updatedAt,
    required this.user,
  });

  dynamic id;
  int productId;
  int userId;
  int status;
  int rating;
  String reviewMsg;
  DateTime createdAt;
  DateTime updatedAt;
  User user;

  factory Rating.fromJson(Map<String, dynamic> json) => Rating(
        id: json["id"],
        productId: json["product_id"],
        userId: json["user_id"],
        status: json["status"],
        rating: json["rating"],
        reviewMsg: json["review_msg"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        user: User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "product_id": productId,
        "user_id": userId,
        "status": status,
        "rating": rating,
        "review_msg": reviewMsg,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "user": user.toJson(),
      };
}

class User {
  User({
    required this.id,
    required this.name,
  });

  dynamic id;
  String name;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
