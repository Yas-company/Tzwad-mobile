import 'package:flutter/material.dart';

enum MessageType { error, success, info }

extension ContextExtension on BuildContext {
  void dismissKeyboard() {
    final focus = FocusManager.instance.primaryFocus;
    if (focus != null) {
      focus.unfocus();
    }
  }

  get getHeight => MediaQuery.sizeOf(this).height;

  get getWidth => MediaQuery.sizeOf(this).width;

  bool get isRtl => Directionality.of(this) == TextDirection.rtl;

  bool get isMobile => getWidth <= 480;

  bool get isTablet => getWidth > 480 && getWidth < 800;

  bool get isDesktop => getWidth >= 800;

  // AdaptiveEnum getAdaptive() {
  //   if (isDesktop) {
  //     return AdaptiveEnum.desktop;
  //   }
  //   if (isTablet) {
  //     return AdaptiveEnum.tablet;
  //   }
  //   return AdaptiveEnum.mobile;
  // }

  // void showMessage({
  //   required String message,
  //   MessageType messageType = MessageType.error,
  // }) {
  //   final padding = EdgeInsets.symmetric(
  //     horizontal: isDesktop ? getWidth * 0.3 : AppPadding.p20,
  //   );
  //   const displayDuration = Duration(milliseconds: 1000);
  //   const snackBarPosition = SnackBarPosition.top;
  //
  //   switch (messageType) {
  //     case MessageType.error:
  //       showTopSnackBar(
  //         Overlay.of(this),
  //         padding: padding,
  //         displayDuration: displayDuration,
  //         snackBarPosition: snackBarPosition,
  //         CustomSnackBar.error(
  //           message: message,
  //           backgroundColor: ColorManager.colorRed,
  //           icon: const SizedBox(),
  //         ),
  //       );
  //       break;
  //     case MessageType.success:
  //       showTopSnackBar(
  //         Overlay.of(this),
  //         padding: padding,
  //         displayDuration: displayDuration,
  //         snackBarPosition: snackBarPosition,
  //         CustomSnackBar.success(
  //           message: message,
  //           icon: const SizedBox(),
  //         ),
  //       );
  //       break;
  //     case MessageType.info:
  //       showTopSnackBar(
  //         Overlay.of(this),
  //         padding: padding,
  //         displayDuration: displayDuration,
  //         snackBarPosition: snackBarPosition,
  //         CustomSnackBar.info(
  //           message: message,
  //           backgroundColor: ColorManager.colorPrimary,
  //           icon: const SizedBox(),
  //         ),
  //       );
  //       break;
  //   }
  // }
}
