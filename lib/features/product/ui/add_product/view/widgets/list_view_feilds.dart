import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tzwad_mobile/core/app_widgets/app_button_widget.dart';
import 'package:tzwad_mobile/core/app_widgets/app_drop_down.dart';
import 'package:tzwad_mobile/core/app_widgets/app_network_image_widget.dart';
import 'package:tzwad_mobile/core/app_widgets/app_text_field_widget.dart';
import 'package:tzwad_mobile/core/extension/context_extension.dart';
import 'package:tzwad_mobile/core/file_upload/select_image_bottom_sheet.dart';
import 'package:tzwad_mobile/core/resource/color_manager.dart';
import 'package:tzwad_mobile/core/resource/style_manager.dart';
import 'package:tzwad_mobile/features/category/ui/categories_supplier/category_supplier_controller.dart';
import 'package:tzwad_mobile/features/category/ui/categories_supplier/widgets/dotted_border_container.dart';
import 'package:tzwad_mobile/features/product/models/supplier_fields_response_model.dart';
import 'package:tzwad_mobile/features/product/ui/add_product/hooks/add_product_supplier_ar_desc.dart';
import 'package:tzwad_mobile/features/product/ui/add_product/hooks/add_product_supplier_en_desc.dart';
import 'package:tzwad_mobile/features/product/ui/add_product/hooks/add_product_supplier_min_order_quantity_hook.dart';
import 'package:tzwad_mobile/features/product/ui/add_product/hooks/add_product_supplier_quantity_hook.dart';
import '../../../../../../core/app_widgets/app_drop_down_menu_widget.dart';
import '../../../../../../core/file_upload/picked_file_controller.dart';
import '../../../../../../core/resource/font_manager.dart';
import '../../../../../../core/resource/values_manager.dart';
import '../../hooks/add_product_supplier_ar_name.dart';
import '../../hooks/add_product_supplier_en_name.dart';
import '../../hooks/add_product_supplier_pieces_hook .dart';
import '../../hooks/add_product_supplier_price_hook .dart';
import '../../providers/add_product_supplier_controller_provider.dart';

class ListViewFeilds extends HookConsumerWidget {
  final int id;
  const ListViewFeilds({super.key,required this.id});

