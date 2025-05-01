import 'package:flutter/material.dart';

import '../utils/constant_colors.dart';
import '../../view/utils/constant_styles.dart';
import '../../view/utils/constant_name.dart';

class CartGridTile extends StatelessWidget {
  final String imageUrl;
  bool isSelected;
  CartGridTile(this.imageUrl, this.isSelected, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          // height: 1,
          width: screenWidth / 3,
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: ConstantColors().greyBorder2,
              width: 1,
            ),
            color: cc.pureWhite,
          ),
          child: Center(
            child: Image.network(
              imageUrl,
            ),
          ),
        ),
        if (isSelected)
          Container(
            // height: 1,
            width: screenWidth / 3,
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: ConstantColors().primaryColor,
                width: 1,
              ),
              color: const Color.fromARGB(43, 0, 177, 6),
            ),
            child: Center(
              child: Image.network(
                imageUrl,
                color: Colors.transparent,
              ),
            ),
          )
      ],
    );
  }
}
