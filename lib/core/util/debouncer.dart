import 'dart:async';
import 'dart:ui';

class Debouncer {
  // VoidCallback? action;
  Timer? _timer;

  run(VoidCallback action) {
    if (_timer != null) {
      _timer!.cancel();
    }
    _timer = Timer(const Duration(milliseconds: 500), action);
  }
}
