import 'package:tzwad_mobile/core/local_data/app_hive_adapter_enum.dart';
import 'package:tzwad_mobile/core/local_data/app_local_data.dart';
import 'package:tzwad_mobile/features/product/models/product_model.dart';

class CartLocalData extends AppLocalData<ProductModel> {
  CartLocalData()
      : super(
          boxName: AppHiveAdapterEnum.cartAdapter.boxName,
        );

  List<ProductModel> getCartProducts() {
    return getAll();
  }

  void increaseProductToCart(ProductModel product) {
    product.quantity = product.quantity + 1;
    insert(product.id, product);
  }

  void decreaseProductToCart(ProductModel product) {
    product.quantity = product.quantity - 1;
    if (product.quantity == 0) {
      delete(product.id);
    } else {
      insert(product.id, product);
    }
  }

  void removeProductToCart(ProductModel product) {
    delete(product.id);
  }
}
