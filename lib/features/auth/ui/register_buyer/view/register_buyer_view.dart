import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tzwad_mobile/core/app_widgets/app_scaffold_widget.dart';
import 'widgets/register_buyer_view_body.dart';

class RegisterBuyerView extends StatelessWidget {
  const RegisterBuyerView({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffoldWidget(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => _onPressedBackButton(context),
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: const RegisterBuyerViewBody(),
      // body: Consumer(
      //   builder: (context, ref, child) {
      //     final status = ref.watch(
      //       registerControllerProvider.select(
      //         (value) => value.getLocationDataState,
      //       ),
      //     );
      //     switch (status) {
      //       case DataState.loading:
      //         return const Center(
      //           child: AppLoadingWidget(
      //             color: ColorManager.colorPrimary,
      //           ),
      //         );
      //       case DataState.success:
      //         return const RegisterViewBody();
      //       case DataState.failure:
      //         return const Center(
      //           child: RegisterLocationAccessDeniedWidget(),
      //         );
      //       default:
      //         return const SizedBox();
      //     }
      //   },
      // ),
    );
  }

  _onPressedBackButton(BuildContext context) {
    context.pop();
  }
}
