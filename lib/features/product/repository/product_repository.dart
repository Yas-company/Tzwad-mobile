import 'package:tzwad_mobile/core/network/api_service.dart';
import 'package:tzwad_mobile/core/network/constants_api.dart';
import 'package:tzwad_mobile/core/network/error_handler.dart';
import 'package:tzwad_mobile/core/network/failure.dart';
import 'package:tzwad_mobile/core/util/data_models/page_model.dart';
import 'package:tzwad_mobile/core/util/state_render/result.dart';
import 'package:tzwad_mobile/core/util/unit.dart';
import 'package:tzwad_mobile/features/product/local_data/cart_local_data.dart';
import 'package:tzwad_mobile/features/product/local_data/favorite_product_local_data.dart';
import 'package:tzwad_mobile/features/product/models/product_model.dart';

class ProductRepository {
  final ApiService apiService;
  final FavoriteProductLocalData favoriteProductLocalData;
  final CartLocalData cartLocalData;

  ProductRepository({
    required this.apiService,
    required this.favoriteProductLocalData,
    required this.cartLocalData,
  });

  Future<Result<Failure, PageModel<ProductModel>>> getProducts({int page = 1}) async {
    try {
      final response = await apiService.get<List<ProductModel>>(
        url: ConstantsApi.getProductsUrl,
        params: {
          'page': page,
        },
        fromJsonListT: ProductModel.fromJsonList,
      );
      return Right(
        PageModel<ProductModel>(
          data: response.data ?? [],
          hasMore: response.hasMore,
        ),
      );
    } catch (error) {
      return Left(ErrorHandler.handle(error).failure);
    }
  }

  Future<Result<Failure, ProductModel>> getProduct({required int id}) async {
    try {
      final response = await apiService.get<ProductModel>(
        url: ConstantsApi.getProductDetailsUrl(id),
        fromJsonT: ProductModel.fromJson,
      );
      if (response.data != null) {
        return Right(response.data!);
      } else {
        return Left(
          Failure(
            code: 0,
            message: 'Product not found',
          ),
        );
      }
    } catch (error) {
      return Left(ErrorHandler.handle(error).failure);
    }
  }

  Future<Result<Failure, PageModel<ProductModel>>> getFavoriteProducts({int page = 1}) async {
    try {
      final response = await apiService.get<List<ProductModel>>(
        url: ConstantsApi.getFavoriteProductsUrl,
        fromJsonListT: ProductModel.fromJsonList,
      );
      return Right(
        PageModel<ProductModel>(
          data: response.data ?? [],
          hasMore: response.hasMore,
        ),
      );
    } catch (error) {
      return Left(ErrorHandler.handle(error).failure);
    }
  }

  Future<Result<Failure, Unit>> addProductToFavorites({required int id}) async {
    try {
      await apiService.post<Unit>(url: ConstantsApi.addProductToFavoritesUrl, data: {
        'product_id': id,
      });
      return const Right(unit);
    } catch (error) {
      return Left(ErrorHandler.handle(error).failure);
    }
  }

  Future<Result<Failure, Unit>> removeProductFromFavorites({required int id}) async {
    try {
      await apiService.delete(
        url: ConstantsApi.removeProductFromFavoritesUrl(id),
        // fromJsonT: ProductModel.fromJson,
      );
      return const Right(unit);
    } catch (error) {
      return Left(ErrorHandler.handle(error).failure);
    }
  }

  Future<Result<Failure, List<ProductModel>>> filterProducts({
    int page = 1,
    int? categoryId,
    num? minPrice,
    num? maxPrice,
    String? search,
  }) async {
    try {
      final response = await apiService.get<List<ProductModel>>(
        url: ConstantsApi.filterProducts,
        fromJsonListT: ProductModel.fromJsonList,
        params: {
          'category_id': categoryId,
          'min_price': minPrice,
          'max_price': maxPrice,
          'q': search,
        },
      );
      return Right(response.data ?? []);
    } catch (error) {
      return Left(ErrorHandler.handle(error).failure);
    }
  }
}