  @override
  Widget build(BuildContext context,ref) {
    if (fieldsData.isEmpty) {
      return const Center(child: CircularProgressIndicator()); // or SizedBox.shrink() if you want to skip
    }
    // final fields = ref.watch(
    //   categorySupplierControllerProvider.select((state) => state.fields),
    // );
    // final stateee = ref.watch(categorySupplierControllerProvider);
    // print('Watched fields: ${stateee.fields}');
    // if (fields.isEmpty) {
    //   // Show loading or message
    //   return const Center(child: CircularProgressIndicator());
    // }
    // print('fields>>'+fieldsData.toString());
    final state = ref.watch(addProductControllerProvider);
    final selectedInitial = fieldsData.firstWhereOrNull(
          (field) => field.id == state.filedId,
    );
    final nameArController = useAddProductNameArController(ref: ref);
    final nameEnController = useAddProductNameEnController(ref: ref);
    final descArController = useAddProductDescArController(ref: ref);
    final descEnController = useAddProductDescEnController(ref: ref);
    final minOrderController = useAddProductMinOrderController(ref: ref);
    final piecesController = useAddProductPiecesController(ref: ref);
    final priceController = useAddProductPriceController(ref: ref);
    final quantityController = useAddProductQuantityController(ref: ref);
    final controller = ref.read(addProductControllerProvider.notifier);
    useEffect(() {
      if (!state.isEditMode) {
        nameArController.clear();
        nameEnController.clear();
        descArController.clear();
        descEnController.clear();
        minOrderController.clear();
        piecesController.clear();
        priceController.clear();
        quantityController.clear();
      } else {
        // print('fidkdk>>'+state.filedId.toString());
        nameArController.text = state.nameAr ?? '';
        nameEnController.text = state.nameEn ?? '';
        descArController.text = state.descAr ?? '';
        descEnController.text = state.descEn ?? '';
        minOrderController.text = state.minQty ?? '';
        piecesController.text = state.pieces ?? '';
        priceController.text = state.price ?? '';
        quantityController.text = state.quantity ?? '';
      }
      return null;
    }, [state.isEditMode]);

    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: AppPadding.p24),
      children: [
        Consumer(
          builder: (context, ref, _) {
            final pickedFile = ref.watch(pickedFileProvider);
            state.imageFile = pickedFile;
            // print('imageFile>>'+state.imageFile.toString());
            return GestureDetector(
              onTap: () {
                showSelectImageBottomSheet(context, ref);
              },
              child: SizedBox(
                width: double.infinity,
                height: 125,
                child: DottedBorderContainer(
                  child: pickedFile != null
                      ? ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.file(
                      pickedFile,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                    ),
                  )
                      : (state.existingImageUrl != null
                      ? ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: AppNetworkImageWidget(
                      url: state.existingImageUrl!,
                      fit: BoxFit.cover,
                    ),
                  )
                      : const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.add, size: 30, color: Colors.grey),
                      SizedBox(height: 8),
                      Text('صورة المنتج', style: TextStyle(color: Colors.grey)),
                    ],
                  )),

                  // child: pickedFile==null? const Column(
                  //   mainAxisAlignment:
                  //   MainAxisAlignment.center,
                  //   children: [
                  //     Icon(Icons.add,
                  //         size: 30, color: Colors.grey),
                  //     SizedBox(height: 8),
                  //     Text('صورة المنتج', style:
                  //         TextStyle(color: Colors.grey)),
                  //   ],
                  // ) : ClipRRect(
                  //   borderRadius: BorderRadius.circular(12),
                  //   child: Image.file(
                  //     pickedFile,
                  //     fit: BoxFit.cover,
                  //     width: double.infinity,
                  //     height: double.infinity,
                  //   ),
                  // )
                  //   //   :AppNetworkImageWidget(url:model?.imageUrl??'',
                  //   // placeHolderEnum: PlaceHolderEnum.category,),
                ),
              ),
            );
          },
        ),
        // GestureDetector(
        //   onTap: () => controller.pickImage(),
        //   child: Column(
        //     crossAxisAlignment: CrossAxisAlignment.start,
        //     children: [
        //       state.imageFile != null
        //           ? Image.file(state.imageFile!, width: double.infinity, fit: BoxFit.cover)
        //           : Image.asset("assets/images/frame_image.png", width: double.infinity, fit: BoxFit.cover),
        //       if (state.imageFile == null && state.Touched)
        //         const Padding(
        //           padding: EdgeInsets.only(top: 8.0),
        //           child: Text("الصورة مطلوبة", style: TextStyle(color: Colors.red, fontSize: 12)),
        //         ),
        //     ],
        //   ),
        // ),
        const SizedBox(height: 16),
        _buildLabel("التصنيف"),
        AppDropDown<SupplierFieldsData>(
          getLabel: (item) => item.name ?? '',
          initialValue:selectedInitial,
          options: fieldsData,
          // label: 'التصنيف',
          onChange: (value) {
            print('test>>');
            state.filedId = value?.id??0;
            controller.selectCategory(value?.name??'');
          },
        ),
        // AppDropdownWidget(
        //   hintText: "اختر التصنيف",
        //   value: state.selectedCategory,
        //   itemsValues: ["PIECE", "KG", "G", "LITER", "ML", "BOX", "DOZEN", "METER"],
        //   errorText: state.Touched && (state.selectedCategory == null || state.selectedCategory!.isEmpty)
        //       ? "هذا الحقل مطلوب"
        //       : "",
        //   onChanged: controller.selectCategory,
        // ),
        const SizedBox(height: 16),
        _buildLabel("اسم المنتج - عربي"),
        AppTextFieldWidget(
          hintText: "ادخل اسم المنتج",
          controller: nameArController,
          errorText: state.Touched && state.nameAr.trim().isEmpty ? "هذا الحقل مطلوب" : "",
        ),
        const SizedBox(height: 16),
        _buildLabel("اسم المنتج - EN"),
        AppTextFieldWidget(
          hintText: "ادخل اسم المنتج",
          controller: nameEnController,
          errorText: state.Touched && state.nameEn.trim().isEmpty ? "هذا الحقل مطلوب" : "",
        ),
        const SizedBox(height: 16),
        _buildLabel("الحالة"),
        AppDropdownWidget(
          hintText: "اختر الحالة",
          value: state.selectedStatus,
          itemsValues: ["DRAFT", "PUBLISHED", "REJECTED"],
          errorText: state.Touched && (state.selectedStatus == null || state.selectedStatus!.isEmpty)
              ? "هذا الحقل مطلوب"
              : "",
          onChanged: controller.selectStatus,
        ),
        const SizedBox(height: 16),
        _buildLabel("الكمية"),
        AppTextFieldWidget(
          hintText: "ادخل الكمية",
          keyboardType: TextInputType.number,
          controller: quantityController,
          errorText: state.Touched && state.quantity.trim().isEmpty ? "هذا الحقل مطلوب" : "",
        ),
        const SizedBox(height: 16),
        _buildLabel("اقل عدد للطلب"),
        AppTextFieldWidget(
          hintText: "ادخل اقل قيمة",
          keyboardType: TextInputType.number,
          controller: minOrderController,
          errorText: state.Touched && state.minQty.trim().isEmpty ? "هذا الحقل مطلوب" : "",
        ),
        const SizedBox(height: 16),
        _buildLabel("السعر"),
        AppTextFieldWidget(
          hintText: "ادخل السعر",
          keyboardType: TextInputType.number,
          controller: priceController,
          errorText: state.Touched && state.price.trim().isEmpty ? "هذا الحقل مطلوب" : "",
        ),
        const SizedBox(height: 16),
        _buildLabel("عدد القطع"),
        AppTextFieldWidget(
          hintText: "ادخل العدد",
          keyboardType: TextInputType.number,
          controller: piecesController,
          errorText: state.Touched && state.pieces.trim().isEmpty ? "هذا الحقل مطلوب" : "",
        ),
        const SizedBox(height: 16),
        _buildLabel("الوصف عربي"),
        AppTextFieldWidget(
          hintText: "ادخل الوصف",
          maxLines: 3,
          controller: descArController,
          errorText: state.Touched && state.descAr.trim().isEmpty ? "هذا الحقل مطلوب" : "",
        ),
        const SizedBox(height: 16),
        _buildLabel("الوصف EN"),
        AppTextFieldWidget(
          hintText: "ادخل الوصف",
          maxLines: 3,
          controller: descEnController,
          errorText: state.Touched && state.descEn.trim().isEmpty ? "هذا الحقل مطلوب" : "",
        ),
        const SizedBox(height: 24),
        AppButtonWidget(
          label: "تم تسليم الطلب",
          onPressed: () async {
            final result = await controller.submitProduct(!state.isEditMode?-1:id);
            result.fold((failure) {
                context.showMessage(message: failure.message);
              }, (_) {
                Navigator.pop(context, true);
                if(state.isEditMode){
                  context.showMessage(
                    message: 'تم تعديل عنصر بنجاح',
                    messageType: MessageType.success,
                  );
                }else{
                  context.showMessage(
                    message: 'تم اضافة عنصر بنجاح',
                    messageType: MessageType.success,
                  );
                }
              },
            );
            // if(result is Left<Failure, Unit>){
            //   context.showMessage(message: "حدث خطأ .. لم تتم الاضافة");
            // }else{
            //   Navigator.pop(context, true);
            //   context.showMessage(message: 'تم اضافة عنصر بنجاح',messageType:MessageType.success);
            // };
          },
        ),
        const SizedBox(height: 20),
      ],
    );
  }
  Widget _buildLabel(String label) {
    return Text(
      label,
      style: StyleManager.getRegularStyle(
        color: ColorManager.blackColor,
        fontSize: FontSize.s16,
      ),
    );
  }
}