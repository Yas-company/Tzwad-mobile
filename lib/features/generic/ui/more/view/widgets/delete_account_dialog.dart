import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tzwad_mobile/core/app_widgets/app_loading_widget.dart';
import 'package:tzwad_mobile/core/extension/context_extension.dart';
import 'package:tzwad_mobile/core/resource/color_manager.dart';
import 'package:tzwad_mobile/core/resource/font_manager.dart';
import 'package:tzwad_mobile/core/resource/style_manager.dart';
import 'package:tzwad_mobile/core/routes/app_routes.dart';
import 'package:tzwad_mobile/core/util/data_state.dart';
import 'package:tzwad_mobile/features/generic/ui/more/controller/more_state.dart';
import 'package:tzwad_mobile/features/generic/ui/more/providers/more_controller_provider.dart';

class DeleteAccountDialog extends ConsumerWidget {
  const DeleteAccountDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(
      moreControllerProvider,
      (previous, next) => submitDeleteAccountListener(context, previous, next),
    );
    final status = ref.watch(
      moreControllerProvider.select(
        (value) => value.submitDeleteAccountDataState,
      ),
    );
    return AlertDialog(
      title: Text(
        'Delete Account',
        style: StyleManager.getBoldStyle(
          color: ColorManager.blackColor,
          fontSize: FontSize.s18,
        ),
      ),
      content: Text(
        'Are you sure you want to delete account?',
        style: StyleManager.getRegularStyle(
          color: ColorManager.blackColor,
          fontSize: FontSize.s14,
        ),
      ),
      actions: [
        if (status == DataState.loading) ...{
          const AppLoadingWidget(
            color: ColorManager.colorPrimary,
          ),
        } else ...{
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
            onPressed: () => _onPressedDeleteAccountButton(context, ref),
            child: Text(
              'Delete Account',
              style: StyleManager.getMediumStyle(
                color: ColorManager.colorPrimary,
              ),
            ),
          ),
        },
      ],
    );
  }

  _onPressedCancelButton(BuildContext context) {
    context.pop();
  }

  _onPressedDeleteAccountButton(BuildContext context, WidgetRef ref) {
    ref.read(moreControllerProvider.notifier).deleteAccount();
  }

  void submitDeleteAccountListener(BuildContext context, MoreState? previous, MoreState next) {
    if (previous?.submitDeleteAccountDataState != next.submitDeleteAccountDataState) {
      if (next.submitDeleteAccountDataState == DataState.failure) {
        context.showMessage(
          message: next.failure?.message ?? '',
        );
      } else if (next.submitDeleteAccountDataState == DataState.success) {
        context.pop();
        context.goNamed(AppRoutes.splashRoute);
      }
    }
  }
}
