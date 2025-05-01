import 'package:flutter/cupertino.dart';

import 'constant_styles.dart';

class TextThemeConstrants {
  static TextStyle titleText = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: cc.titleTexts,
  );
  static TextStyle paragraphText = TextStyle(
    fontSize: 13,
    color: cc.greyParagraph,
  );
  static TextStyle greyHint13 = TextStyle(
    fontSize: 13,
    color: cc.greyHint,
  );
  static TextStyle greyHint13Eclipse = TextStyle(
    fontSize: 13,
    color: cc.greyHint,
    overflow: TextOverflow.ellipsis,
  );
  static TextStyle primary13 = TextStyle(
    color: cc.primaryColor,
    fontWeight: FontWeight.w600,
    fontSize: 13,
  );
}
