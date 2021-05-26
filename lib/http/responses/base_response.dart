import 'common/error_response.dart';

class BaseResponse<T> {
  T? response;
  ErrorResponse? error;

  BaseResponse({this.response, this.error});
}
