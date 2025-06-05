import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tzwad_mobile/core/extension/string_extension.dart';
import 'package:tzwad_mobile/core/extension/validation_extension.dart';
import 'package:tzwad_mobile/core/services/location_service.dart';
import 'package:tzwad_mobile/core/util/data_state.dart';
import 'package:tzwad_mobile/features/auth/providers/auth_repository_provider.dart';
import 'register_state.dart';

class RegisterController extends AutoDisposeNotifier<RegisterState> {
  @override
  RegisterState build() {
    state = _onInit();
    getLocation();
    return state;
  }

  RegisterState _onInit() => RegisterState();

  void getLocation() async {
    final locationService = ref.read(locationServiceProvider);
    state = state.copyWith(
      getLocationDataState: DataState.loading,
    );
    final hasPermission = await locationService.checkAndRequestLocationService();
    final currentLocation = await locationService.getCurrentLocation();
    'Mohammad register hasPermission $hasPermission'.log();
    'Mohammad register ${currentLocation?.latitude}'.log();
    'Mohammad register ${currentLocation?.longitude}'.log();
    if (!hasPermission) {
      state = state.copyWith(
        getLocationDataState: DataState.failure,
      );
    } else {
      state = state.copyWith(
        getLocationDataState: DataState.success,
        latitude: currentLocation?.latitude ?? 0.0,
        longitude: currentLocation?.longitude ?? 0.0,
      );
    }
  }

  void changeName(String name) {
    state = state.copyWith(
      name: name,
      nameValidationMessage: name.validateName,
    );
  }

  void changeBusinessName(String businessName) {
    state = state.copyWith(
      businessName: businessName,
      businessNameValidationMessage: businessName.validateBusinessName,
    );
  }

  void changePhoneNumber(String phoneNumber) {
    state = state.copyWith(
      phoneNumber: phoneNumber,
      phoneNumberValidationMessage: phoneNumber.validatePhoneNumber,
    );
  }

  void changeAddress(String address) {
    state = state.copyWith(
      address: address,
      addressValidationMessage: address.validateAddress,
    );
  }

  void changePassword(String password) {
    state = state.copyWith(
      password: password,
      passwordValidationMessage: password.validatePassword,
    );
  }

  void changeVisibilityPassword() {
    state = state.copyWith(
      obscureText: !state.obscureText,
    );
  }

  void changeAcceptTerms() {
    state = state.copyWith(
      isAcceptTerms: !state.isAcceptTerms,
    );
  }

  void register() async {
    final repository = ref.read(authRepositoryProvider);
    // final appPrefs = ref.read(appPreferencesProvider);
    final nameValidationMessage = state.name.validateName;
    final businessNameValidationMessage = state.businessName.validateBusinessName;
    final phoneNumberValidationMessage = state.phoneNumber.validatePhoneNumber;
    final addressValidationMessage = state.address.validateAddress;
    final passwordValidationMessage = state.password.validatePassword;
    if (nameValidationMessage.isNotEmpty ||
        businessNameValidationMessage.isNotEmpty ||
        phoneNumberValidationMessage.isNotEmpty ||
        addressValidationMessage.isNotEmpty ||
        passwordValidationMessage.isNotEmpty) {
      state = state.copyWith(
        nameValidationMessage: nameValidationMessage,
        businessNameValidationMessage: businessNameValidationMessage,
        phoneNumberValidationMessage: phoneNumberValidationMessage,
        addressValidationMessage: addressValidationMessage,
        passwordValidationMessage: passwordValidationMessage,
      );
      return;
    }
    state = state.copyWith(
      submitRegisterDataState: DataState.loading,
    );
    final result = await repository.register(
      name: state.name,
      phoneNumber: state.phoneNumber,
      businessName: state.businessName,
      address: state.address,
      password: state.password,
      latitude: state.latitude,
      longitude: state.longitude,
    );
    result.fold(
      (l) => state = state.copyWith(
        submitRegisterDataState: DataState.failure,
        failure: l,
      ),
      (r) => state = state.copyWith(
        submitRegisterDataState: DataState.success,
      ),
    );
  }
}
