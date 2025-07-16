import 'package:tzwad_mobile/core/network/api_service.dart';
import 'package:tzwad_mobile/core/network/constants_api.dart';
import 'package:tzwad_mobile/core/network/error_handler.dart';
import 'package:tzwad_mobile/core/network/failure.dart';
import 'package:tzwad_mobile/core/util/data_models/page_model.dart';
import 'package:tzwad_mobile/core/util/state_render/result.dart';
import 'package:tzwad_mobile/features/order/models/supplier_order_details_response_model.dart';
import 'package:tzwad_mobile/features/order/models/supplier_orders_response_model.dart';
import 'package:tzwad_mobile/features/product/models/supplier_categories_response_model.dart';

class OrderSupplierRepository {
  final ApiService apiService;

  OrderSupplierRepository({
    required this.apiService,
  });

  Future<Result<Failure, PageModel<SupplierOrdersData>>> getSupplierOrders({
    int page = 1,}) async {
    try {
      final response = await apiService.get<List<SupplierOrdersData>>(
        url: ConstantsApi.getSupplierOrders,
        params: {'page': page,},
        fromJsonListT: SupplierOrdersData.fromJsonList,
      );
      return Right(
        PageModel<SupplierOrdersData>(
          data: response.data ?? [],
          hasMore: response.hasMore,
        ),
      );
    } catch (error) {
      return Left(ErrorHandler.handle(error).failure);
    }
  }

  Future<Result<Failure, SupplierOrderDetailsData?>> showSupplierOrder(int id) async {
    try {
      final response = await apiService.get<SupplierOrderDetailsData>(
        url: ConstantsApi.showSupplierOrder(id),
        fromJsonT: SupplierOrderDetailsData.fromJson,
      );
      if (response.data != null) {
        print('dtatata>>'+response.data!.toString());
        print('dtatata>>'+Right(response.data!).value.toJson().toString());
        return Right(response.data!);
      } else {
        return Left(
          Failure(
            code: 0,
            message: 'Order not found',
          ),
        );
      }
    } catch (error) {
      return Left(ErrorHandler.handle(error).failure);
    }
  }
}
