import 'dart:io';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tzwad_mobile/core/app_widgets/app_drop_down.dart';
import 'package:tzwad_mobile/core/app_widgets/app_network_image_widget.dart';
import 'package:tzwad_mobile/core/extension/context_extension.dart';
import 'package:tzwad_mobile/core/file_upload/picked_file_controller.dart';
import 'package:tzwad_mobile/core/file_upload/select_image_bottom_sheet.dart';
import 'package:tzwad_mobile/core/resource/color_manager.dart';
import 'package:tzwad_mobile/core/resource/style_manager.dart';
import 'package:tzwad_mobile/core/util/data_state.dart';
import 'package:tzwad_mobile/features/category/ui/categories_supplier/widgets/dotted_border_container.dart';
import 'package:tzwad_mobile/features/product/models/add_supplier_product_request_model.dart';
import 'package:tzwad_mobile/features/product/models/supplier_fields_response_model.dart';
import 'package:tzwad_mobile/features/product/providers/supplier_categories_provider.dart';


class AddCategorySupplierView extends ConsumerWidget {
  final AddSupplierCategoryRequestModel? model;
  const AddCategorySupplierView({super.key,this.model});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final arabicController = ref.watch(arabicNameControllerProvider);
    final englishController = ref.watch(englishNameControllerProvider);
    final fields = ref.watch(
      categorySupplierControllerProvider.select((state) => state.fields),
    );
    // final selectedId = ref.watch(selectedSupplierFieldIdProvider);
    // final selectedItem = fields.firstWhereOrNull((e) => e.id == (model?.fieldId??0));

    final isLoading = ref.watch(
      categorySupplierControllerProvider.select(
            (state) => state.createCategoryState == DataState.loading,
      ),
    );
    final isInitialized = ref.watch(isInitializedProvider);

    if (!isInitialized && model != null && fields.isNotEmpty) {
      Future.microtask((){
        // print('selectedItem>>'+selectedId.toString());
        final match = fields.firstWhereOrNull((e) => e.id == (model?.fieldId??0));
        ref.read(selectedSupplierFieldIdProvider.notifier).set(match?.id ?? 0);
        arabicController.text = model?.nameAr ?? '';
        englishController.text = model?.nameEn ?? '';
        ref.read(isInitializedProvider.notifier).state = true;
      });
    }


