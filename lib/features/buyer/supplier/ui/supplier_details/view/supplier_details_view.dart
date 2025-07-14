import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tzwad_mobile/core/app_widgets/app_image_asset_widget.dart';
import 'package:tzwad_mobile/core/app_widgets/app_network_image_widget.dart';
import 'package:tzwad_mobile/core/app_widgets/app_scaffold_widget.dart';
import 'package:tzwad_mobile/core/extension/widget_extension.dart';
import 'package:tzwad_mobile/core/resource/values_manager.dart';
import 'package:tzwad_mobile/core/routes/app_args.dart';
import 'package:tzwad_mobile/features/buyer/supplier/ui/supplier_details/providers/supplier_details_controller_provider.dart';

import 'widgets/supplier_details_view_body.dart';

class SupplierDetailsView extends ConsumerStatefulWidget {
  const SupplierDetailsView({super.key});

  @override
  ConsumerState<SupplierDetailsView> createState() => _SupplierDetailsViewState();
}

class _SupplierDetailsViewState extends ConsumerState<SupplierDetailsView> {
  String supplierName = '';

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      final controller = ref.read(supplierDetailsControllerProvider.notifier);
      final supplierId = appArgs['supplier_id'] as int;
      controller.getCategories(supplierId);
      controller.getProducts(
        supplierId: supplierId,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffoldWidget(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => _onPressedBackButton(context),
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: Row(
          children: [
            AppNetworkImageWidget(
              url: appArgs['supplier_image'] ?? '',
              width: AppSize.s32,
              height: AppSize.s32,
              radius: AppSize.s8,
            ).marginOnly(
              end: AppPadding.p8,
            ),
            Text(appArgs['supplier_name'] ?? ''),
          ],
        ),
      ),
      body: const SupplierDetailsViewBody(),
    );
  }

  _onPressedBackButton(BuildContext context) {
    Navigator.pop(context);
  }
}
