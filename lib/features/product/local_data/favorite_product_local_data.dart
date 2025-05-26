import 'package:tzwad_mobile/core/local_data/app_hive_adapter_enum.dart';
import 'package:tzwad_mobile/core/local_data/app_local_data.dart';
import 'package:tzwad_mobile/features/product/models/product_model.dart';

class FavoriteProductLocalData extends AppLocalData<ProductModel> {
  FavoriteProductLocalData()
      : super(
          boxName: AppHiveAdapterEnum.favoriteProductAdapter.boxName,
        );

  List<ProductModel> getFavoriteProducts() {
    return getAll();
  }

  ProductModel? getProductById(int id) {
    return getByKey(id);
  }

  void addProductToFavorite(ProductModel product) {
    insert(product.id, product);
  }

  void removeProductFromFavorite(ProductModel product) {
    delete(product.id);
  }

  Future clearBox() async {
    await box.clear();
  }
}
