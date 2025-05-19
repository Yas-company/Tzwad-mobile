import 'package:tzwad_mobile/core/network/api_service.dart';
import 'package:tzwad_mobile/core/network/constants_api.dart';
import 'package:tzwad_mobile/core/network/error_handler.dart';
import 'package:tzwad_mobile/core/network/failure.dart';
import 'package:tzwad_mobile/core/util/state_render/result.dart';
import 'package:tzwad_mobile/features/category/models/category_model.dart';

class CategoryRepository {
  final ApiService apiService;

  CategoryRepository({
    required this.apiService,
  });

  Future<Result<Failure, List<CategoryModel>>> getCategories() async {
    try {
      final response = await apiService.get<List<CategoryModel>>(
        url: ConstantsApi.getCategoriesUrl,
        fromJsonListT: CategoryModel.fromJsonList,
      );
      return Right(response.data ?? []);
    } catch (error) {
      return Left(ErrorHandler.handle(error).failure);
    }
  }

  Future<Result<Failure, CategoryModel>> getCategory({required int id}) async {
    try {
      final response = await apiService.get<CategoryModel>(
        url: ConstantsApi.getCategoryDetailsUrl(id),
        fromJsonT: CategoryModel.fromJson,
      );
      if (response.data != null) {
        return Right(response.data!);
      } else {
        return Left(Failure(code: 0, message: 'Category not found'));
      }
    } catch (error) {
      return Left(ErrorHandler.handle(error).failure);
    }
  }
}
