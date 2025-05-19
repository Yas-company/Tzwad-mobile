import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';

import 'item_home_ads.dart';

class HomeAdsSection extends StatelessWidget {
  const HomeAdsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 175,
      child: Swiper(
        itemBuilder: (BuildContext context, int index) => const ItemHomeAds(
          title: 'Lorem Ipsum is simply dummy text of',
          description: 'Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots',
        ),
        itemCount: 3,
        viewportFraction: 0.85,
        scale: 0.92,
        autoplay: true,
      ),
    );
  }
}
