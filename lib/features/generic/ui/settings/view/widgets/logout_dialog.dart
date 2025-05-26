import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tzwad_mobile/core/resource/color_manager.dart';
import 'package:tzwad_mobile/core/resource/font_manager.dart';
import 'package:tzwad_mobile/core/resource/style_manager.dart';
import 'package:tzwad_mobile/core/routes/app_routes.dart';
import 'package:tzwad_mobile/core/util/data_state.dart';
import 'package:tzwad_mobile/features/generic/ui/settings/controller/settings_state.dart';
import 'package:tzwad_mobile/features/generic/ui/settings/providers/settings_controller_provider.dart';

class LogoutDialog extends ConsumerWidget {
  const LogoutDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(
      settingsControllerProvider,
      (previous, next) => submitLogoutListener(context, previous, next),
    );
    return AlertDialog(
      title: Text(
        'Logout',
        style: StyleManager.getBoldStyle(
          color: ColorManager.blackColor,
          fontSize: FontSize.s18,
        ),
      ),
      content: Text(
        'Are you sure you want to logout?',
        style: StyleManager.getRegularStyle(
          color: ColorManager.blackColor,
          fontSize: FontSize.s14,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => _onPressedCancelButton(context),
          child: Text(
            'Cancel',
            style: StyleManager.getMediumStyle(
              color: ColorManager.colorRed,
            ),
          ),
        ),
        TextButton(
          onPressed: () => _onPressedLogoutButton(context, ref),
          child: Text(
            'Logout',
            style: StyleManager.getMediumStyle(
              color: ColorManager.colorPrimary,
            ),
          ),
        ),
      ],
    );
  }

  _onPressedCancelButton(BuildContext context) {
    context.pop();
  }

  _onPressedLogoutButton(BuildContext context, WidgetRef ref) {
    ref.read(settingsControllerProvider.notifier).logout();
  }

  void submitLogoutListener(BuildContext context, SettingsState? previous, SettingsState next) {
    if (previous?.submitLogoutDataState != next.submitLogoutDataState) {
      if (next.submitLogoutDataState == DataState.failure) {
        // context.showMessage(
        //   message: next.failure?.message ?? '',
        // );
      } else if (next.submitLogoutDataState == DataState.success) {
        context.pop();
        context.goNamed(AppRoutes.splashRoute);
      }
    }
  }
}
