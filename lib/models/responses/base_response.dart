import '../../core/constants/string_constants.dart';
import 'common/error_response.dart';

class BaseResponse<T> {
  T? response;
  ErrorResponse? error;

  BaseResponse({this.response, this.error});

  bool get hasData => response != null;

  /// Return true if the error object is present or if the data is null
  /// Else it will return false
  bool get hasError => error != null && error!.errors.isNotEmpty || !hasData;

  String get errorMessage {
    String? message;
    if (error != null && error!.errors.isNotEmpty) {
      message = error!.errors.first.title;
    }
    return message ?? StringConstants.somethingWentWrong;
  }
}
