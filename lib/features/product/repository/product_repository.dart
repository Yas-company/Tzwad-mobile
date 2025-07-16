import 'dart:io';
import 'package:dio/dio.dart';
import 'package:tzwad_mobile/core/network/api_service.dart';
import 'package:tzwad_mobile/core/network/constants_api.dart';
import 'package:tzwad_mobile/core/network/error_handler.dart';
import 'package:tzwad_mobile/core/network/failure.dart';
import 'package:tzwad_mobile/core/util/data_models/page_model.dart';
import 'package:tzwad_mobile/core/util/state_render/result.dart';
import 'package:tzwad_mobile/core/util/unit.dart';
import 'package:tzwad_mobile/features/product/local_data/cart_local_data.dart';
import 'package:tzwad_mobile/features/product/local_data/favorite_product_local_data.dart';
import 'package:tzwad_mobile/features/product/models/cart_model.dart';
import 'package:tzwad_mobile/features/product/models/product_model.dart';
import 'package:tzwad_mobile/features/product/models/product_supplier_model.dart';


class ProductRepository {
  final ApiService apiService;
  final FavoriteProductLocalData favoriteProductLocalData;
  final CartLocalData cartLocalData;

  ProductRepository({
    required this.apiService,
    required this.favoriteProductLocalData,
    required this.cartLocalData,
  });

