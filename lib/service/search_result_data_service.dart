// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gren_mart/view/utils/constant_name.dart';
import '../../model/search_result_data_model.dart';
import '../../service/common_service.dart';
import 'package:http/http.dart' as http;

class SearchResultDataService with ChangeNotifier {
  List<Datum> searchResult = [];
  Meta? resultMeta;
  String searchText = '';
  RangeValues rangevalue = const RangeValues(0, 3500);
  String maxPrice = '';
  String minPrice = '';
  String ratingPoint = '0';
  bool isLoading = false;
  bool lastPage = false;
  String categoryId = '';
  String subCategoryId = '';
  String sortBy = '';
  int pageNumber = 2;
  bool noProduct = false;
  bool finterOn = false;
  bool error = false;
  List<String> sortOption = [
    'popularity',
    'latest',
    'price_low',
    'price_high',
  ];

  setRangeValues(value) {
    rangevalue = value;
    minPrice = rangevalue.start.toInt().toString();
    maxPrice = rangevalue.end.toInt().toString();
    notifyListeners();
  }

  setLastPage(value) {
    lastPage = value;
    notifyListeners();
  }

  nextPage() {
    if (lastPage) {
      return;
    }
    pageNumber++;
    notifyListeners();
  }

  setIsLoading(value) {
    isLoading = value;
    notifyListeners();
  }

  setSearchText(value) {
    searchText = value;
    notifyListeners();
  }

  setRating(value) {
    ratingPoint = value.toString();
    notifyListeners();
  }

  setCategoryId(value, {bool notListen = false}) {
    categoryId = value;
    if (notListen) {
      return;
    }
    notifyListeners();
  }

  setNoProduct(value) {
    noProduct = value;
    notifyListeners();
  }

  setSubCategoryId(value) {
    subCategoryId = value;
    notifyListeners();
  }

  setSortBy(value) {
    sortBy = value.toString();
    notifyListeners();
  }

  setFilterOn(value) {
    finterOn = value;
    notifyListeners();
  }

  resetSerch() {
    lastPage = false;
    searchResult = [];
    resultMeta = null;
    pageNumber = 2;
    finterOn = false;
    error = false;
    notifyListeners();
  }

  resetSerchFilters() {
    lastPage = false;
    searchResult = [];
    resultMeta = null;
    minPrice = '';
    maxPrice = '';
    categoryId = '';
    subCategoryId = '';
    ratingPoint = '0';
    sortBy = '';
    finterOn = false;
    error = false;

    rangevalue = const RangeValues(0, 3500);

    notifyListeners();
  }

  Future fetchProductsBy({String count = '', String pageNo = ''}) async {
    print(lastPage);
    if (lastPage) {
      setIsLoading(false);
      notifyListeners();
      print('Leaving fetching___________');
      return asProvider.getString('No more product found!');
    }
    print('searching in progress');
    final url = Uri.parse(
        '$baseApiUrl/product?count=&q=$searchText&cat=$categoryId&subcat=$subCategoryId&pr_min=$minPrice&pr_max=$maxPrice&rt=${ratingPoint == '0' ? '' : ratingPoint}&sort=$sortBy&page=$pageNo');
    print(url);
    // try {
    final response = await http.get(url);

    if (response.statusCode == 201) {
      var data = SearchResultDataModel.fromJson(jsonDecode(response.body));

      for (var element in data.data) {
        searchResult.add(element);
      }
      resultMeta = data.meta;

      setLastPage(resultMeta!.lastPage.toString() == pageNo ||
          resultMeta!.lastPage == 1);
      print(lastPage);
      print(pageNo);
      print(resultMeta!.lastPage.toString() + '-------------------');
      setIsLoading(false);
      setNoProduct(resultMeta!.total == 0);

      notifyListeners();
      return;
    }
    if (response.body.contains('message')) {
      throw 'error';
    }
    setNoProduct(true);
    // } catch (error) {
    //   print(error);
    //   if (pageNo != '1') {
    //     return asProvider.getString('Loading failed!');
    //   }
    //   this.error = true;
    //   notifyListeners();
    // }
  }
}
