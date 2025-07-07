import 'package:flutter/material.dart';
import 'package:tzwad_mobile/core/resource/color_manager.dart';
import 'package:tzwad_mobile/features/ads/models/ads_model.dart';

class ItemHomeAds extends StatelessWidget {
  const ItemHomeAds({
    super.key,
    required this.ads,
  });

  final AdsModel ads;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: ColorManager.colorGrey1,
      ),
      child: ads.image != null
          ? Image.network(
              ads.image ?? '',
            )
          : const SizedBox(),
    );
  }
}
