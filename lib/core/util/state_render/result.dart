abstract class Result<L, R> {
  const Result();

  T fold<T>(T Function(L l) leftFn, T Function(R r) rightFn);
}

class Left<L, R> extends Result<L, R> {
  final L value;

  const Left(this.value);

  @override
  T fold<T>(T Function(L l) leftFn, T Function(R r) rightFn) => leftFn(value);
}

class Right<L, R> extends Result<L, R> {
  final R value;

  const Right(this.value);

  @override
  T fold<T>(T Function(L l) leftFn, T Function(R r) rightFn) => rightFn(value);
}
