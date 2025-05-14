import 'package:go_router/go_router.dart';
import 'package:tzwad_mobile/core/util/app_context.dart';

Map<String, dynamic> _arguments = {};

dynamic get appArgs {
  return _arguments[_location];
}

String get _location {
  final context = AppContext.context;
  final location = GoRouter.of(context).state.matchedLocation;
  return location;
}

void setArgs(String key, dynamic value) => _arguments[key] = value;

class AppArgsKeys {
  static const String phoneNumber = 'phoneNumber';
  static const String otpFlowType = 'otpFlowType';
}
