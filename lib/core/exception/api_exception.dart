import '../../http/responses/common/error_response.dart';

class ApiException implements Exception {
  ErrorResponse? error;
  ApiException({this.error});
}
