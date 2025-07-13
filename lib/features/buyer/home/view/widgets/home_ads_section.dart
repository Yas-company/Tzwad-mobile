import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tzwad_mobile/core/app_widgets/app_failure_widget.dart';
import 'package:tzwad_mobile/core/util/data_state.dart';
import 'package:tzwad_mobile/features/ads/models/ads_model.dart';
import 'package:tzwad_mobile/features/buyer/home/providers/home_buyer_controller_provider.dart';

import 'home_buyer_ads_list_content.dart';

class HomeAdsSection extends ConsumerWidget {
  const HomeAdsSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(
      homeBuyerControllerProvider.select(
        (value) => value.getAdsDataState,
      ),
    );
    final ads = ref.watch(
      homeBuyerControllerProvider.select(
        (value) => value.ads,
      ),
    );

    final failure = ref.watch(
      homeBuyerControllerProvider.select(
        (value) => value.failure,
      ),
    );
    switch (state) {
      case DataState.loading:
        return HomeBuyerAdsListContent(
          ads: AdsModel.generateFakeList(),
          isLoading: true,
        );
      case DataState.success:
        return HomeBuyerAdsListContent(
          ads: ads,
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
