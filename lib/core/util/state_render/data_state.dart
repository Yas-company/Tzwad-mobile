import 'package:tzwad_mobile/core/network/failure.dart';

abstract class DataState<T> {
  final T? data;
  final Failure? failure;

  const DataState._({
    this.data,
    this.failure,
  });

  factory DataState.init() = InitState<T>;

  factory DataState.loading() = LoadingState<T>;

  factory DataState.success({required T data}) = SuccessState<T>;

  factory DataState.empty() = EmptyState<T>;

  factory DataState.failure({required Failure failure}) = FailureState<T>;
}

class InitState<T> extends DataState<T> {
  const InitState() : super._();
}

class LoadingState<T> extends DataState<T> {
  const LoadingState() : super._();
}

class SuccessState<T> extends DataState<T> {
  const SuccessState({
    required super.data,
  }) : super._();
}

class EmptyState<T> extends DataState<T> {
  const EmptyState() : super._();
}

class FailureState<T> extends DataState<T> {
  const FailureState({
    required super.failure,
  }) : super._();
}
