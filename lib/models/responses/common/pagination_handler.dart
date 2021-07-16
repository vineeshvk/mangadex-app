import 'package:json_annotation/json_annotation.dart';

mixin PaginationHandler {
  @JsonKey(defaultValue: 0)
  int limit = 0;

  @JsonKey(defaultValue: 0)
  int offset = 0;

  @JsonKey(defaultValue: 0)
  int total = 0;

  bool get isLastPage => total - (offset + limit) <= 0;

  int nextPage() {
    return offset + limit;
  }
}
