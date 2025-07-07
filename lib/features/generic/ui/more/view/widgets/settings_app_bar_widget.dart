import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tzwad_mobile/core/extension/string_extension.dart';
import 'package:tzwad_mobile/core/extension/widget_extension.dart';
import 'package:tzwad_mobile/core/resource/color_manager.dart';
import 'package:tzwad_mobile/core/resource/font_manager.dart';
import 'package:tzwad_mobile/core/resource/style_manager.dart';
import 'package:tzwad_mobile/core/resource/values_manager.dart';
import 'package:tzwad_mobile/features/auth/providers/user_local_data_provider.dart';

class SettingsAppBarWidget extends ConsumerWidget {
  const SettingsAppBarWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(
      userLocalDataProvider.select(
        (value) => value.getUserInfo(),
      ),
    );
    return Container(
      width: double.infinity,
      height: AppSize.s220,
      padding: const EdgeInsets.all(AppPadding.p16),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(15),
          bottomRight: Radius.circular(15),
        ),
        color: ColorManager.greyYellow,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          CircleAvatar(
            radius: AppSize.s54,
            backgroundColor: ColorManager.colorPrimary,
            child: Text(
              user?.name?.getPlaceHolderImage() ?? '',
              style: StyleManager.getBoldStyle(
                color: ColorManager.colorPureWhite,
                fontSize: FontSize.s20,
              ),
            ),
          ).marginOnly(
            bottom: AppPadding.p8,
          ),
          Text(
            user?.name ?? '',
            style: StyleManager.getMediumStyle(
              color: ColorManager.blackColor,
              fontSize: FontSize.s20,
            ),
          ),
        ],
      ),
    );
  }
}
