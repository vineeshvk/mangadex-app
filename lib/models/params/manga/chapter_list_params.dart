import 'package:json_annotation/json_annotation.dart';

import '../../../core/constants/manga_constants.dart';
import '../../responses/common/pagination_handler.dart';

part 'chapter_list_params.g.dart';

@JsonSerializable(
  createFactory: false,
  explicitToJson: true,
  includeIfNull: false,
)
class ChapterListParams {
  String mangaId;

  @JsonKey(ignore: true)
  PaginationHandler? pagination;

  /// limit for querying default value is `[500]`
  int get limit => pagination?.limit ?? 500;

  /// query from offset; offset > 0
  int? get offset => pagination?.nextPage();

  List<String> translatedLanguage = ["en"];

  ChapterOrder order = ChapterOrder();

  ChapterListParams({required this.mangaId, this.pagination});

  Map<String, dynamic> toJson() => _$ChapterListParamsToJson(this);
}

@JsonSerializable(createFactory: false, includeIfNull: false)
class ChapterOrder {
  OrderBy? volume;
  OrderBy? chapter;

  ChapterOrder({
    this.volume,
    this.chapter,
  });

  Map<String, dynamic> toJson() => _$ChapterOrderToJson(this);
}
