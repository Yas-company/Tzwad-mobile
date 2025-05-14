import 'package:tzwad_mobile/core/network/failure.dart';
import 'package:tzwad_mobile/core/util/data_state.dart';

class RegisterState {
  final DataState submitRegisterDataState;
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

  RegisterState({
    this.submitRegisterDataState = DataState.initial,
    this.name = '',
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

  RegisterState copyWith({
    DataState? submitRegisterDataState,
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
    return RegisterState(
      submitRegisterDataState: submitRegisterDataState ?? this.submitRegisterDataState,
      name: name ?? this.name,
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
