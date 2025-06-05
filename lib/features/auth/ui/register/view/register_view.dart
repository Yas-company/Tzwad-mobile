import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tzwad_mobile/core/app_widgets/app_loading_widget.dart';
import 'package:tzwad_mobile/core/app_widgets/app_scaffold_widget.dart';
import 'package:tzwad_mobile/core/resource/color_manager.dart';
import 'package:tzwad_mobile/core/util/data_state.dart';
import 'package:tzwad_mobile/features/auth/ui/register/providers/register_controller_provider.dart';

import 'widgets/register_location_access_denied_widget.dart';
import 'widgets/register_view_body.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffoldWidget(
      userSafeArea: false,
      body: Consumer(
        builder: (context, ref, child) {
          final status = ref.watch(
            registerControllerProvider.select(
              (value) => value.getLocationDataState,
            ),
          );
          switch (status) {
            case DataState.loading:
              return const Center(
                child: AppLoadingWidget(
                  color: ColorManager.colorPrimary,
                ),
              );
            case DataState.success:
              return const RegisterViewBody();
            case DataState.failure:
              return const Center(
                child: RegisterLocationAccessDeniedWidget(),
              );
            default:
              return const SizedBox();
          }
        },
      ),
    );
  }
}
