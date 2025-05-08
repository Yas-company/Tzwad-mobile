import 'package:flutter/material.dart';
import 'package:tzwad_mobile/core/extension/widget_extension.dart';
import 'package:tzwad_mobile/core/resource/values_manager.dart';
import 'package:tzwad_mobile/features/auth/ui/register/view/widgets/form_register_section.dart';
import 'package:tzwad_mobile/features/auth/ui/widgets/auth_app_bar_widget.dart';
import 'package:tzwad_mobile/features/auth/ui/widgets/horizontal_divider_section.dart';
import 'package:tzwad_mobile/features/auth/ui/widgets/social_auth_section.dart';

class RegisterViewBody extends StatelessWidget {
  const RegisterViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        const SliverAppBar(
          automaticallyImplyLeading: false,
          pinned: false,
          expandedHeight: AppSize.s220,
          flexibleSpace: FlexibleSpaceBar(
            background: AuthAppBarWidget(),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(AppPadding.p16),
            child: Column(
              children: [
                const FormRegisterSection().marginOnly(
                  bottom: AppPadding.p16,
                ),
                // Text.rich(
                //   TextSpan(
                //     text: AppStrings.strDontHaveAccount.tr(context),
                //     style: StyleManager.getRegularStyle(
                //       color: ColorManager.greyParagraph,
                //     ),
                //     children: [
                //       WidgetSpan(
                //         child: AppRippleWidget(
                //           // onTap: () => _onPressedRegisterButton(context),
                //           child: Text(
                //             AppStrings.strRegister.tr(context),
                //             style: StyleManager.getBoldStyle(
                //               color: ColorManager.colorPrimary,
                //             ),
                //           ),
                //         ),
                //       ),
                //     ],
                //   ),
                // ).marginOnly(
                //   bottom: AppPadding.p16,
                // ),
                const HorizontalDividerSection().marginOnly(
                  bottom: AppPadding.p16,
                ),
                const SocialAuthSection(
                  isRegister: true,
                ).marginOnly(
                  bottom: AppPadding.p16,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
