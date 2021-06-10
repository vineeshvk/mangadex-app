import '../../models/responses/common/base_data_response.dart';

abstract class ChapterDataSource {
  Future<BaseDataResponse<void>> markChapterRead(String id);
  Future<BaseDataResponse<void>> markChapterUnRead(String id);
}
