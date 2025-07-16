import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tzwad_mobile/features/category/ui/categories_supplier/category_supplier_controller.dart';
import 'package:tzwad_mobile/features/product/models/product_supplier_model.dart';
import '../../../../../core/network/failure.dart';
import '../../../../../core/util/state_render/result.dart';
import '../../../../../core/util/unit.dart';
import '../../../providers/product_repository_provider.dart';
import 'add_product_supplier_state.dart';


class AddProductController extends StateNotifier<AddProductState> {
  final Ref ref;
  final ImagePicker _picker = ImagePicker();
  List status = ["DRAFT", "PUBLISHED", "REJECTED"];
  // List category = ["PIECE", "KG", "G", "LITER", "ML", "BOX", "DOZEN", "METER"];

  AddProductController(this.ref) : super(AddProductState());

  void reset() {
    state = AddProductState.initial();
  }

  Future<void> pickImage() async {
    final XFile? picked = await _picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      state = state.copyWith(imageFile: File(picked.path));
    } else {
      state = state.copyWith(Touched: true);
    }
  }

  void selectCategory(String? value) {
    state = state.copyWith(selectedCategory: value, Touched: true);
  }

  void selectStatus(String? value) {
    state = state.copyWith(selectedStatus: value, Touched: true);
  }

  void changeNameAr(String value) => state = state.copyWith(nameAr: value, Touched: true);
  void changeNameEn(String value) => state = state.copyWith(nameEn: value, Touched: true);
  void changeQuantity(String value) => state = state.copyWith(quantity: value, Touched: true);
  void changePieces(String value) => state = state.copyWith(pieces: value, Touched: true);
  void changeDescAr(String value) => state = state.copyWith(descAr: value, Touched: true);
  void changeDescEn(String value) => state = state.copyWith(descEn: value, Touched: true);
  void changeMinOrder(String value) => state = state.copyWith(minQty: value, Touched: true);
  void changePrice(String value) => state = state.copyWith(price: value, Touched: true);


  void setInitialProduct(ProductSupplierModel product) {
    state = state.copyWith(
      nameAr: product.name,
      nameEn:product.name,
      descAr: product.name,
      descEn: product.name,
      existingImageUrl: product.image,
      minQty: product.quantity,
      pieces:product.quantity,
      // Add appropriate mappings
      price: product.price,
      quantity: product.quantity,
      selectedCategory: product.category?.name ?? '',
      selectedStatus: mapStatusIntToText(product.status),
      imageFile: null, // Optional: load network image instead
      isEditMode: true,
      productId: product.id,
      filedId: product.category?.fieldModel?.id??0,
    );
  }

  Future<Result<Failure, Unit>> submitProduct(int productId) async {
    final repository = ref.read(productRepositoryProvider);
    if (state.filedId == null) {
      state = state.copyWith(Touched: true);
      return Left(Failure(code: 0, message: "يرجى اختيار التصنيف"));
    }
    if (state.imageFile == null) {
      state = state.copyWith(Touched: true);
      return Left(Failure(code: 1, message: "يرجى اختيار صورة المنتج"));
    }
    if (state.nameAr.trim().isEmpty) {
      state = state.copyWith(Touched: true);
      return Left(Failure(code: 2, message: "يرجى إدخال اسم المنتج بالعربية"));
    }
    if (state.nameEn.trim().isEmpty) {
      state = state.copyWith(Touched: true);
      return Left(Failure(code: 3, message: "يرجى إدخال اسم المنتج بالإنجليزية"));
    }
    if (state.descAr.trim().isEmpty) {
      state = state.copyWith(Touched: true);
      return Left(Failure(code: 4, message: "يرجى إدخال وصف المنتج بالعربية"));
    }
    if (state.descEn.trim().isEmpty) {
      state = state.copyWith(Touched: true);
      return Left(Failure(code: 5, message: "يرجى إدخال وصف المنتج بالإنجليزية"));
    }
    if (state.price.trim().isEmpty) {
      state = state.copyWith(Touched: true);
      return Left(Failure(code: 6, message: "يرجى إدخال السعر"));
    }
    if (state.pieces.trim().isEmpty) {
      state = state.copyWith(Touched: true);
      return Left(Failure(code: 7, message: "يرجى إدخال عدد القطع"));
    }
    if (state.quantity.trim().isEmpty) {
      state = state.copyWith(Touched: true);
      return Left(Failure(code: 8, message: "يرجى إدخال الكمية"));
    }
    if (state.minQty.trim().isEmpty) {
      state = state.copyWith(Touched: true);
      return Left(Failure(code: 9, message: "يرجى إدخال أقل عدد للطلب"));
    }
    if (state.selectedStatus == null) {
      state = state.copyWith(Touched: true);
      return Left(Failure(code: 10, message: "يرجى اختيار الحالة"));
    }
    if (state.selectedCategory == null) {
      state = state.copyWith(Touched: true);
      return Left(Failure(code: 11, message: "يرجى اختيار وحدة القياس"));
    }

    // if (state.imageFile == null ||
    //     state.nameAr.trim().isEmpty ||
    //     state.nameEn.trim().isEmpty ||
    //     state.descEn.trim().isEmpty ||
    //     state.descAr.trim().isEmpty ||
    //     state.price.trim().isEmpty ||
    //     state.pieces.trim().isEmpty ||
    //     state.quantity.trim().isEmpty ||
    //     state.minQty.trim().isEmpty ||
    //     state.selectedStatus == null ||
    //     state.selectedCategory == null) {
    //   state = state.copyWith(Touched: true);
    //   return Left(Failure(code: 4, message: "يرجى تعبئة كل الحقول المطلوبة"));
    // }

    state = state.copyWith(isLoading: true);

    print('state.filedId??0>>'+state.filedId.toString());
    final result = await repository.addProductSupplier(
      productId:productId,
      imageFile: state.imageFile!,
      nameAr: state.nameAr,
      nameEn: state.nameEn,
      descriptionAr: state.descAr,
      descriptionEn: state.descEn,
      price: num.parse(state.price.isEmpty?'0':state.price),
      quantity: num.parse(state.quantity.isEmpty?'0':state.quantity),
      // stockQty: int.parse(state.pieces.isEmpty?'0':state.pieces),
      stockQty:double.parse(state.pieces.isEmpty?'0':state.pieces).toInt(),
      // stockQty: state.quantity,
      // unitType: "${category.indexOf("${state.selectedCategory}")}",
      unitType: state.filedId??0,
      status: status.indexOf(state.selectedStatus ?? ''),
      // status: "${status.indexOf("${state.selectedStatus}")}",
      categoryId:2,
      minOrderQuantity: num.parse(state.minQty.isEmpty?'0':state.minQty),
    );

    state = state.copyWith(isLoading: false);
    return result;
  }
}


String mapStatusIntToText(int status) {
  switch (status) {
    case 0:
      return "DRAFT";
    case 1:
      return "PUBLISHED";
    case 2:
      return "REJECTED";
    default:
      return "DRAFT"; // fallback
  }
}

int mapStatusTextToInt(String statusText) {
  switch (statusText.toUpperCase()) {
    case "DRAFT":
      return 0;
    case "PUBLISHED":
      return 1;
    case "REJECTED":
      return 2;
    default:
      return 0;
  }
}
