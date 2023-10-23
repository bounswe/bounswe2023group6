import 'package:mobile/data/models/dto/base_dto_object.dart';
import 'package:mobile/utils/validation_util.dart';

class LoginDTOResponse extends BaseDTOObject<LoginDTOResponse> {
  String? resultMessage;
  String? token;

  LoginDTOResponse({
    required this.resultMessage,
    required this.token,
  });

  @override
  void validate() {
    ValidationUtil.validate(
        resultMessage, ValidationPolicy.stringNotEmptyValidation());
    ValidationUtil.validate(token, ValidationPolicy.stringNotEmptyValidation());
  }

  factory LoginDTOResponse.fromJson(Map<String, dynamic> json) =>
      LoginDTOResponse(
        resultMessage: json["resultMessage"],
        token: json["token"],
      );

  @override
  Map<String, dynamic> toJson() => {
        "resultMessage": resultMessage,
        "token": token,
      };

  @override
  LoginDTOResponse fromJson(Map<String, dynamic> json) =>
      LoginDTOResponse.fromJson(json);
}
