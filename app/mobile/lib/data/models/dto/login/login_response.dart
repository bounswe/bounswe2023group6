import 'package:mobile/data/models/dto/base_dto_object.dart';
import 'package:mobile/utils/service_validation_util.dart';

class LoginDTOResponse extends BaseDTOObject<LoginDTOResponse> {
  String? message;

  LoginDTOResponse({
    required this.message,
  });

  @override
  void validate() {
    ValidationUtil.validate(
        message, ValidationPolicy.stringNotEmptyValidation());
  }

  factory LoginDTOResponse.fromJson(Map<String, dynamic> json) =>
      LoginDTOResponse(
        message: json["message"],
      );

  @override
  Map<String, dynamic> toJson() => {
        "message": message,
      };

  @override
  LoginDTOResponse fromJson(Map<String, dynamic> json) =>
      LoginDTOResponse.fromJson(json);
}
