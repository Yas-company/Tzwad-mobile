import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tzwad_mobile/core/app_widgets/app_ripple_widget.dart';
import 'package:tzwad_mobile/core/extension/widget_extension.dart';
import 'package:tzwad_mobile/core/resource/color_manager.dart';
import 'package:tzwad_mobile/core/resource/language_manager.dart';
import 'package:tzwad_mobile/core/resource/string_manager.dart';
import 'package:tzwad_mobile/core/resource/style_manager.dart';
import 'package:tzwad_mobile/core/resource/values_manager.dart';
import 'package:tzwad_mobile/core/routes/app_routes.dart';
import 'package:tzwad_mobile/features/auth/ui/widgets/horizontal_divider_section.dart';
import 'package:tzwad_mobile/features/auth/ui/widgets/social_auth_section.dart';

import 'app_bar_login_widget.dart';
import 'form_login_section.dart';

class LoginViewBody extends StatelessWidget {
  const LoginViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        const SliverAppBar(
          automaticallyImplyLeading: false,
          pinned: false,
          expandedHeight: AppSize.s220,
          flexibleSpace: FlexibleSpaceBar(
            background: AppBarLoginWidget(),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(AppPadding.p16),
            child: Column(
              children: [
                const FormLoginSection().marginOnly(
                  bottom: AppPadding.p16,
                ),
                Text.rich(
                  TextSpan(
                    text: AppStrings.strDontHaveAccount.tr(context),
                    style: StyleManager.getRegularStyle(
                      color: ColorManager.greyParagraph,
                    ),
                    children: [
                      WidgetSpan(
                        child: AppRippleWidget(
                          onTap: () => _onPressedRegisterButton(context),
                          child: Text(
                            AppStrings.strRegister.tr(context),
                            style: StyleManager.getBoldStyle(
                              color: ColorManager.colorPrimary,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ).marginOnly(
                  bottom: AppPadding.p16,
                ),
                const HorizontalDividerSection().marginOnly(
                  bottom: AppPadding.p16,
                ),
                const SocialAuthSection().marginOnly(
                  bottom: AppPadding.p16,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  _onPressedRegisterButton(BuildContext context) {
    context.pushNamed(AppRoutes.registerRoute);
  }
}
