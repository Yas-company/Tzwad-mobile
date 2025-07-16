import 'package:dio/dio.dart';
import 'package:tzwad_mobile/core/network/api_service.dart';
import 'package:tzwad_mobile/core/network/constants_api.dart';
import 'package:tzwad_mobile/core/network/error_handler.dart';
import 'package:tzwad_mobile/core/network/failure.dart';
import 'package:tzwad_mobile/core/util/data_models/page_model.dart';
import 'package:tzwad_mobile/core/util/state_render/result.dart';
import 'package:tzwad_mobile/features/product/models/add_supplier_product_request_model.dart';
import 'package:tzwad_mobile/features/product/models/supplier_categories_response_model.dart';
import 'package:tzwad_mobile/features/product/models/supplier_fields_response_model.dart';

class CategorySupplierRepository {
  final ApiService apiService;

  CategorySupplierRepository({
    required this.apiService,
  });

  // Future<Result<Failure, List<SupplierCategories>>> getSupplierCategories() async {
  //   try {
  //     final response = await apiService.get<List<SupplierCategories>>(
  //       url: ConstantsApi.getCategoriesUrl,
  //       fromJsonListT: (jsonList) =>
  //           jsonList.map((e) => SupplierCategories.fromJson(e)).toList(),
  //     );
  //
  //     if (response.data != null) {
  //       return Right(response.data!);
  //     } else {
  //       return Left(Failure(code: 0, message: 'No categories found'));
  //     }
  //   } catch (error) {
  //     return Left(ErrorHandler.handle(error).failure);
  //   }
  // }

  Future<Result<Failure, PageModel<SupplierCategories>>> getSupplierCategories({
    int page = 1,}) async {
    try {
      final response = await apiService.get<List<SupplierCategories>>(
        url: ConstantsApi.getCategoriesUrl,
        params: {'page': page,},
        fromJsonListT: SupplierCategories.fromJsonList,
      );
      return Right(
        PageModel<SupplierCategories>(
          data: response.data ?? [],
          hasMore: response.hasMore,
        ),
      );
    } catch (error) {
      return Left(ErrorHandler.handle(error).failure);
    }
  }

  Future<Result<Failure, bool>> createCategory(AddSupplierCategoryRequestModel request) async {
    try {
      final formData = FormData.fromMap({
        'name[en]': request.nameEn,
        'name[ar]': request.nameAr,
        'field_id': request.fieldId,
        'image':await MultipartFile.fromFile(request.image?.path??'',
            filename: request.image?.path.split('/').last),
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

  Future<Result<Failure, bool>> updateSupplierCategory(int id,AddSupplierCategoryRequestModel request) async {
    try {
      final formData = FormData.fromMap({
        'name[en]': request.nameEn,
        'name[ar]': request.nameAr,
        'field_id': request.fieldId,
        'image':await MultipartFile.fromFile(request.image?.path??'',
            filename: request.image?.path.split('/').last),
      });

      final response = await apiService.postFormData(
        url: '${ConstantsApi.getCategoriesUrl}/$id',
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

  Future<Result<Failure, Response>>deleteSupplierCategory(int id) async {
    try {
      final response = await apiService.delete<Response>(
        url: '${ConstantsApi.getCategoriesUrl}/$id',
      );
      if (response.data != null) {
        return Right(response.data!);
      } else {
        return Left(Failure(code: 0, message: ''));
      }
    } catch (error) {
      return Left(ErrorHandler.handle(error).failure);
    }
  }

  Future<Result<Failure, List<SupplierFieldsData>>> getSupplierFields() async {
    try {
      final response = await apiService.get<List<SupplierFieldsData>>(
        url: ConstantsApi.getSupplierFields,
        fromJsonListT: (jsonList) =>
            jsonList.map((e) => SupplierFieldsData.fromJson(e)).toList(),
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

}
