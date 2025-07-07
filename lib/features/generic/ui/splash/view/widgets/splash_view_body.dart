import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tzwad_mobile/core/app_widgets/app_image_asset_widget.dart';
import 'package:tzwad_mobile/core/resource/assets_manager.dart';
import 'package:tzwad_mobile/core/routes/app_routes.dart';
import 'package:tzwad_mobile/features/auth/models/role_enum.dart';
import 'package:tzwad_mobile/features/auth/providers/user_local_data_provider.dart';
import 'package:tzwad_mobile/features/generic/providers/setting_local_data_provider.dart';

class SplashViewBody extends ConsumerStatefulWidget {
  const SplashViewBody({super.key});

  @override
  ConsumerState<SplashViewBody> createState() => _SplashViewBodyState();
}

class _SplashViewBodyState extends ConsumerState<SplashViewBody> {
  @override
  void initState() {
    super.initState();
    FlutterNativeSplash.remove();
    _goNext();
  }

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: [
          AppImageAssetWidget(
            imagePath: AssetsManager.imgSplash,
            fit: BoxFit.fill,
          ),
          // Positioned(
          //   bottom: 0,
          //   child: Container(
          //     width: retry ? null : screenWidth - 5,
          //     margin: EdgeInsets.only(bottom: screenHight / 3.5),
          //     child: retry ? SizedBox() : loadingProgressBar(),
          //   ),
          // ),
        ],
      ),
    );
  }

  void _goNext() async {
    await Future.delayed(const Duration(seconds: 2));
    if (!mounted) return;
    final settingLocalData = ref.read(
      settingLocalDataProvider,
    );

    if (!settingLocalData.isOnBoardingScreenViewed()) {
      context.pushReplacementNamed(AppRoutes.onboardingRoute);
    } else if (!settingLocalData.isUserLogged()) {
      context.pushReplacementNamed(AppRoutes.loginBuyerRoute);
    } else {
      _checkRole();
    }
  }

  _checkRole() {
    final user = ref.read(
      userLocalDataProvider.select(
        (value) => value.getUserInfo(),
      ),
    );
    if (user?.role == RoleEnum.buyer.value) {
      context.pushReplacementNamed(AppRoutes.homeBuyerRoute);
    } else if (user?.role == RoleEnum.supplier.value) {
      context.pushReplacementNamed(AppRoutes.homeSupplierRoute);
    } else {
      context.pushReplacementNamed(AppRoutes.loginBuyerRoute);
    }
  }
}