    return Directionality(
      textDirection: TextDirection.rtl,
      child: Stack(
        children: [
          Scaffold(
            resizeToAvoidBottomInset: true,
            appBar: AppBar(
              title: Text(
                'إضافة تصنيف',
                style: StyleManager.getMediumStyle(
                  color: ColorManager.colorBlack1,
                  fontSize: 16,
                ),
              ),
              centerTitle: false,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_outlined),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            body: SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: MediaQuery.of(context).size.height -
                        kToolbarHeight -
                        MediaQuery.of(context).padding.top,
                  ),
                  child: IntrinsicHeight(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Consumer(
                          builder: (context, ref, _) {
                            final pickedFile = ref.watch(pickedFileProvider);
                            return GestureDetector(
                              onTap: () {
                                showSelectImageBottomSheet(context, ref);
                              },
                              child: SizedBox(
                                width: double.infinity,
                                height: 125,
                                child: DottedBorderContainer(
                                  child: pickedFile!=null?
                                  (pickedFile == null ? const Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.add,
                                          size: 30, color: Colors.grey),
                                      SizedBox(height: 8),
                                      Text('صورة التصنيف',
                                          style:
                                          TextStyle(color: Colors.grey)),
                                    ],
                                  )
                                      : ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: Image.file(
                                      pickedFile,
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                      height: double.infinity,
                                    ),
                                  )):AppNetworkImageWidget(url: model?.imageUrl??'',
                                  placeHolderEnum: PlaceHolderEnum.category,),
                                ),
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 24),
                        AppDropDown<SupplierFieldsData>(
                          getLabel: (item) => item.name ?? '',
                          initialValue: fields.firstWhereOrNull((e) =>
                          e.id == (model?.fieldId??0)),
                          options: fields,
                          label: 'التصنيف',
                          onChange: (value) {
                            if (value != null) {
                              ref.read(selectedSupplierFieldIdProvider.notifier).set(value.id ?? 0);
                            }
                          },
                        ),

                        // AppDropDown(
                        //   initialValue: initialValue,
                        //   options: mappedOptions,
                        //   borderColor:ColorManager.colorPrimary,
                        //   fillColor: Colors.white,borderRadius:2,
                        //   hintText:'التصنيف',keyValue:'name',
                        //   label:'التصنيف',isSpecializations:true,onChange:(value) {
                        //    print('value>>'+value.toString());
                        //   },),
                        const SizedBox(height: 24),
                        Text(
                          'اسم التصنيف - عربي',
                          style: StyleManager.getRegularStyle(
                            color: ColorManager.colorBlack1,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 8),
                        TextField(
                          controller: arabicController,
                          decoration: const InputDecoration(
                            hintText: 'ادخل اسم التصنيف',
                            fillColor: ColorManager.colorWhite3,
                            hintStyle: TextStyle(fontWeight: FontWeight.w200),
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'اسم التصنيف - EN',
                          style: StyleManager.getRegularStyle(
                            color: ColorManager.colorBlack1,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 8),
                        TextField(
                          controller: englishController,
                          decoration: const InputDecoration(
                            hintText: 'ادخل اسم التصنيف',
                            fillColor: ColorManager.colorWhite3,
                            hintStyle: TextStyle(fontWeight: FontWeight.w200),
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const Spacer(),
                        // SizedBox(height: 24),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed:() {
                              print('name>>'+arabicController.text.toString());
                              print('nameen>>'+englishController.text.toString());
                              // print('ididid>>'+s.id.toString());
                              bool isEdit = model?.isEdit??false;
                              final m = ref.read(selectedSupplierFieldIdProvider);
                              if(ref.read(selectedSupplierFieldIdProvider)==null||
                                  ref.read(selectedSupplierFieldIdProvider)==0){
                                context.showMessage(
                                  message: 'يرجي اختيار التصنيف',
                                  messageType: MessageType.error,
                                );
                                return;
                              }

                              if(arabicController.text.isEmpty||englishController.text.isEmpty){
                                context.showMessage(
                                  message: 'يرجي ادخال الاسم',
                                  messageType: MessageType.error,
                                );
                                return;
                              }

                              if((ref.read(pickedFileProvider) == null)){
                                context.showMessage(
                                  message: 'يرجي اختيار الصورة',
                                  messageType: MessageType.error,
                                );
                                return;
                              }

                              final arabicName = ref.read(arabicNameControllerProvider)
                                  .text.trim();
                              final englishName = ref.read(englishNameControllerProvider)
                                  .text.trim();
                              final imageFile = ref.read(pickedFileProvider);

                              final request = AddSupplierCategoryRequestModel(
                                nameAr: arabicName,
                                nameEn: englishName,
                                fieldId: ref.watch(selectedSupplierFieldIdProvider)??0,
                                image: imageFile ?? File(''),
                              );
                              final notifier = ref.read(categorySupplierControllerProvider.notifier);
                              final future = isEdit
                                  ? notifier.updateSupplierCategory(model?.id??0, request)
                                  : notifier.addSupplierCategory(request);
                              future.then((_) => Navigator.pop(context, true));
                            },
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              backgroundColor:ColorManager.colorPrimary,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                            ),
                            child: Text(
                              'تم تسليم الطلب',
                              style: StyleManager.getRegularStyle(
                                color:ColorManager.colorWhite1,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height:100,),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          if (isLoading)
            Positioned.fill(
              child: Container(
                color: Colors.black.withOpacity(0.3),
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            ),
        ],
      ),
    );
  }

  bool validateButton(WidgetRef ref,{File? file,required String nameAr,required String nameEN}){
    return file!=null && nameAr.isNotEmpty && nameEN.isNotEmpty;
  }
}


