import '../../models/responses/common/error_response.dart';
import 'mangadex_exception.dart';

class ApiException extends MangaDexException<ErrorResponse> {
  ApiException({ErrorResponse? error}) : super(error: error);
}