  Future<Result<Failure, PageModel<ProductModel>>> getProducts(
      {int page = 1}) async {
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
      return Left(ErrorHandler
          .handle(error)
          .failure);
    }
  }

  Future<Result<Failure, List<ProductModel>>> getProductsRelated(
      {required int id}) async {
    try {
      final response = await apiService.get<List<ProductModel>>(
        url: ConstantsApi.getProductsRelatedUrl(id),
        fromJsonListT: ProductModel.fromJsonList,
      );
      return Right(response.data ?? []);
    } catch (error) {
      return Left(ErrorHandler
          .handle(error)
          .failure);
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
      return Left(ErrorHandler
          .handle(error)
          .failure);
    }
  }

  Future<Result<Failure, PageModel<ProductModel>>> getFavoriteProducts(
      {int page = 1}) async {
    try {
      final response = await apiService.get<List<ProductModel>>(
          url: ConstantsApi.getFavoriteProductsUrl,
          fromJsonListT: ProductModel.fromJsonList,
          params: {
            'page': page,
          });
      return Right(
        PageModel<ProductModel>(
          data: response.data ?? [],
          hasMore: response.hasMore,
        ),
      );
    } catch (error) {
      return Left(ErrorHandler
          .handle(error)
          .failure);
    }
  }

  Future<Result<Failure, Unit>> addProductToFavorites({required int id}) async {
    try {
      await apiService.post<Unit>(
        url: ConstantsApi.addProductToFavoritesUrl,
        data: {
          'product_id': id,
        },
      );
      return const Right(unit);
    } catch (error) {
      return Left(ErrorHandler
          .handle(error)
          .failure);
    }
  }

  Future<Result<Failure, Unit>> removeProductFromFavorites(
      {required int id}) async {
    try {
      await apiService.delete(
        url: ConstantsApi.removeProductFromFavoritesUrl(id),
        // fromJsonT: ProductModel.fromJson,
      );
      return const Right(unit);
    } catch (error) {
      return Left(ErrorHandler
          .handle(error)
          .failure);
    }
  }

  Future<Result<Failure, PageModel<ProductModel>>> filterProducts({
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
          'page': page,
          'category_id': categoryId,
          'min_price': minPrice,
          'max_price': maxPrice,
          'q': search,
        },
      );
      return Right(
        PageModel<ProductModel>(
          data: response.data ?? [],
          hasMore: response.hasMore,
        ),
      );
    } catch (error) {
      return Left(ErrorHandler
          .handle(error)
          .failure);
    }
  }

  Future<Result<Failure, List<ProductModel>>> getCart() async {
    try {
      final response = await apiService.get<CartModel>(
        url: ConstantsApi.getCartUrl,
        fromJsonT: CartModel.fromJson,
      );
      return Right(response.data?.items ?? []);
    } catch (error) {
      return Left(ErrorHandler
          .handle(error)
          .failure);
    }
  }

  Future<Result<Failure, Unit>> addProductToCart({
    required int id,
    int quantity = 1,
  }) async {
    try {
      await apiService.post<Unit>(
        url: ConstantsApi.addProductToCartUrl,
        data: {
          'product_id': id,
          'quantity': quantity,
        },
      );
      return const Right(unit);
    } catch (error) {
      return Left(ErrorHandler
          .handle(error)
          .failure);
    }
  }

  Future<Result<Failure, Unit>> removeProductFromCart({required int id}) async {
    try {
      await apiService.delete(
        url: ConstantsApi.removeProductFromCartUrl(id),
        // fromJsonT: ProductModel.fromJson,
      );
      return const Right(unit);
    } catch (error) {
      return Left(ErrorHandler
          .handle(error)
          .failure);
    }
  }

  Future<Result<Failure, Unit>> updateProductQuantity({
    required int id,
    required int quantity,
  }) async {
    try {
      await apiService.patch(
        url: ConstantsApi.updateProductQuantityUrl(id),
        data: {
          'quantity': quantity,
        },
      );
      return const Right(unit);
    } catch (error) {
      return Left(ErrorHandler
          .handle(error)
          .failure);
    }
  }

  Future<Result<Failure, PageModel<ProductSupplierModel>>> getProductsSupplier(
      {int page = 1}) async {
    try {
      final response = await apiService.get<List<ProductSupplierModel>>(
        url: ConstantsApi.getProductsSupplierUrl,
        params: {'page': page},
        fromJsonListT: ProductSupplierModel.fromJsonList,
      );

      return Right(
        PageModel<ProductSupplierModel>(
          data: response.data ?? [],
          hasMore: response.hasMore,
        ),
      );
    } catch (error) {
      return Left(ErrorHandler
          .handle(error)
          .failure);
    }
  }

  Future<Result<Failure, Unit>> addProductSupplier({
    required int productId,
    required File imageFile,
    required String nameAr,
    required String nameEn,
    required String descriptionAr,
    required String descriptionEn,
    required num price,
    required num quantity,
    required num stockQty,
    required num unitType,
    required num status,
    required num categoryId,
    required num minOrderQuantity,
  }) async {
    try {
      final data = FormData.fromMap({
        'image': await MultipartFile.fromFile(
          imageFile.path,
          filename: imageFile.path
              .split('/')
              .last,
        ),
        'name[ar]': nameAr,
        'name[en]': nameEn,
        'description[ar]': descriptionAr,
        'description[en]': descriptionEn,
        'price': price,
        'quantity': quantity,
        'stock_qty': stockQty,
        'unit_type': unitType,
        'status': status,
        'category_id': categoryId,
        'min_order_quantity': minOrderQuantity,
      });

      print('productId>>'+productId.toString());
      await apiService.post<Unit>(
        url: productId==-1?ConstantsApi.addProductSupplierUrl:'${ConstantsApi.addProductSupplierUrl}/$productId',
        data: data,
      );

      return const Right(unit);
    } catch (error) {
      return Left(ErrorHandler
          .handle(error)
          .failure);
    }
  }

  Future<Result<Failure, Unit>> editProductSupplier({
    required String id,
    required String nameAr,
    required String nameEn,
    required String descriptionAr,
    required String descriptionEn,
    required String price,
    required String quantity,
    required String stockQty,
    required String unitType,
    required String status,
    required String categoryId,
    required String minOrderQuantity,
  }) async {
    try {
      final data = FormData.fromMap({
        'name[ar]': nameAr,
        'name[en]': nameEn,
        'description[ar]': descriptionAr,
        'description[en]': descriptionEn,
        'price': price,
        'quantity': quantity,
        'stock_qty': stockQty,
        'unit_type': unitType,
        'status': status,
        'category_id': categoryId,
        'min_order_quantity': minOrderQuantity,
      });

      await apiService.post<Unit>(
        url: ConstantsApi.editProductSupplierUrl(id),
        data: data,

      );

      return const Right(unit);
    } catch (error) {
      return Left(ErrorHandler
          .handle(error)
          .failure);
    }
  }



  Future<Result<Failure, Unit>> removeProductSupplier({required String id}) async {
    try {
      await apiService.delete(
        url: ConstantsApi.removeProductSupplierUrl(id),
        // fromJsonT: ProductModel.fromJson,
      );
      return const Right(unit);
    } catch (error) {
      return Left(ErrorHandler
          .handle(error)
          .failure);
    }
  }


}