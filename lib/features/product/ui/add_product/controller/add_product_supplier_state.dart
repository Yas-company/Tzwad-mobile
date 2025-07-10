
import 'dart:io';

class AddProductState {
  final String nameAr;
  final bool Touched;
  final String nameEn;
  final String quantity;
  final String minQty;
  final String pieces;
  final String descAr;
  final String descEn;
  final String price;
  final File? imageFile;
  final String? selectedCategory;
  final String? selectedStatus;
  final bool isLoading;

  AddProductState({
    this.nameAr = '',
    this.Touched = false,
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
    this.isLoading = false,
  });

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
    bool? Touched,
    File? imageFile,
    bool? isLoading,
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
      Touched: Touched ?? this.Touched,
      imageFile: imageFile ?? this.imageFile,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      selectedStatus: selectedStatus ?? this.selectedStatus,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}