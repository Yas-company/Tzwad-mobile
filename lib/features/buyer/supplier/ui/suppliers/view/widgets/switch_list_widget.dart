import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tzwad_mobile/core/app_widgets/app_ripple_widget.dart';
import 'package:tzwad_mobile/core/app_widgets/app_svg_picture_widget.dart';
import 'package:tzwad_mobile/core/resource/assets_manager.dart';
import 'package:tzwad_mobile/core/resource/color_manager.dart';
import 'package:tzwad_mobile/core/resource/values_manager.dart';
import 'package:tzwad_mobile/features/buyer/supplier/ui/suppliers/providers/suppliers_controller_provider.dart';

class SwitchListWidget extends ConsumerWidget {
  const SwitchListWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isGridView = ref.watch(
      suppliersControllerProvider.select(
        (value) => value.isGridView,
      ),
    );
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            color: isGridView ? ColorManager.colorPrimary : ColorManager.colorWhite3,
            borderRadius: const BorderRadiusDirectional.only(
              topStart: Radius.circular(AppSize.s6),
              bottomStart: Radius.circular(AppSize.s6),
            ),
          ),
          child: AppRippleWidget(
            onTap: () => _onPressedGridViewButton(ref),
            child: Padding(
              padding: const EdgeInsets.all(AppPadding.p8),
              child: AppSvgPictureWidget(
                assetName: AssetsManager.icGrid,
                color: isGridView ? ColorManager.colorWhite1 : ColorManager.colorPrimary,
              ),
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: isGridView ? ColorManager.colorWhite3 : ColorManager.colorPrimary,
            borderRadius: const BorderRadiusDirectional.only(
              topEnd: Radius.circular(
                AppSize.s6,
              ),
              bottomEnd: Radius.circular(
                AppSize.s6,
              ),
            ),
          ),
          child: AppRippleWidget(
            onTap: () => _onPressedListViewButton(ref),
            child: Padding(
              padding: const EdgeInsets.all(AppPadding.p8),
              child: AppSvgPictureWidget(
                assetName: AssetsManager.icList,
                color: isGridView ? ColorManager.colorPrimary : ColorManager.colorWhite1,
              ),
            ),
          ),
        ),
      ],
    );
  }

  _onPressedGridViewButton(WidgetRef ref) {
    ref.read(suppliersControllerProvider.notifier).toggleView(true);
  }

  _onPressedListViewButton(WidgetRef ref) {
    ref.read(suppliersControllerProvider.notifier).toggleView(false);
  }
}
