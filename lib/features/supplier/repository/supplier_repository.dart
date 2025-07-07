import 'package:tzwad_mobile/core/network/api_service.dart';
import 'package:tzwad_mobile/core/network/constants_api.dart';
import 'package:tzwad_mobile/core/network/error_handler.dart';
import 'package:tzwad_mobile/core/network/failure.dart';
import 'package:tzwad_mobile/core/util/data_models/page_model.dart';
import 'package:tzwad_mobile/core/util/state_render/result.dart';
import 'package:tzwad_mobile/features/generic/local_data/setting_local_data.dart';
import 'package:tzwad_mobile/features/supplier/models/supplier_model.dart';

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
        url: ConstantsApi.getAdsUrl,
        data: {
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
}
