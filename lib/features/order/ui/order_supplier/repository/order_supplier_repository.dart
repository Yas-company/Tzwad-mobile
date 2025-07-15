import 'package:tzwad_mobile/core/network/api_service.dart';
import 'package:tzwad_mobile/core/network/constants_api.dart';
import 'package:tzwad_mobile/core/network/error_handler.dart';
import 'package:tzwad_mobile/core/network/failure.dart';
import 'package:tzwad_mobile/core/util/data_models/page_model.dart';
import 'package:tzwad_mobile/core/util/state_render/result.dart';
import 'package:tzwad_mobile/features/product/models/supplier_categories_response_model.dart';

class OrderSupplierRepository {
  final ApiService apiService;

  OrderSupplierRepository({
    required this.apiService,
  });

  Future<Result<Failure, PageModel<SupplierCategories>>> getSupplierOrders({
    int page = 1,}) async {
    try {
      final response = await apiService.get<List<SupplierCategories>>(
        url: ConstantsApi.getSupplierOrders,
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
}
