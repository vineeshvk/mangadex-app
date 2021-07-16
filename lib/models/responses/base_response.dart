import '../../core/constants/string_constants.dart';
import 'common/error_response.dart';
import 'common/pagination_handler.dart';

class BaseResponse<T> {
  T? data;
  ErrorResponse? error;

  /// Will be used to handle the pagination for requests.
  PaginationHandler? pagination;

  BaseResponse({this.data, this.error, this.pagination});

  bool get hasData => data != null;

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
