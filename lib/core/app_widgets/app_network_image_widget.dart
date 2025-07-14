import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:tzwad_mobile/core/resource/assets_manager.dart';
import 'package:tzwad_mobile/core/resource/values_manager.dart';

class AppNetworkImageWidget extends StatelessWidget {
  const AppNetworkImageWidget({
    super.key,
    required this.url,
     this.placeHolderEnum = PlaceHolderEnum.product,
    this.fit = BoxFit.cover,
    this.radius = AppSize.s0,
    this.height,
    this.width,
  });

  final String url;
  final BoxFit fit;
  final double radius;
  final double? height;
  final double? width;
  final PlaceHolderEnum placeHolderEnum;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radius),
        child: CachedNetworkImage(
          fit: fit,
          imageUrl: url,
          placeholder: (context, url) => AppImagePlaceHolderWidget(
            placeHolderEnum: placeHolderEnum,
          ),
          errorWidget: (context, url, error) => AppImagePlaceHolderWidget(
            placeHolderEnum: placeHolderEnum,
          ),
        ),
      ),
    );
  }
}

enum PlaceHolderEnum {
  product,
  category,
}

class AppImagePlaceHolderWidget extends StatelessWidget {
  const AppImagePlaceHolderWidget({
    super.key,
    required this.placeHolderEnum,
    this.width,
    this.height,
  });

  final PlaceHolderEnum placeHolderEnum;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    // final assetImage = placeHolderEnum == PlaceHolderEnum.product ? AssetsManager.imgProductPlaceHolder : AssetsManager.imgProductPlaceHolder;
    return Container(
      width: width,
      height: height,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(AssetsManager.imgPlaceHolder),
          opacity: .4,
        ),
      ),
    );
  }
}
