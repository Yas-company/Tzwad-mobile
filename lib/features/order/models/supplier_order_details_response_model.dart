import 'package:faker/faker.dart';

class SupplierOrdersDetailsResponseModel {
  bool? success;
  String? message;
  SupplierOrderDetailsData? data;

  SupplierOrdersDetailsResponseModel({this.success, this.message, this.data});

  SupplierOrdersDetailsResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? new SupplierOrderDetailsData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class SupplierOrderDetailsData {
  SupplierOrder? order;

  SupplierOrderDetailsData({this.order});

  SupplierOrderDetailsData.fromJson(Map<String, dynamic> json) {
    order = json['order'] != null ? SupplierOrder.fromJson(json['order']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.order != null) {
      data['order'] = this.order!.toJson();
    }
    return data;
  }
}

class SupplierOrder {
  int? id;
  int? userId;
  String? status;
  String? total;
  String? totalDiscount;
  String? createdAt;
  String? updatedAt;
  dynamic deletedAt;
  User? user;
  OrderDetail? orderDetail;
  Supplier? supplier;
  int? productsCount;
  List<Products>? products;

  SupplierOrder(
      {this.id,
        this.userId,
        this.status,
        this.total,
        this.totalDiscount,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
        this.user,
        this.orderDetail,
        this.supplier,
        this.productsCount,
        this.products});

  factory SupplierOrder.fake() {
    final faker = Faker();
    final fakeProducts = List.generate(3, (_) => Products.fake());

    return SupplierOrder(
      id: faker.randomGenerator.integer(1000),
      userId: faker.randomGenerator.integer(1000),
      status: faker.randomGenerator.element(['pending', 'completed', 'cancelled']),
      total: faker.randomGenerator.decimal(scale: 500).toStringAsFixed(2),
      totalDiscount: faker.randomGenerator.decimal(scale: 100).toStringAsFixed(2),
      createdAt: faker.date.dateTime().toIso8601String(),
      updatedAt: faker.date.dateTime().toIso8601String(),
      deletedAt: null,
      // user: User.fake(),
      // orderDetail: OrderDetail.fake(),
      // supplier: Supplier.fake(),
      productsCount: fakeProducts.length,
      products: fakeProducts,
    );
  }

