import 'package:tzwad_mobile/core/network/api_service.dart';
import 'package:tzwad_mobile/core/network/constants_api.dart';
import 'package:tzwad_mobile/core/network/error_handler.dart';
import 'package:tzwad_mobile/core/network/failure.dart';
import 'package:tzwad_mobile/core/util/state_render/result.dart';
import 'package:tzwad_mobile/features/ads/models/ads_model.dart';
import 'package:tzwad_mobile/features/generic/local_data/setting_local_data.dart';

class AdsRepository {
  final ApiService apiService;
  final SettingLocalData settingLocalData;

  AdsRepository({
    required this.apiService,
    required this.settingLocalData,
  });

  Future<Result<Failure, List<AdsModel>>> getAds() async {
    try {
      final response = await apiService.get<List<AdsModel>>(
        url: ConstantsApi.getAdsUrl,
        fromJsonListT: AdsModel.fromJsonList,
      );
      return Right(response.data ?? []);
    } catch (error) {
      return Left(ErrorHandler.handle(error).failure);
    }
  }
}
