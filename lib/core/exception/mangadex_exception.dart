class MangaDexException<T> implements Exception {
  T? error;
  MangaDexException({this.error});
}