  SupplierOrder.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    status = json['status'];
    total = json['total'];
    totalDiscount = json['total_discount'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    orderDetail = json['orderDetail'] != null
        ? new OrderDetail.fromJson(json['orderDetail'])
        : null;
    supplier = json['supplier'] != null
        ? Supplier.fromJson(json['supplier'])
        : null;
    productsCount = json['products_count'];
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(new Products.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['status'] = this.status;
    data['total'] = this.total;
    data['total_discount'] = this.totalDiscount;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    if (this.orderDetail != null) {
      data['orderDetail'] = this.orderDetail!.toJson();
    }
    if (this.supplier != null) {
      data['supplier'] = this.supplier!.toJson();
    }
    data['products_count'] = this.productsCount;
    if (this.products != null) {
      data['products'] = this.products!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class User {
  int? id;
  String? name;
  String? email;
  String? phone;
  Null? image;
  String? role;
  bool? isVerified;
  String? businessName;
  Null? licenseAttachment;
  Null? commercialRegisterAttachment;
  String? status;
  String? createdAt;
  String? updatedAt;

  User(
      {this.id,
        this.name,
        this.email,
        this.phone,
        this.image,
        this.role,
        this.isVerified,
        this.businessName,
        this.licenseAttachment,
        this.commercialRegisterAttachment,
        this.status,
        this.createdAt,
        this.updatedAt});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    image = json['image'];
    role = json['role'];
    isVerified = json['is_verified'];
    businessName = json['business_name'];
    licenseAttachment = json['license_attachment'];
    commercialRegisterAttachment = json['commercial_register_attachment'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['image'] = this.image;
    data['role'] = this.role;
    data['is_verified'] = this.isVerified;
    data['business_name'] = this.businessName;
    data['license_attachment'] = this.licenseAttachment;
    data['commercial_register_attachment'] = this.commercialRegisterAttachment;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class OrderDetail {
  String? notes;
  String? paymentStatus;
  String? paymentMethod;
  Null? trackingNumber;
  Null? estimatedDeliveryDate;
  ShippingAddress? shippingAddress;
  int? shippingMethod;

  OrderDetail(
      {this.notes,
        this.paymentStatus,
        this.paymentMethod,
        this.trackingNumber,
        this.estimatedDeliveryDate,
        this.shippingAddress,
        this.shippingMethod});

  OrderDetail.fromJson(Map<String, dynamic> json) {
    notes = json['notes'];
    paymentStatus = json['payment_status'];
    paymentMethod = json['payment_method'];
    trackingNumber = json['tracking_number'];
    estimatedDeliveryDate = json['estimated_delivery_date'];
    shippingAddress = json['shipping_address'] != null
        ? new ShippingAddress.fromJson(json['shipping_address'])
        : null;
    shippingMethod = json['shipping_method'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['notes'] = this.notes;
    data['payment_status'] = this.paymentStatus;
    data['payment_method'] = this.paymentMethod;
    data['tracking_number'] = this.trackingNumber;
    data['estimated_delivery_date'] = this.estimatedDeliveryDate;
    if (this.shippingAddress != null) {
      data['shipping_address'] = this.shippingAddress!.toJson();
    }
    data['shipping_method'] = this.shippingMethod;
    return data;
  }
}

class ShippingAddress {
  int? id;
  String? name;
  String? street;
  String? city;
  String? phone;
  String? latitude;
  String? longitude;
  bool? isDefault;
  String? createdAt;
  String? updatedAt;

  ShippingAddress(
      {this.id,
        this.name,
        this.street,
        this.city,
        this.phone,
        this.latitude,
        this.longitude,
        this.isDefault,
        this.createdAt,
        this.updatedAt});

  ShippingAddress.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    street = json['street'];
    city = json['city'];
    phone = json['phone'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    isDefault = json['is_default'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['street'] = this.street;
    data['city'] = this.city;
    data['phone'] = this.phone;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['is_default'] = this.isDefault;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Supplier {
  int? id;
  String? name;
  String? email;
  String? phone;
  Null? image;
  String? role;
  bool? isVerified;
  String? businessName;
  String? licenseAttachment;
  String? commercialRegisterAttachment;
  String? status;
  String? createdAt;
  String? updatedAt;

  Supplier(
      {this.id,
        this.name,
        this.email,
        this.phone,
        this.image,
        this.role,
        this.isVerified,
        this.businessName,
        this.licenseAttachment,
        this.commercialRegisterAttachment,
        this.status,
        this.createdAt,
        this.updatedAt});

  Supplier.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    image = json['image'];
    role = json['role'];
    isVerified = json['is_verified'];
    businessName = json['business_name'];
    licenseAttachment = json['license_attachment'];
    commercialRegisterAttachment = json['commercial_register_attachment'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['image'] = this.image;
    data['role'] = this.role;
    data['is_verified'] = this.isVerified;
    data['business_name'] = this.businessName;
    data['license_attachment'] = this.licenseAttachment;
    data['commercial_register_attachment'] = this.commercialRegisterAttachment;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}


class Products {
  int? id;
  String? name;
  String? image;
  String? price;
  dynamic priceBeforeDiscount;
  String? orderPrice;
  int? orderQuantity;
  int? orderTotal;
  int? stockQty;
  Category? category;

  Products({
    this.id,
    this.name,
    this.image,
    this.price,
    this.priceBeforeDiscount,
    this.orderPrice,
    this.orderQuantity,
    this.orderTotal,
    this.stockQty,
    this.category,
  });

  Products.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    price = json['price'];
    priceBeforeDiscount = json['price_before_discount'];
    orderPrice = json['order_price'];
    orderQuantity = json['order_quantity'];
    orderTotal = json['order_total'];
    stockQty = json['stock_qty'];
    category = json['category'] != null
        ? Category.fromJson(json['category'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['name'] = name;
    data['image'] = image;
    data['price'] = price;
    data['price_before_discount'] = priceBeforeDiscount;
    data['order_price'] = orderPrice;
    data['order_quantity'] = orderQuantity;
    data['order_total'] = orderTotal;
    data['stock_qty'] = stockQty;
    if (category != null) {
      data['category'] = category!.toJson();
    }
    return data;
  }

  factory Products.fake() {
    final faker = Faker();
    final priceValue = faker.randomGenerator.decimal(scale: 200);
    final quantity = faker.randomGenerator.integer(10, min: 1);
    final orderTotal = (priceValue * quantity).round();

    return Products(
      id: faker.randomGenerator.integer(1000),
      name: faker.food.dish(),
      image: faker.image.image(),
      price: priceValue.toStringAsFixed(2),
      priceBeforeDiscount: null,
      orderPrice: priceValue.toStringAsFixed(2),
      orderQuantity: quantity,
      orderTotal: orderTotal,
      stockQty: faker.randomGenerator.integer(100),
      category: Category.fake(),
    );
  }
}


class Category {
  int? id;
  String? name;
  String? image;

  Category({this.id, this.name, this.image});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
    };
  }

  factory Category.fake() {
    final faker = Faker();
    return Category(
      id: faker.randomGenerator.integer(1000),
      name: faker.lorem.word(),
      image: null,
    );
  }
}


