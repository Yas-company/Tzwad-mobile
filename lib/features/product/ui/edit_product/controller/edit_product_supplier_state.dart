
import 'dart:io';

class EditProductState {
  final String nameAr;
  final bool Touched;
  final String nameEn;
  final String quantity;
  final String minQty;
  final String stockQty;
  final String descAr;
  final String descEn;
  final String price;
  final String? selectedCategory;
  final String? selectedStatus;
  final bool isLoading;

  EditProductState({
    this.nameAr = '',
    this.Touched = false,
    this.nameEn = '',
    this.quantity = '',
    this.minQty = '',
    this.stockQty = '',
    this.descAr = '',
    this.descEn = '',
    this.price = '',
    this.selectedCategory,
    this.selectedStatus,
    this.isLoading = false,
  });

  EditProductState copyWith({
    String? nameAr,
    String? nameEn,
    String? quantity,
    String? minQty,
    String? stockQty,
    String? descAr,
    String? descEn,
    String? price,
    String? selectedCategory,
    String? selectedStatus,
    bool? Touched,
    File? imageFile,
    bool? isLoading,
  }) {
    return EditProductState(
      nameAr: nameAr ?? this.nameAr,
      nameEn: nameEn ?? this.nameEn,
      quantity: quantity ?? this.quantity,
      minQty: minQty ?? this.minQty,
      stockQty: stockQty ?? this.stockQty,
      descAr: descAr ?? this.descAr,
      descEn: descEn ?? this.descEn,
      price: price ?? this.price,
      Touched: Touched ?? this.Touched,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      selectedStatus: selectedStatus ?? this.selectedStatus,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}