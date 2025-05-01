import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gren_mart/view/utils/app_bars.dart';
import 'package:gren_mart/view/utils/constant_name.dart';
import 'package:photo_view/photo_view.dart';

import 'constant_styles.dart';

class ImageView extends StatelessWidget {
  String imageUrl;
  int? id;
  ImageView(this.imageUrl, {this.id, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBars().appBarTitled(context, '', () {
          Navigator.of(context).pop();
        }),
        body: Center(
          child: Hero(
              tag: id ?? '',
              child: PhotoView(
                backgroundDecoration:
                    const BoxDecoration(color: Colors.transparent),
                minScale: PhotoViewComputedScale.contained,
                maxScale: PhotoViewComputedScale.covered * 2.5,
                loadingBuilder:
                    (BuildContext context, ImageChunkEvent? loadingProgress) {
                  return loadingProgressBar();
                },
                errorBuilder: (context, exception, stackTrace) {
                  return Text(asProvider.getString('Connection failed!'));
                },
                imageProvider: imageUrl.contains('http')
                    ? NetworkImage(imageUrl) as ImageProvider<Object>?
                    : FileImage(File(imageUrl)),
              )),
        ));
  }
}
