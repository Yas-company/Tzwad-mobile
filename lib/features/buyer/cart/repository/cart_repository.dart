import 'package:tzwad_mobile/core/network/api_service.dart';
import 'package:tzwad_mobile/core/network/constants_api.dart';
import 'package:tzwad_mobile/core/network/error_handler.dart';
import 'package:tzwad_mobile/core/network/failure.dart';
import 'package:tzwad_mobile/core/util/state_render/result.dart';
import 'package:tzwad_mobile/core/util/unit.dart';
import 'package:tzwad_mobile/features/buyer/cart/models/cart_info_model.dart';
import 'package:tzwad_mobile/features/generic/local_data/setting_local_data.dart';

class CartRepository {
  final ApiService apiService;
  final SettingLocalData settingLocalData;

  CartRepository({
    required this.apiService,
    required this.settingLocalData,
  });

  Future<Result<Failure, CartInfoModel?>> getCart() async {
    try {
      final response = await apiService.get<CartInfoModel>(
        url: ConstantsApi.getCart,
        fromJsonT: CartInfoModel.fromJson,
      );
      return Right(response.data);
    } catch (error) {
      return Left(ErrorHandler.handle(error).failure);
    }
  }

  Future<Result<Failure, Unit>> addToCart({
    required int productId,
    int quantity = 1,
  }) async {
    try {
      await apiService.post<Unit>(
        url: ConstantsApi.addToCart,
        data: {
          'product_id': productId,
          'quantity': quantity,
        },
      );
      return const Right(unit);
    } catch (error) {
      return Left(ErrorHandler.handle(error).failure);
    }
  }

  Future<Result<Failure, Unit>> removeFromCart({
    required int productId,
  }) async {
    try {
      await apiService.delete<Unit>(
        url: ConstantsApi.removeFromCart(productId),
      );
      return const Right(unit);
    } catch (error) {
      return Left(ErrorHandler.handle(error).failure);
    }
  }

  Future<Result<Failure, Unit>> clearCart() async {
    try {
      await apiService.put<Unit>(
        url: ConstantsApi.clearCart,
      );
      return const Right(unit);
    } catch (error) {
      return Left(ErrorHandler.handle(error).failure);
    }
  }
}
