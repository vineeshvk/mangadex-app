import '../../models/common/base_item_model.dart';
import '../../models/manga/cover_model.dart';
import '../../models/manga/manga_item_model.dart';
import '../../models/manga/tag_model.dart';
import '../../models/responses/common/data_response.dart';

abstract class ModelHelper {
  static List<DataResponse<BaseItemModel<MangaItemModel>>>
      fromJsonBaseDataWithBaseItemWithManga(List<dynamic> json) {
    return json
        .map(
          (json1) => DataResponse.fromJson(
            json1 as Map<String, dynamic>,
            (json2) => BaseItemModel.fromJson(
              json2 ?? {},
              (json3, id) => MangaItemModel.fromJson(json3)..id = id,
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
              (js, id) => TagModel.fromJson(js),
            ))
        .toList();
  }

  static List<DataResponse<BaseItemModel<TagModel>>>
      fromJsonBaseDataWithBaseItemWithTags(List<dynamic> json) {
    return json
        .map(
          (json1) => DataResponse.fromJson(
            json1 as Map<String, dynamic>,
            (json2) => BaseItemModel.fromJson(
              json2 ?? {},
              (json3, id) => TagModel.fromJson(json3),
            ),
          ),
        )
        .toList();
  }

  static DataResponse<BaseItemModel<CoverModel>>
      fromJsonBaseDataWithBaseItemWithCover(Map<String, dynamic> json) {
    return DataResponse.fromJson(json, (json1) {
      return BaseItemModel.fromJson(json1 ?? {}, (json2, id) {
        return CoverModel.fromJson(json2);
      });
    });
  }
}
