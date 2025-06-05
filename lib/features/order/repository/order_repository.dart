import 'package:tzwad_mobile/core/network/api_service.dart';
import 'package:tzwad_mobile/core/network/constants_api.dart';
import 'package:tzwad_mobile/core/network/error_handler.dart';
import 'package:tzwad_mobile/core/network/failure.dart';
import 'package:tzwad_mobile/core/util/data_models/page_model.dart';
import 'package:tzwad_mobile/core/util/state_render/result.dart';
import 'package:tzwad_mobile/core/util/unit.dart';
import 'package:tzwad_mobile/features/order/models/order_model.dart';
import 'package:tzwad_mobile/features/order/models/order_type_enum.dart';

class OrderRepository {
  final ApiService apiService;

  OrderRepository({
    required this.apiService,
  });

  Future<Result<Failure, Unit>> checkout({
    required int supplierId,
    required String notes,
    String paymentMethod = 'cash', // visa
  }) async {
    try {
      await apiService.post<Unit>(
        url: ConstantsApi.checkoutUrl,
        params: {
          'supplier_id': supplierId,
          'notes': notes,
          'payment_method': paymentMethod,
        },
      );
      return const Right(unit);
    } catch (error) {
      return Left(ErrorHandler.handle(error).failure);
    }
  }

  Future<Result<Failure, PageModel<OrderModel>>> getOrders({
    int page = 1,
    OrderTypeEnum orderType = OrderTypeEnum.all,
  }) async {
    try {
      final response = await apiService.get<List<OrderModel>>(
        url: ConstantsApi.getOrdersUrl,
        params: {
          'page': page,
          'status': orderType.value,
        },
        fromJsonListT: OrderModel.fromJsonList,
      );
      return Right(
        PageModel<OrderModel>(
          data: response.data ?? [],
          hasMore: response.hasMore,
        ),
      );
    } catch (error) {
      return Left(ErrorHandler.handle(error).failure);
    }
  }

  Future<Result<Failure, OrderModel>> getOrder({required int id}) async {
    try {
      final response = await apiService.get<OrderModel>(
        url: ConstantsApi.getOrderDetailsUrl(id),
        fromJsonT: OrderModel.fromJson,
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
}
