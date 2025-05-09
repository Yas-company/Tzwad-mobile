import 'package:flutter/material.dart';
import 'package:tzwad_mobile/core/network/failure.dart';

class AppFailureWidget extends StatelessWidget {
  const AppFailureWidget({
    super.key,
    required this.failure,
  });

  final Failure? failure;

  @override
  Widget build(BuildContext context) {
    return const SizedBox();
  }
}
