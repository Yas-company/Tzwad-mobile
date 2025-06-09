import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tzwad_mobile/core/app_widgets/app_ripple_widget.dart';
import 'package:tzwad_mobile/core/extension/widget_extension.dart';
import 'package:tzwad_mobile/core/resource/color_manager.dart';
import 'package:tzwad_mobile/core/resource/font_manager.dart';
import 'package:tzwad_mobile/core/resource/style_manager.dart';
import 'package:tzwad_mobile/core/resource/values_manager.dart';
import 'package:tzwad_mobile/core/routes/app_routes.dart';
import 'package:tzwad_mobile/features/auth/providers/user_local_data_provider.dart';

class HomeAppBarWidget extends ConsumerWidget implements PreferredSizeWidget {
  const HomeAppBarWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userLocalDataProvider.select(
      (value) => value.getUserInfo(),
    ));
    return SafeArea(
      child: Row(
        children: [
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text.rich(
                  TextSpan(
                    text: 'Hello, ',
                    style: StyleManager.getMediumStyle(
                      color: ColorManager.greyHint,
                      fontSize: FontSize.s12,
                    ),
                    children: [
                      TextSpan(
                        text: '${user?.name}',
                        style: StyleManager.getBoldStyle(
                          color: ColorManager.blackColor,
                          fontSize: FontSize.s14,
                        ),
                      )
                    ],
                  ),
                ).marginOnly(
                  bottom: AppPadding.p4,
                ),
                Text(
                  'Welcome to Tzawad',
                  style: StyleManager.getSemiBoldStyle(
                    color: ColorManager.colorTitleTexts,
                    fontSize: FontSize.s16,
                  ),
                ),
              ],
            ),
          ),
          AppRippleWidget(
            radius: AppSize.s54,
            onTap: () => _onPressedImageUserButton(context),
            child: CircleAvatar(
              backgroundColor: ColorManager.colorPrimary,
              radius: AppSize.s24,
              child: Text(
                getPlaceHolderImage(user?.name),
                style: StyleManager.getBoldStyle(
                  color: ColorManager.colorPureWhite,
                  fontSize: FontSize.s16,
                ),
              ),
            ),
          )
        ],
      ).marginOnly(
        start: AppPadding.p16,
        end: AppPadding.p16,
        top: AppPadding.p4,
        bottom: AppPadding.p4,
      ),
    );
  }

  String getPlaceHolderImage(String? name) {
    if (name == null) return '';
    return name.split(' ').map((e) => e[0]).join('').toUpperCase();
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  _onPressedImageUserButton(BuildContext context) {
    context.goNamed(AppRoutes.settingsRoute);
  }
}
