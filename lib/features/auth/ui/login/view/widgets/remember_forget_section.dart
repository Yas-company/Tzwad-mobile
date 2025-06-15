import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tzwad_mobile/core/app_widgets/app_ripple_widget.dart';
import 'package:tzwad_mobile/core/resource/color_manager.dart';
import 'package:tzwad_mobile/core/resource/font_manager.dart';
import 'package:tzwad_mobile/core/resource/language_manager.dart';
import 'package:tzwad_mobile/core/resource/string_manager.dart';
import 'package:tzwad_mobile/core/resource/style_manager.dart';
import 'package:tzwad_mobile/core/resource/values_manager.dart';
import 'package:tzwad_mobile/core/routes/app_routes.dart';
import 'package:tzwad_mobile/features/auth/ui/login/providers/login_controller_provider.dart';

class RememberForgetSection extends ConsumerWidget {
  const RememberForgetSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isRememberMe = ref.watch(
      loginControllerProvider.select(
        (value) => value.isRememberMe,
      ),
    );
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        // Remember Me
        // Flexible(
        //   child: AppRippleWidget(
        //     radius: AppSize.s4,
        //     onTap: () => _onPressedRememberMeButton(ref),
        //     child: Row(
        //       mainAxisSize: MainAxisSize.min,
        //       children: [
        //         Container(
        //           width: AppSize.s24,
        //           height: AppSize.s24,
        //           decoration: BoxDecoration(
        //             color: isRememberMe ? ColorManager.colorPrimary : null,
        //             border: isRememberMe ? null : Border.all(color: ColorManager.greyBorder),
        //             borderRadius: BorderRadius.circular(AppSize.s8),
        //           ),
        //           alignment: Alignment.center,
        //           child: const Icon(
        //             Icons.check,
        //             color: ColorManager.colorPureWhite,
        //             size: AppSize.s18,
        //           ),
        //         ),
        //         const Gap(
        //           AppPadding.p4,
        //         ),
        //         Text(
        //           AppStrings.strRememberMe.tr(context),
        //           style: StyleManager.getMediumStyle(
        //             color: ColorManager.greyHint,
        //           ),
        //         ),
        //       ],
        //     ),
        //   ),
        // ),

        // Forget Password
        Flexible(
          child: AppRippleWidget(
            radius: AppSize.s4,
            onTap: () => _onPressedForgetPasswordButton(context),
            child: Text(
              AppStrings.strForgetPassword.tr(context),
              style: StyleManager.getMediumStyle(
                color: ColorManager.colorPrimary,
                fontSize: FontSize.s14,
              ),
            ),
          ),
        ),
      ],
    );
  }

  _onPressedRememberMeButton(WidgetRef ref) {
    ref.read(loginControllerProvider.notifier).changeRememberMe();
  }

  _onPressedForgetPasswordButton(BuildContext context) {
    context.pushNamed(AppRoutes.forgetPasswordRoute);
  }
}
