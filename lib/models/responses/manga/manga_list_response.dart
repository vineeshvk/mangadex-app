import 'package:json_annotation/json_annotation.dart';

import '../../../core/models/model_serialization_helper.dart';
import '../../../models/common/base_item_model.dart';
import '../../manga/manga_item_model.dart';
import '../common/base_pagination_response.dart';
import '../common/data_response.dart';

part 'manga_list_response.g.dart';

@JsonSerializable(createToJson: false)
class MangaListResponse with BasePaginationResponse {
  @JsonKey(fromJson: ModelHelper.fromJsonBaseDataWithBaseItemWithManga)
  final List<DataResponse<BaseItemModel<MangaItemModel>>> results;

  MangaListResponse({
    required this.results,
  });

  factory MangaListResponse.fromJson(Map<String, dynamic> json) =>
      _$MangaListResponseFromJson(json);

  @override
  String toString() => 'MangaListResponse(result: $results)';
}
