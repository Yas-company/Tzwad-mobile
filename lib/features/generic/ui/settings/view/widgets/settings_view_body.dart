import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:tzwad_mobile/core/app_widgets/app_ripple_widget.dart';
import 'package:tzwad_mobile/core/app_widgets/app_svg_picture_widget.dart';
import 'package:tzwad_mobile/core/extension/widget_extension.dart';
import 'package:tzwad_mobile/core/resource/assets_manager.dart';
import 'package:tzwad_mobile/core/resource/color_manager.dart';
import 'package:tzwad_mobile/core/resource/font_manager.dart';
import 'package:tzwad_mobile/core/resource/style_manager.dart';
import 'package:tzwad_mobile/core/resource/values_manager.dart';
import 'package:tzwad_mobile/core/routes/app_routes.dart';

import 'logout_dialog.dart';
import 'settings_app_bar_widget.dart';

class SettingsViewBody extends StatelessWidget {
  const SettingsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        const SliverAppBar(
          // leading: IconButton(
          //   onPressed: () => _onPressedSkipButton(context),
          //   icon: const Icon(Icons.close),
          // ),
          automaticallyImplyLeading: false,
          pinned: true,
          expandedHeight: AppSize.s220,
          flexibleSpace: FlexibleSpaceBar(
            centerTitle: true,
            background: SettingsAppBarWidget(),
          ),
        ),
        SliverFillRemaining(
          hasScrollBody: false,
          child: Column(
            children: [
              const Gap(
                AppPadding.p16,
              ),
              _itemSetting(
                title: 'My Orders',
                assetIcon: AssetsManager.icOrders,
                onTap: () => _onPressedOrdersButton(context),
              ),
              _itemSetting(
                title: 'Change Password',
                assetIcon: AssetsManager.icChangePassword,
                onTap: () => _onPressedChangePasswordButton(context),
              ),
              _itemSetting(
                title: 'Delete Account',
                assetIcon: AssetsManager.icDeleteAccount,
                onTap: () => _onPressedDeleteAccountButton(context),
              ),
              _itemSetting(
                title: 'Logout',
                assetIcon: AssetsManager.icLogout,
                onTap: () => _onPressedLogoutButton(context),
              ),
              const Gap(
                AppPadding.p16,
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget _itemSetting({
    required String title,
    required String assetIcon,
    required Function onTap,
  }) {
    return AppRippleWidget(
      onTap: () => onTap(),
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p16),
        child: Row(
          children: [
            AppSvgPictureWidget(
              assetName: assetIcon,
              color: ColorManager.colorPrimary,
              width: AppSize.s24,
              height: AppSize.s24,
            ).marginOnly(
              end: AppPadding.p8,
            ),
            Text(
              title,
              style: StyleManager.getMediumStyle(
                color: ColorManager.blackColor,
                fontSize: FontSize.s16,
              ),
            ),
          ],
        ),
      ),
    );
  }

  _onPressedOrdersButton(BuildContext context) {
    context.pushNamed(AppRoutes.underDevelopmentRoute);
  }

  _onPressedChangePasswordButton(BuildContext context) {
    context.pushNamed(AppRoutes.changePasswordRoute);
  }

  _onPressedDeleteAccountButton(BuildContext context) {
    context.pushNamed(AppRoutes.underDevelopmentRoute);
  }

  _onPressedLogoutButton(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => const LogoutDialog(),
    );
  }
}
