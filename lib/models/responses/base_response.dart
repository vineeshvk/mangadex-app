import 'common/error_response.dart';

class BaseResponse<T> {
  T? response;
  ErrorResponse? error;

  BaseResponse({this.response, this.error});

  bool get hasData => response != null;
  bool get hasError => error != null && error!.errors.isNotEmpty;
}
