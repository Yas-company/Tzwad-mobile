import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tzwad_mobile/core/extension/validation_extension.dart';
import 'package:tzwad_mobile/core/services/location_service.dart';
import 'package:tzwad_mobile/core/util/data_state.dart';
import 'package:tzwad_mobile/features/auth/models/role_enum.dart';
import 'package:tzwad_mobile/features/auth/providers/auth_repository_provider.dart';
import 'register_buyer_state.dart';

class RegisterBuyerController extends AutoDisposeNotifier<RegisterBuyerState> {
  @override
  RegisterBuyerState build() {
    state = _onInit();
    getLocation();
    return state;
  }

  RegisterBuyerState _onInit() => RegisterBuyerState();

  void getLocation() async {
    final locationService = ref.read(locationServiceProvider);
    state = state.copyWith(
      getLocationDataState: DataState.loading,
    );
    final hasPermission = await locationService.checkAndRequestLocationService();
    final currentLocation = await locationService.getCurrentLocation();
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

  void changeCity(String city) {
    state = state.copyWith(
      city: city,
      cityValidationMessage: city.validateRequiredField,
    );
  }

  void changeStreet(String street) {
    state = state.copyWith(
      street: street,
      streetValidationMessage: street.validateRequiredField,
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
    final cityValidationMessage = state.city.validateAddress;
    final streetValidationMessage = state.street.validateAddress;
    final passwordValidationMessage = state.password.validatePassword;
    if (nameValidationMessage.isNotEmpty ||
        businessNameValidationMessage.isNotEmpty ||
        phoneNumberValidationMessage.isNotEmpty ||
        cityValidationMessage.isNotEmpty ||
        streetValidationMessage.isNotEmpty ||
        addressValidationMessage.isNotEmpty ||
        passwordValidationMessage.isNotEmpty) {
      state = state.copyWith(
        nameValidationMessage: nameValidationMessage,
        businessNameValidationMessage: businessNameValidationMessage,
        phoneNumberValidationMessage: phoneNumberValidationMessage,
        addressValidationMessage: addressValidationMessage,
        streetValidationMessage: streetValidationMessage,
        cityValidationMessage: cityValidationMessage,
        passwordValidationMessage: passwordValidationMessage,
      );
      return;
    }
    state = state.copyWith(
      submitRegisterDataState: DataState.loading,
    );
    final result = await repository.registerBuyer(
      name: state.name,
      phoneNumber: state.phoneNumber,
      businessName: state.businessName,
      password: state.password,
      role: RoleEnum.buyer,
      nameAddress: state.address,
      street: state.street,
      city: state.city,
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
