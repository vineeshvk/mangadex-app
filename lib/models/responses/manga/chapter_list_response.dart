import 'package:json_annotation/json_annotation.dart';

import '../../../core/models/model_serialization_helper.dart';
import '../../common/base_item_model.dart';
import '../../manga/chapter_item_model.dart';
import '../common/data_response.dart';
import '../common/pagination_handler.dart';

part 'chapter_list_response.g.dart';

@JsonSerializable(createToJson: false)
class ChapterListResponse with PaginationHandler {
  @JsonKey(fromJson: ModelHelper.fromJsonDataWithBaseItemWithChapter)
  final List<DataResponse<BaseItemModel<ChapterItemModel>>> results;

  ChapterListResponse({
    required this.results,
  });

  factory ChapterListResponse.fromJson(Map<String, dynamic> json) =>
      _$ChapterListResponseFromJson(json);

  @override
  String toString() => 'ChapterListResponse(result: $results)';
}
