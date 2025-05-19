class DataModel<T> {
  final T? data;
  final bool hasMore;

  DataModel({
    this.data,
    this.hasMore = false,
  });
}
