import '../../http/responses/common/base_data_response.dart';
import '../../models/common/base_item_model.dart';
import '../../models/manga/manga_model.dart';
import '../../models/manga/tag_model.dart';

class ModelHelper {
  ModelHelper._();

  static List<BaseDataResponse<BaseItemModel<MangaModel>>>
      fromJsonBaseDataWithBaseItemWithManga(List<dynamic> json) {
    return json
        .map(
          (json1) => BaseDataResponse.fromJson(
            json1 as Map<String, dynamic>,
            (json2) => BaseItemModel.fromJson(
              json2,
              (json3) => MangaModel.fromJson(json3),
            ),
          ),
        )
        .toList();
  }

  static List<BaseItemModel<TagModel>> fromJsonBaseItemWithTag(
    List<dynamic> list,
  ) {
    return list
        .map((json) => BaseItemModel.fromJson(
              json as Map<String, dynamic>,
              (js) => TagModel.fromJson(js),
            ))
        .toList();
  }
}
