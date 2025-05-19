class PageModel<T> {
  List<T> data;
  bool hasMore;

  PageModel({
    required this.data,
    required this.hasMore,
  });
}
