import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tzwad_mobile/core/app_widgets/app_failure_widget.dart';
import 'package:tzwad_mobile/core/util/data_state.dart';
import 'package:tzwad_mobile/features/buyer/home/providers/home_buyer_controller_provider.dart';
import 'package:tzwad_mobile/features/buyer/supplier/models/supplier_model.dart';

import 'home_buyer_supplier_list_content.dart';

class HomeBuyerSuppliersSection extends ConsumerWidget {
  const HomeBuyerSuppliersSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(
      homeBuyerControllerProvider.select(
        (value) => value.getSuppliersDataState,
      ),
    );
    final items = ref.watch(
      homeBuyerControllerProvider.select(
        (value) => value.suppliers,
      ),
    );

    final failure = ref.watch(
      homeBuyerControllerProvider.select(
        (value) => value.failure,
      ),
    );
    switch (state) {
      case DataState.loading:
        return HomeBuyerSupplierListContent(
          items: SupplierModel.generateFakeList(),
          isLoading: true,
        );
      case DataState.success:
        return HomeBuyerSupplierListContent(
          items: items,
          isLoading: false,
        );
      case DataState.failure:
        return AppFailureWidget(
          failure: failure,
        );
      default:
        return const SizedBox();
    }
  }
}
