import '../../../core/models/model_serialization_helper.dart';
import '../../common/base_item_model.dart';
import '../../manga/tag_model.dart';
import '../common/data_response.dart';

class TagListResponse {
  List<DataResponse<BaseItemModel<TagModel>>> tags;

  TagListResponse({required this.tags});

  factory TagListResponse.fromJson(List<dynamic> json) {
    final List<DataResponse<BaseItemModel<TagModel>>> tagList =
        ModelHelper.fromJsonBaseDataWithBaseItemWithTags(json);

    return TagListResponse(tags: tagList);
  }
}
