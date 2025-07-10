import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../core/network/failure.dart';
import '../../../../../core/util/state_render/result.dart';
import '../../../../../core/util/unit.dart';
import '../../../providers/product_repository_provider.dart';
import 'add_product_supplier_state.dart';


class AddProductController extends StateNotifier<AddProductState> {
  final Ref ref;
  final ImagePicker _picker = ImagePicker();
  List status = ["DRAFT", "PUBLISHED", "REJECTED"];
  List category = ["PIECE", "KG", "G", "LITER", "ML", "BOX", "DOZEN", "METER"];

  AddProductController(this.ref) : super(AddProductState());

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

  Future<Result<Failure, Unit>> submitProduct() async {
    final repository = ref.read(productRepositoryProvider);

    if (state.imageFile == null ||
        state.nameAr.trim().isEmpty ||
        state.nameEn.trim().isEmpty ||
        state.descEn.trim().isEmpty ||
        state.descAr.trim().isEmpty ||
        state.price.trim().isEmpty ||
        state.pieces.trim().isEmpty ||
        state.quantity.trim().isEmpty ||
        state.minQty.trim().isEmpty ||
        state.selectedStatus == null ||
        state.selectedCategory == null) {
      state = state.copyWith(Touched: true);
      return Left(Failure(code: 4, message: "يرجى تعبئة كل الحقول المطلوبة"));
    }

    state = state.copyWith(isLoading: true);

    final result = await repository.addProductSupplier(
      imageFile: state.imageFile!,
      nameAr: state.nameAr,
      nameEn: state.nameEn,
      descriptionAr: state.descAr,
      descriptionEn: state.descEn,
      price: state.price,
      quantity: state.quantity,
      stockQty: state.pieces,
      unitType: "${category.indexOf("${state.selectedCategory}")}",
      status: "${status.indexOf("${state.selectedStatus}")}",
      categoryId: "2",
      minOrderQuantity: state.minQty,
    );

    state = state.copyWith(isLoading: false);
    return result;
  }
}
