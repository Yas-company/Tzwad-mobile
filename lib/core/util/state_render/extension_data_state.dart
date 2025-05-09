import 'package:tzwad_mobile/core/network/failure.dart';

import 'data_state.dart';

extension DataStateExtensions<T> on DataState<T> {
  /// Handles each state explicitly.
  R when<R>({
    required R Function() init,
    required R Function() loading,
    required R Function(T data) success,
    required R Function(Failure failure) failure,
  }) {
    if (this is InitState<T>) {
      return init();
    } else if (this is LoadingState<T>) {
      return loading();
    } else if (this is SuccessState<T>) {
      return success((this as SuccessState<T>).data as T);
    } else if (this is FailureState<T>) {
      return failure((this as FailureState<T>).failure!);
    } else {
      throw StateError("Unhandled state: $this");
    }
  }

  /// Handles success and failure, with optional loading and init.
  R whenElse<R>({
    R Function()? init,
    R Function()? loading,
    required R Function(T data) success,
    required R Function(Failure failure) failure,
  }) {
    if (this is InitState<T>) {
      return init != null ? init() : throw StateError("Unhandled InitState");
    } else if (this is LoadingState<T>) {
      return loading != null ? loading() : throw StateError("Unhandled LoadingState");
    } else if (this is SuccessState<T>) {
      return success((this as SuccessState<T>).data as T);
    } else if (this is FailureState<T>) {
      return failure((this as FailureState<T>).failure!);
    } else {
      throw StateError("Unhandled state: $this");
    }
  }

  /// Executes a fallback for unhandled states.
  R whenOrElse<R>({
    required R Function() orElse,
    R Function()? init,
    R Function()? loading,
    R Function(T data)? success,
    R Function()? empty,
    R Function(Failure failure)? failure,
  }) {
    if (this is InitState<T> && init != null) {
      return init();
    } else if (this is LoadingState<T> && loading != null) {
      return loading();
    } else if (this is SuccessState<T> && success != null) {
      return success((this as SuccessState<T>).data as T);
    } else if (this is EmptyState<T> && empty != null) {
      return empty();
    } else if (this is FailureState<T> && failure != null) {
      return failure((this as FailureState<T>).failure!);
    } else {
      return orElse();
    }
  }

  /// Executes specific actions without returning values.
  void whenVoid({
    void Function()? init,
    void Function()? loading,
    void Function(T data)? success,
    void Function(Failure failure)? failure,
  }) {
    if (this is InitState<T> && init != null) {
      init();
    } else if (this is LoadingState<T> && loading != null) {
      loading();
    } else if (this is SuccessState<T> && success != null) {
      success((this as SuccessState<T>).data as T);
    } else if (this is FailureState<T> && failure != null) {
      failure((this as FailureState<T>).failure!);
    }
  }
}

/*  when
final state = DataState.success(data: "Hello, World!");

final message = state.when(
  init: () => "Initializing...",
  loading: () => "Loading...",
  success: (data) => "Success with data: $data",
  failure: (error) => "Failed with error: ${error.message}",
);
*/

/* whenElse
final state = DataState.failure(failure: Failure("Something went wrong"));

final message = state.whenElse(
  success: (data) => "Success with data: $data",
  failure: (error) => "Failed with error: ${error.message}",
  loading: () => "Still loading...",
);
*/

/* whenOrElse
final state = DataState.init();

final message = state.whenOrElse(
  success: (data) => "Success with data: $data",
  orElse: () => "Unknown state or fallback",
);
 */

/* whenVoid
final state = DataState.loading();

final message = state.whenVoid(
  loading: () => print("Loading..."),
  success: (data) => print("Success: $data"),
  failure: (error) => print("Error: ${error.message}"),
);
 */
