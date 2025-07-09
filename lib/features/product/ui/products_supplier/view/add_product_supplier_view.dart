import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tzwad_mobile/core/file_upload/picked_file_controller.dart';
import 'package:tzwad_mobile/core/file_upload/select_image_bottom_sheet.dart';
import 'package:tzwad_mobile/core/resource/color_manager.dart';
import 'package:tzwad_mobile/core/resource/style_manager.dart';
import 'package:tzwad_mobile/core/util/data_state.dart';
import 'package:tzwad_mobile/features/product/models/add_supplier_product_request_model.dart';
import 'package:tzwad_mobile/features/product/providers/supplier_categories_provider.dart';

class AddProductSupplierView extends ConsumerWidget {
  const AddProductSupplierView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final arabicController = ref.watch(arabicNameControllerProvider);
    final englishController = ref.watch(englishNameControllerProvider);

    final isLoading = ref.watch(
      productSupplierControllerProvider.select(
            (state) => state.createCategoryState == DataState.loading,
      ),
    );

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
                                  child: pickedFile == null
                                      ? const Column(
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
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
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
                            onPressed: () {
                              final arabicName = ref
                                  .read(arabicNameControllerProvider)
                                  .text
                                  .trim();
                              final englishName = ref
                                  .read(englishNameControllerProvider)
                                  .text
                                  .trim();
                              final imageFile = ref.read(pickedFileProvider);

                              final request = AddSupplierProductRequestModel(
                                nameAr: arabicName,
                                nameEn: englishName,
                                fieldId: 1,
                                images: imageFile ?? File(''),
                              );

                              ref
                                  .read(productSupplierControllerProvider.notifier)
                                  .addSupplierCategory(request)
                                  .then((_) {
                                Navigator.pop(context, true);
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              backgroundColor: ColorManager.colorPrimary,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                            ),
                            child: Text(
                              'تم تسليم الطلب',
                              style: StyleManager.getRegularStyle(
                                color: ColorManager.colorWhite1,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
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
}

class DottedBorderContainer extends StatelessWidget {
  final Widget child;
  final double strokeWidth;
  final double radius;
  final Color color;

  const DottedBorderContainer({
    super.key,
    required this.child,
    this.strokeWidth = 1,
    this.radius = 12,
    this.color = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _DottedBorderPainter(
        strokeWidth: strokeWidth,
        radius: radius,
        color: color,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: child,
      ),
    );
  }
}

class _DottedBorderPainter extends CustomPainter {
  final double strokeWidth;
  final double radius;
  final Color color;

  _DottedBorderPainter({
    required this.strokeWidth,
    required this.radius,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final RRect rrect = RRect.fromRectAndRadius(
      Offset.zero & size,
      Radius.circular(radius),
    );

    const double dashWidth = 5;
    const double dashSpace = 3;
    Path path = Path()..addRRect(rrect);
    PathMetrics pm = path.computeMetrics();
    for (final metric in pm) {
      double distance = 0;
      while (distance < metric.length) {
        final next = distance + dashWidth;
        canvas.drawPath(
          metric.extractPath(distance, next),
          paint,
        );
        distance = next + dashSpace;
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
