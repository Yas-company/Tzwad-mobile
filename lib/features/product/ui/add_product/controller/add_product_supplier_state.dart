import 'dart:io';

import 'package:tzwad_mobile/features/category/models/category_model.dart';

class AddProductState {
  final String nameAr;
  final String nameEn;
  final String quantity;
  final String minQty;
  final String pieces;
  final String descAr;
  final String descEn;
  final String price;

  final String? selectedCategory;
  final String? selectedStatus;
  File? imageFile;
  final String? existingImageUrl;

  final bool isLoading;
  final bool Touched;

  final bool isEditMode;
  final int? productId;
  int? filedId;
  // final Field? filedId;

  AddProductState({
    this.nameAr = '',
    this.nameEn = '',
    this.quantity = '',
    this.minQty = '',
    this.pieces = '',
    this.descAr = '',
    this.descEn = '',
    this.price = '',
    this.selectedCategory,
    this.selectedStatus,
    this.imageFile,
    this.existingImageUrl,
    this.isLoading = false,
    this.Touched = false,
    this.isEditMode = false,
    this.productId,
    this.filedId,
  });

  factory AddProductState.initial() => AddProductState(
    nameAr: '',
    nameEn: '',
    descAr: '',
    descEn: '',
    minQty: '',
    pieces: '',
    price: '',
    quantity: '',
    selectedCategory: null,
    selectedStatus: null,
    existingImageUrl: null,
    imageFile: null,
    isEditMode: false,
    productId: null,
    filedId: null,
    Touched: false,
    isLoading: false,
  );

  AddProductState copyWith({
    String? nameAr,
    String? nameEn,
    String? quantity,
    String? minQty,
    String? pieces,
    String? descAr,
    String? descEn,
    String? price,
    String? selectedCategory,
    String? selectedStatus,
    File? imageFile,
    String? existingImageUrl,
    bool? isLoading,
    bool? Touched,
    bool? isEditMode,
    int? productId,
    int? filedId,
  }) {
    return AddProductState(
      nameAr: nameAr ?? this.nameAr,
      nameEn: nameEn ?? this.nameEn,
      quantity: quantity ?? this.quantity,
      minQty: minQty ?? this.minQty,
      pieces: pieces ?? this.pieces,
      descAr: descAr ?? this.descAr,
      descEn: descEn ?? this.descEn,
      price: price ?? this.price,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      selectedStatus: selectedStatus ?? this.selectedStatus,
      imageFile: imageFile ?? this.imageFile,
      existingImageUrl: existingImageUrl ?? this.existingImageUrl,
      isLoading: isLoading ?? this.isLoading,
      Touched: Touched ?? this.Touched,
      isEditMode: isEditMode ?? this.isEditMode,
      productId: productId ?? this.productId,
      filedId: filedId ?? this.filedId,
    );
  }
}
