class SupplierCategoriesListModel {
  List<SupplierCategories>? data;

  SupplierCategoriesListModel({this.data});

  SupplierCategoriesListModel.fromJson(List<dynamic> jsonList) {
    data = jsonList.map((e) => SupplierCategories.fromJson(e)).toList();
  }

  List<Map<String, dynamic>> toJson() {
    return data?.map((e) => e.toJson()).toList() ?? [];
  }
}

class SupplierCategories {
  int? id;
  String? name;
  String? image;
  int? supplierId;
  int? fieldId;
  int? productsCount;
  Field? field;

  SupplierCategories(
      {this.id,
        this.name,
        this.image,
        this.supplierId,
        this.fieldId,
        this.productsCount,
        this.field});

  SupplierCategories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    supplierId = json['supplier_id'];
    fieldId = json['field_id'];
    productsCount = json['products_count'];
    field = json['field'] != null ? new Field.fromJson(json['field']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    data['supplier_id'] = this.supplierId;
    data['field_id'] = this.fieldId;
    data['products_count'] = this.productsCount;
    if (this.field != null) {
      data['field'] = this.field!.toJson();
    }
    return data;
  }
}

class Field {
  int? id;
  String? name;
  Null? image;

  Field({this.id, this.name, this.image});

  Field.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    return data;
  }
}

class Links {
  String? first;
  String? last;
  dynamic next;
  dynamic prev;

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