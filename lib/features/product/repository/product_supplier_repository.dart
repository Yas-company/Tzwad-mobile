import 'package:dio/dio.dart';
import 'package:tzwad_mobile/core/network/api_service.dart';
import 'package:tzwad_mobile/core/network/constants_api.dart';
import 'package:tzwad_mobile/core/network/error_handler.dart';
import 'package:tzwad_mobile/core/network/failure.dart';
import 'package:tzwad_mobile/core/util/state_render/result.dart';
import 'package:tzwad_mobile/features/product/models/add_supplier_product_request_model.dart';
import 'package:tzwad_mobile/features/product/models/supplier_categories_response_model.dart';

class ProductSupplierRepository {
  final ApiService apiService;

  ProductSupplierRepository({
    required this.apiService,
  });
  Future<Result<Failure, List<SupplierCategories>>> getSupplierCategories() async {
    try {
      final response = await apiService.get<List<SupplierCategories>>(
        url: ConstantsApi.getCategoriesUrl,
        fromJsonListT: (jsonList) =>
            jsonList.map((e) => SupplierCategories.fromJson(e)).toList(),
      );

      if (response.data != null) {
        return Right(response.data!);
      } else {
        return Left(Failure(code: 0, message: 'No categories found'));
      }
    } catch (error) {
      return Left(ErrorHandler.handle(error).failure);
    }
  }

  Future<Result<Failure, bool>> createCategory(AddSupplierProductRequestModel request) async {
    try {
      final formData = FormData.fromMap({
        'name[en]': request.nameEn,
        'name[ar]': request.nameAr,
        'field_id': request.fieldId,
        'image':await MultipartFile.fromFile(request.images.path, filename: request.images.path.split('/').last),
      });

      final response = await apiService.postFormData(
        url: ConstantsApi.getCategoriesUrl,
        formData: formData,
      );

      // Optionally check response.success, or parse model
      if (response.statusCode == 200 || response.statusCode == 201) {
        return const Right(true); // or parse response if needed
      } else {
        return Left(Failure(
          code: response.statusCode ?? 0,
          message: response.statusMessage ?? 'Unknown error',
        ));
      }
    } catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }
  }
}
