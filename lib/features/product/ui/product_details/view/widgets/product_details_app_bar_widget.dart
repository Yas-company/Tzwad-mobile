import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:tzwad_mobile/core/app_widgets/app_network_image_widget.dart';
import 'package:tzwad_mobile/core/resource/assets_manager.dart';

class ProductDetailsAppBarWidget extends StatelessWidget {
  const ProductDetailsAppBarWidget({super.key, required this.url});

  final String url;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xffE3FFE5),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
        image: DecorationImage(
          image: AssetImage(AssetsManager.imgElements),
          repeat: ImageRepeat.repeat,
          opacity: .7,
        ),
      ),
      child: SizedBox(
        child: CachedNetworkImage(
          fit: BoxFit.cover,
          imageUrl: url,
          placeholder: (context, url) => const AppImagePlaceHolderWidget(
            placeHolderEnum: PlaceHolderEnum.product,
          ),
          errorWidget: (context, url, error) => const AppImagePlaceHolderWidget(
            placeHolderEnum: PlaceHolderEnum.product,
          ),
        ),
      ),
    );
  }
}
