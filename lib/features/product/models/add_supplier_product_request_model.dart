import 'dart:io';

class AddSupplierProductRequestModel {
  final String nameEn;
  final String nameAr;
  final int fieldId;
  final File images;

  AddSupplierProductRequestModel({
    required this.nameEn,
    required this.nameAr,
    required this.fieldId,
    required this.images,
  });
}
