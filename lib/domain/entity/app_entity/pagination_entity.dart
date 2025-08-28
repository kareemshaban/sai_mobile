class PaginationEntity {
  int currentPage;
  String prevPageUrl;
  String nextPageUrl;
  int lastPage;
  int perPage;
  int total;
  String path;

  PaginationEntity({
    required this.path,
    required this.total,
    required this.currentPage,
    required this.lastPage,
    required this.nextPageUrl,
    required this.perPage,
    required this.prevPageUrl,
  });
}
