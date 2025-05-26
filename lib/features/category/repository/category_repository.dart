import 'package:tzwad_mobile/core/network/api_service.dart';
import 'package:tzwad_mobile/core/network/constants_api.dart';
import 'package:tzwad_mobile/core/network/error_handler.dart';
import 'package:tzwad_mobile/core/network/failure.dart';
import 'package:tzwad_mobile/core/util/data_models/page_model.dart';
import 'package:tzwad_mobile/core/util/state_render/result.dart';
import 'package:tzwad_mobile/features/category/models/category_model.dart';
import 'package:tzwad_mobile/features/product/models/product_model.dart';

class CategoryRepository {
  final ApiService apiService;

  CategoryRepository({
    required this.apiService,
  });

  Future<Result<Failure, PageModel<CategoryModel>>> getCategories({int page = 1}) async {
    try {
      final response = await apiService.get<List<CategoryModel>>(
        url: ConstantsApi.getCategoriesUrl,
        params: {
          'page': page,
        },
        fromJsonListT: CategoryModel.fromJsonList,
      );
      return Right(
        PageModel<CategoryModel>(
          data: response.data ?? [],
          hasMore: response.hasMore,
        ),
      );
    } catch (error) {
      return Left(ErrorHandler.handle(error).failure);
    }
  }

  Future<Result<Failure, PageModel<ProductModel>>> getProductsByCategory({
    int page = 1,
    required int categoryId,
  }) async {
    try {
      final response = await apiService.get<List<ProductModel>>(
        url: ConstantsApi.getCategoryDetailsUrl(categoryId),
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
}
