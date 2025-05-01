import 'package:flutter/material.dart';
import 'package:gren_mart/view/utils/constant_name.dart';
import 'package:http/http.dart' as http;

import '../db/database_helper.dart';
import '../model/favorite_data_model.dart';
import '../view/utils/constant_styles.dart';
import 'common_service.dart';

class FavoriteDataService with ChangeNotifier {
  Map<String, Favorites> _favoriteItems = {};

  Map<String, Favorites> get favoriteItems {
    return _favoriteItems;
  }

  bool isfavorite(String id) {
    return _favoriteItems.containsKey(id);
  }

  void toggleFavorite(BuildContext context, id, String title, double price,
      String imgUrl, bool isCartable) async {
    if (_favoriteItems.containsKey(id.toString())) {
      deleteFavoriteItem(id.toString(), context);
      _favoriteItems.remove(id);
      notifyListeners();
      return;
    }

    await DbHelper.insert('favorite', {
      'productId': id.toString(),
      'title': title,
      'price': price,
      'imgUrl': imgUrl,
      'isCartable': isCartable ? 0 : 1
    });
    _favoriteItems.putIfAbsent(id.toString(),
        () => Favorites(id.toString(), title, price, imgUrl, isCartable));
    snackBar(context, asProvider.getString('Item added to favorite.'));
    notifyListeners();
  }

  void fetchFavorites() async {
    final dbData = await DbHelper.fetchDb('favorite');
    Map<String, Favorites> dataList = {};
    for (var element in dbData) {
      dataList.putIfAbsent(
          element['productId'].toString(),
          () => Favorites(element['productId'], element['title'],
              element['price'], element['imgUrl'], element['isCartable'] == 0));
    }
    _favoriteItems = dataList;
    notifyListeners();
    refreshFavList();
    print('fetching favorite');
  }

  void deleteFavoriteItem(id, BuildContext context) async {
    await DbHelper.deleteDbSI('favorite', id);
    _favoriteItems.removeWhere((key, value) => value.id == id);
    snackBar(context, asProvider.getString('Item removed from favorite.'),
        backgroundColor: cc.orange);
    notifyListeners();
  }

  refreshFavList() {
    try {
      favoriteItems.forEach((key, value) async {
        final url = Uri.parse('$baseApiUrl/product/$key');

        // try {
        final response = await http.get(url);
        if (response.statusCode != 200) {
          await DbHelper.deleteDbSI('favorite', value.id);
          _favoriteItems.removeWhere((key, value) => value.id == value.id);
          notifyListeners();
        }
      });
    } catch (e) {
      print(e);
    }
  }
}
