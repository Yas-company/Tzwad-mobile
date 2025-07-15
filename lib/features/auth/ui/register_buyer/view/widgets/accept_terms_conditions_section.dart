import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:tzwad_mobile/core/app_widgets/app_ripple_widget.dart';
import 'package:tzwad_mobile/core/resource/color_manager.dart';
import 'package:tzwad_mobile/core/resource/language_manager.dart';
import 'package:tzwad_mobile/core/resource/string_manager.dart';
import 'package:tzwad_mobile/core/resource/style_manager.dart';
import 'package:tzwad_mobile/core/resource/values_manager.dart';
import 'package:flutter/gestures.dart';
import 'package:tzwad_mobile/features/auth/ui/register_buyer/providers/register_controller_provider.dart';

class AcceptTermsConditionsSection extends ConsumerWidget {
  const AcceptTermsConditionsSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isAccept = ref.watch(
      registerBuyerControllerProvider.select(
        (value) => value.isAcceptTerms,
      ),
    );
    return Row(
      children: [
        Flexible(
          child: AppRippleWidget(
            radius: AppSize.s4,
            onTap: () {
              ref
                  .read(registerBuyerControllerProvider.notifier)
                  .changeAcceptTerms();
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: AppSize.s24,
                  height: AppSize.s24,
                  decoration: BoxDecoration(
                    color: isAccept ? ColorManager.colorPrimary : null,
                    border: isAccept
                        ? null
                        : Border.all(color: ColorManager.greyBorder),
                    borderRadius: BorderRadius.circular(AppSize.s8),
                  ),
                  alignment: Alignment.center,
                  child: const Icon(
                    Icons.check,
                    color: ColorManager.colorPureWhite,
                    size: AppSize.s18,
                  ),
                ),
                const Gap(
                  AppPadding.p4,
                ),
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      style: StyleManager.getSemiBoldStyle(
                        color: ColorManager.greyParagraph,
                      ),
                      children: [
                        TextSpan(
                          text: AppStrings.strAccept.tr(context) + ' ',
                          style: StyleManager.getSemiBoldStyle(
                            color: ColorManager.greyParagraph,
                          ),
                        ),
                        TextSpan(
                          text: AppStrings.strTerms.tr(context),
                          style: StyleManager.getSemiBoldUnderlineStyle(
                            color: Colors.blue,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              debugPrint("Navigate to Terms Screen");
                            },
                        ),
                        const TextSpan(text: ' '),
                        TextSpan(
                          text: AppStrings.strConditions.tr(context),
                          style: StyleManager.getSemiBoldUnderlineStyle(
                            color: Colors.blue,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              debugPrint("Navigate to Conditions Screen");
                            },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
