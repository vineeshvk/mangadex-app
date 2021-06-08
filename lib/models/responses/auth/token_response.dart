import 'package:json_annotation/json_annotation.dart';

import '../../auth/token_model.dart';

part 'token_response.g.dart';

@JsonSerializable(createToJson: false)
class TokenResponse {
  final String result;
  final TokenModel token;

  TokenResponse({
    required this.result,
    required this.token,
  });

  factory TokenResponse.fromJson(Map<String, dynamic> json) =>
      _$TokenResponseFromJson(json);
}
