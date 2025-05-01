import 'package:flutter/cupertino.dart';

class Product {
  final String id;
  String title;
  double amount;
  double discountPecentage;
  List<String> image;
  Product(
      {required this.id,
      required this.title,
      required this.amount,
      required this.discountPecentage,
      required this.image});
}

class Products with ChangeNotifier {
  final List<Product> _products = [
    Product(
      id: '01',
      title: 'Fresh Fruits',
      amount: 240,
      discountPecentage: 9.66,
      image: [
        'assets/images/product1.png',
        'assets/images/product1.png',
        'assets/images/product1.png',
        'assets/images/product1.png',
      ],
    ),
    Product(
      id: '02',
      title: 'Fresh Fruits',
      amount: 260,
      discountPecentage: 9.66,
      image: [
        'assets/images/product1.png',
        'assets/images/product1.png',
        'assets/images/product1.png',
        'assets/images/product1.png',
      ],
    ),
    Product(
      id: '03',
      title: 'Fresh Fruits',
      amount: 250,
      discountPecentage: 9.66,
      image: [
        'assets/images/product1.png',
        'assets/images/product1.png',
        'assets/images/product1.png',
        'assets/images/product1.png',
      ],
    ),
    Product(
      id: '04',
      title: 'Fresh Fruits',
      amount: 250,
      discountPecentage: 9.66,
      image: [
        'assets/images/product1.png',
        'assets/images/product1.png',
        'assets/images/product1.png',
        'assets/images/product1.png',
      ],
    ),
    Product(
      id: '05',
      title: 'Fresh Fruits',
      amount: 250,
      discountPecentage: 9.66,
      image: [
        'assets/images/product1.png',
        'assets/images/product1.png',
        'assets/images/product1.png',
        'assets/images/product1.png',
      ],
    ),
    Product(
      id: '06',
      title: 'Fresh Fruits',
      amount: 250,
      discountPecentage: 9.66,
      image: [
        'assets/images/product1.png',
        'assets/images/product1.png',
        'assets/images/product1.png',
        'assets/images/product1.png',
      ],
    ),
  ];

  List<Product> get products {
    return _products;
  }

  Future<void> fetchProducts() async {}
  Future<void> fetchCampaign() async {}
}
