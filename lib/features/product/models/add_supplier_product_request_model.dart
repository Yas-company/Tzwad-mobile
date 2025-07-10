import 'dart:io';

class AddSupplierProductRequestModel {
  bool? isEdit;
  String? nameEn;
  String? nameAr;
  int? fieldId;
  int? id;
  File? image;
  String? imageUrl;

  AddSupplierProductRequestModel({
    this.nameEn,
    this.isEdit,
    this.nameAr,
    this.id,
    this.fieldId,
    this.image,
    this.imageUrl,
  });
}
