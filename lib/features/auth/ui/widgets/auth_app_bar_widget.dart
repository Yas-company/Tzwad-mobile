import 'package:flutter/material.dart';
import 'package:tzwad_mobile/core/resource/assets_manager.dart';

class AuthAppBarWidget extends StatelessWidget {
  const AuthAppBarWidget({super.key});

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
        child: Image.asset(AssetsManager.imgAuthHeader),
      ),
    );
  }
}
