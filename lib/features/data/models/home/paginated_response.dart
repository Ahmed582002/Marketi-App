class PaginatedResponse<T> {
  List<T>? list;
  int? total;
  int? skip;
  int? limit;

  PaginatedResponse({this.list, this.total, this.skip, this.limit});
}
