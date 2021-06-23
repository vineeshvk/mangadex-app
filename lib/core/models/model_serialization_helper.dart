import 'package:mangadex/models/manga/cover_model.dart';

import '../../models/common/base_item_model.dart';
import '../../models/manga/manga_model.dart';
import '../../models/manga/tag_model.dart';
import '../../models/responses/common/base_data_response.dart';

abstract class ModelHelper {
  static List<BaseDataResponse<BaseItemModel<MangaItemModel>>>
      fromJsonBaseDataWithBaseItemWithManga(List<dynamic> json) {
    return json
        .map(
          (json1) => BaseDataResponse.fromJson(
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

  static List<BaseDataResponse<BaseItemModel<TagModel>>>
      fromJsonBaseDataWithBaseItemWithTags(List<dynamic> json) {
    return json
        .map(
          (json1) => BaseDataResponse.fromJson(
            json1 as Map<String, dynamic>,
            (json2) => BaseItemModel.fromJson(
              json2 ?? {},
              (json3, id) => TagModel.fromJson(json3),
            ),
          ),
        )
        .toList();
  }

  static BaseDataResponse<BaseItemModel<CoverModel>>
      fromJsonBaseDataWithBaseItemWithCover(Map<String, dynamic> json) {
    return BaseDataResponse.fromJson(json, (json1) {
      return BaseItemModel.fromJson(json1 ?? {}, (json2, id) {
        return CoverModel.fromJson(json2);
      });
    });
  }
}
