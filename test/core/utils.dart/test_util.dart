import 'package:flutter_test/flutter_test.dart';
import 'package:mangadex/core/constants/string_constants.dart';

class TestUtil {
  static TypeMatcher checkError(TypeMatcher object, [String? errorMessage]) {
    return object.having((res) => res.hasError, "hasError", true).having(
          (res) => res.errorMessage,
          "error",
          errorMessage ?? StringConstants.somethingWentWrong,
        );
  }
}
