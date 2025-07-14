import 'package:tzwad_mobile/core/network/api_service.dart';
import 'package:tzwad_mobile/core/network/constants_api.dart';
import 'package:tzwad_mobile/core/network/error_handler.dart';
import 'package:tzwad_mobile/core/network/failure.dart';
import 'package:tzwad_mobile/core/util/data_models/page_model.dart';
import 'package:tzwad_mobile/core/util/state_render/result.dart';
import 'package:tzwad_mobile/features/buyer/supplier/models/supplier_category_model.dart';
import 'package:tzwad_mobile/features/buyer/supplier/models/supplier_model.dart';
import 'package:tzwad_mobile/features/buyer/supplier/models/supplier_product_model.dart';
import 'package:tzwad_mobile/features/generic/local_data/setting_local_data.dart';

class SupplierRepository {
  final ApiService apiService;
  final SettingLocalData settingLocalData;

  SupplierRepository({
    required this.apiService,
    required this.settingLocalData,
  });

  Future<Result<Failure, PageModel<SupplierModel>>> getSuppliers({int page = 1}) async {
    try {
      final response = await apiService.get<List<SupplierModel>>(
        url: ConstantsApi.getSuppliers,
        params: {
          'page': page,
        },
        fromJsonListT: SupplierModel.fromJsonList,
      );
      return Right(
        PageModel<SupplierModel>(
          data: response.data ?? [],
          hasMore: response.hasMore,
        ),
      );
    } catch (error) {
      return Left(ErrorHandler.handle(error).failure);
    }
  }

  Future<Result<Failure, List<SupplierCategoryModel>>> getCategories({
    required int supplierId,
  }) async {
    try {
      final response = await apiService.get<List<SupplierCategoryModel>>(
        url: ConstantsApi.getSupplierCategories(supplierId),
        fromJsonListT: SupplierCategoryModel.fromJsonList,
      );
      List<SupplierCategoryModel> categories = response.data ?? [];
      categories.insert(
        0,
        SupplierCategoryModel(
          id: -1,
          name: 'الكل',
          isSelected: true,
        ),
      );
      return Right(categories);
    } catch (error) {
      return Left(ErrorHandler.handle(error).failure);
    }
  }

  Future<Result<Failure, PageModel<SupplierProductModel>>> getProducts({
    int page = 1,
    required int supplierId,
    int categoryId = -1,
  }) async {
    try {
      final response = await apiService.get<List<SupplierProductModel>>(
        url: ConstantsApi.getSupplierProducts(supplierId),
        params: {
          'page': page,
          'category_id': categoryId == -1 ? null : categoryId,
        },
        fromJsonListT: SupplierProductModel.fromJsonList,
      );
      return Right(
        PageModel<SupplierProductModel>(
          data: response.data ?? [],
          hasMore: response.hasMore,
        ),
      );
    } catch (error) {
      return Left(ErrorHandler.handle(error).failure);
    }
  }
}
