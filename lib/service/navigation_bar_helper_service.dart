import 'package:flutter/cupertino.dart';

class NavigationBarHelperService with ChangeNotifier {
  var navigationIndex = 0;
  var serchText;

  setNavigationIndex(value) {
    navigationIndex = value;
    notifyListeners();
  }

  setSearchText(value) {
    serchText = value;
    notifyListeners();
  }
}
