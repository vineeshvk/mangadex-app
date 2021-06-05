import '../../models/responses/common/error_response.dart';
import 'mangadex_exception.dart';

class CacheException extends MangaDexException<ErrorResponse> {
  CacheException({ErrorResponse? error}) : super(error: error);
}
