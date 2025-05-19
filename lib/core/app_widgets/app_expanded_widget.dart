import 'package:flutter/material.dart';
import 'package:tzwad_mobile/core/extension/widget_extension.dart';
import 'package:tzwad_mobile/core/resource/color_manager.dart';
import 'package:tzwad_mobile/core/resource/font_manager.dart';
import 'package:tzwad_mobile/core/resource/style_manager.dart';
import 'package:tzwad_mobile/core/resource/values_manager.dart';

class AppExpandedWidget extends StatefulWidget {
  const AppExpandedWidget({
    super.key,
    required this.title,
    required this.value,
  });

  final String title;
  final String value;

  @override
  State<AppExpandedWidget> createState() => _AppExpandedWidgetState();
}

class _AppExpandedWidgetState<T> extends State<AppExpandedWidget> with SingleTickerProviderStateMixin {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: StyleManager.getSemiBoldStyle(
            color: ColorManager.blackColor,
            fontSize: FontSize.s16,
          ),
        ).marginOnly(
          bottom: AppPadding.p8,
        ),
        Text(
          widget.value,
          style: StyleManager.getSemiBoldStyle(
            color: ColorManager.greyHint,
          ),
        ),
        // AppTextFieldWidget(
        //   controller: widget.controller,
        //   hintText: widget.hintText,
        //   readOnly: true,
        //   suffixIcon: Padding(
        //     padding: const EdgeInsets.all(AppPadding.p12),
        //     child: !widget.isLoading
        //         ? Transform.rotate(
        //             angle: isExpanded ? -3.14 : 0,
        //             child: const AppSvgPictureWidget(
        //               assetName: AssetsManager.icArrowBottomLight,
        //             ),
        //           )
        //         : const SizedBox(
        //             width: AppSize.s20,
        //             height: AppSize.s20,
        //             child: AppLoadingWidget(),
        //           ),
        //   ),
        //   onTap: () {
        //     setState(() {
        //       if (!widget.isLoading) {
        //         isExpanded = !isExpanded;
        //       }
        //     });
        //   },
        // ),
        AnimatedSize(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          child: isExpanded
              ? Material(
                  color: Colors.transparent,
                  child: Text(
                    widget.value,
                    style: StyleManager.getSemiBoldStyle(
                      color: ColorManager.greyHint,
                    ),
                  ),
                )
              : const SizedBox(), // Keeps the size transition smooth
        ),
      ],
    );
  }
}
