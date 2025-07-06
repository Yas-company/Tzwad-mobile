import 'package:tzwad_mobile/core/network/failure.dart';
import 'package:tzwad_mobile/core/util/data_state.dart';

class RegisterBuyerState {
  final DataState getLocationDataState;
  final DataState submitRegisterDataState;
  final double latitude;
  final double longitude;
  final String name;
  final String nameValidationMessage;
  final String businessName;
  final String businessNameValidationMessage;
  final String phoneNumber;
  final String phoneNumberValidationMessage;
  final String address;
  final String addressValidationMessage;
  final String password;
  final String passwordValidationMessage;
  final bool obscureText;
  final bool isAcceptTerms;
  final Failure? failure;

  RegisterBuyerState({
    this.getLocationDataState = DataState.initial,
    this.submitRegisterDataState = DataState.initial,
    this.name = '',
    this.latitude = 30.09066,
    this.longitude = 31.09066,
    this.nameValidationMessage = '',
    this.businessName = '',
    this.businessNameValidationMessage = '',
    this.phoneNumber = '',
    this.phoneNumberValidationMessage = '',
    this.address = '',
    this.addressValidationMessage = '',
    this.password = '',
    this.passwordValidationMessage = '',
    this.obscureText = true,
    this.isAcceptTerms = false,
    this.failure,
  });

  RegisterBuyerState copyWith({
    DataState? getLocationDataState,
    DataState? submitRegisterDataState,
    double? latitude,
    double? longitude,
    String? name,
    String? nameValidationMessage,
    String? businessName,
    String? businessNameValidationMessage,
    String? phoneNumber,
    String? phoneNumberValidationMessage,
    String? address,
    String? addressValidationMessage,
    String? password,
    String? passwordValidationMessage,
    bool? obscureText,
    bool? isAcceptTerms,
    Failure? failure,
  }) {
    return RegisterBuyerState(
      getLocationDataState: getLocationDataState ?? this.getLocationDataState,
      submitRegisterDataState: submitRegisterDataState ?? this.submitRegisterDataState,
      name: name ?? this.name,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      nameValidationMessage: nameValidationMessage ?? this.nameValidationMessage,
      businessName: businessName ?? this.businessName,
      businessNameValidationMessage: businessNameValidationMessage ?? this.businessNameValidationMessage,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      phoneNumberValidationMessage: phoneNumberValidationMessage ?? this.phoneNumberValidationMessage,
      address: address ?? this.address,
      addressValidationMessage: addressValidationMessage ?? this.addressValidationMessage,
      password: password ?? this.password,
      passwordValidationMessage: passwordValidationMessage ?? this.passwordValidationMessage,
      obscureText: obscureText ?? this.obscureText,
      isAcceptTerms: isAcceptTerms ?? this.isAcceptTerms,
      failure: failure ?? this.failure,
    );
  }
}
