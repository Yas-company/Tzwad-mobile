import 'package:hive_flutter/hive_flutter.dart';
import 'package:tzwad_mobile/core/extension/string_extension.dart';
import 'package:tzwad_mobile/features/auth/models/user_model.dart';
import 'package:tzwad_mobile/features/product/models/product_model.dart';

enum AppHiveAdapterEnum {
  userAdapter('user'),
  settingAdapter('setting'),
  cartAdapter('cart'),
  favoriteProductAdapter('favorite_product'),
  ;

  final String boxName;

  const AppHiveAdapterEnum(this.boxName);
}

Future<void> initHive() async {
  try {
    await Hive.initFlutter();
    Hive.registerAdapter(UserModelAdapter());
    Hive.registerAdapter(ProductModelAdapter());

    Future.wait(
      [
        Hive.openBox<UserModel>(AppHiveAdapterEnum.userAdapter.boxName),
        Hive.openBox<dynamic>(AppHiveAdapterEnum.settingAdapter.boxName),
        Hive.openBox<ProductModel>(AppHiveAdapterEnum.cartAdapter.boxName),
        Hive.openBox<ProductModel>(AppHiveAdapterEnum.favoriteProductAdapter.boxName),
      ],
    );
  } catch (e) {
    'Hive Exception: $e'.log();
  }
}

// final adapters = {
//   AppHiveAdapterEnum.userAdapter.boxName: UserModelAdapter(),
//   // AppHiveAdapterEnum.settingAdapter.boxName: UserModelAdapter(),
// };

// class AppHiveAdapter<T> {
//   final String boxName;
//   final TypeAdapter<T> adapter;
//
//   AppHiveAdapter({
//     required this.boxName,
//     required this.adapter,
//   });
// }
