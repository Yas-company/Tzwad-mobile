import 'package:tzwad_mobile/core/network/api_service.dart';
import 'package:tzwad_mobile/core/network/constants_api.dart';
import 'package:tzwad_mobile/core/network/error_handler.dart';
import 'package:tzwad_mobile/core/network/failure.dart';
import 'package:tzwad_mobile/core/util/state_render/result.dart';
import 'package:tzwad_mobile/core/util/unit.dart';
import 'package:tzwad_mobile/features/buyer/address/models/address_model.dart';
import 'package:tzwad_mobile/features/generic/local_data/setting_local_data.dart';

class AddressRepository {
  final ApiService apiService;
  final SettingLocalData settingLocalData;

  AddressRepository({
    required this.apiService,
    required this.settingLocalData,
  });

  Future<Result<Failure, List<AddressModel>>> getAddresses() async {
    try {
      final response = await apiService.get<List<AddressModel>>(
        url: ConstantsApi.getAddressesUrl,
        fromJsonListT: AddressModel.fromJsonList,
      );
      return Right(response.data ?? []);
    } catch (error) {
      return Left(ErrorHandler.handle(error).failure);
    }
  }

  Future<Result<Failure, Unit>> addAddress() async {
    try {
      await apiService.post<Unit>(
        url: ConstantsApi.addAddressUrl,
      );
      return const Right(unit);
    } catch (error) {
      return Left(ErrorHandler.handle(error).failure);
    }
  }

  Future<Result<Failure, Unit>> updateAddress(int id) async {
    try {
      await apiService.put<Unit>(
        url: ConstantsApi.updateAddressUrl(id),
      );
      return const Right(unit);
    } catch (error) {
      return Left(ErrorHandler.handle(error).failure);
    }
  }

  Future<Result<Failure, Unit>> deleteAddress(int id) async {
    try {
      await apiService.delete<Unit>(
        url: ConstantsApi.deleteAddressUrl(id),
      );
      return const Right(unit);
    } catch (error) {
      return Left(ErrorHandler.handle(error).failure);
    }
  }
}
