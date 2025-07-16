import 'dart:io';

class AddSupplierCategoryRequestModel {
  bool? isEdit;
  String? nameEn;
  String? nameAr;
  int? fieldId;
  int? id;
  File? image;
  String? imageUrl;

  AddSupplierCategoryRequestModel({
    this.nameEn,
    this.isEdit,
    this.nameAr,
    this.id,
    this.fieldId,
    this.image,
    this.imageUrl,
  });
}
