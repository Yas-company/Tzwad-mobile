import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tzwad_mobile/core/app_widgets/app_scaffold_widget.dart';
import 'package:tzwad_mobile/core/routes/app_args.dart';
import 'package:tzwad_mobile/features/order/ui/order_details/providers/order_details_controller_provider.dart';

import 'widgets/order_details_view_body.dart';

class OrderDetailsView extends ConsumerStatefulWidget {
  const OrderDetailsView({super.key});

  @override
  ConsumerState<OrderDetailsView> createState() => _OrderDetailsViewState();
}

class _OrderDetailsViewState extends ConsumerState<OrderDetailsView> {
  var id = 0;

  @override
  void initState() {
    super.initState();
    id = appArgs['order_id'];
    Future.microtask(
      () {
        final controller = ref.read(orderDetailsControllerProvider.notifier);
        controller.getOrder(id);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffoldWidget(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => _onPressedBackButton(context),
        ),
        title: Text('Order #$id'),
      ),
      body: const OrderDetailsViewBody(),
    );
  }

  _onPressedBackButton(BuildContext context) {
    context.pop();
  }
}
