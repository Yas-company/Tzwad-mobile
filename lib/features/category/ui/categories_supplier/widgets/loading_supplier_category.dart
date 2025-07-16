import 'package:flutter/material.dart';
import 'package:tzwad_mobile/core/resource/color_manager.dart';
import 'package:tzwad_mobile/core/resource/style_manager.dart';

class LoadingSupplierCategory extends StatelessWidget {
  const LoadingSupplierCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 16, right: 16, top: 18, bottom: 2),
      decoration: BoxDecoration(
        color: ColorManager.colorWhite3,
        border: Border.all(
          color: ColorManager.cardGreyHint.withOpacity(0.1),
        ),
      ),
      child: ListTile(
        trailing: const Padding(
          padding: EdgeInsets.only(bottom: 10),
          child: Icon(
            Icons.arrow_forward,
            color: ColorManager.colorBlack1,
            size: 24,
          ),
        ),
        title: Row(
          children: [
            Text(
              'name',
              style: StyleManager.getMediumStyle(
                color: ColorManager.colorBlack1,
                fontSize: 16,
              ),
            ),
            const SizedBox(width: 6),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: ColorManager.colorSecondary,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                '10',
                style: StyleManager.getRegularStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
        subtitle: const Text(
          'field',
          style: TextStyle(fontSize: 12),
        ),
      ),
    );
  }
}
