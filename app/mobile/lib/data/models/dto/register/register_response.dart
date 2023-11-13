import 'package:mobile/data/models/dto/base_dto_object.dart';
import 'package:mobile/utils/service_validation_util.dart';

class RegisterDTOResponse extends BaseDTOObject<RegisterDTOResponse> {
  String? message;

  RegisterDTOResponse({
    this.message,
  });

  @override
  void validate() {
    ValidationUtil.validate(
        message, ValidationPolicy.stringNotEmptyValidation());
  }

  factory RegisterDTOResponse.fromJson(Map<String, dynamic> json) =>
      RegisterDTOResponse(
        message: json["message"],
      );

  @override
  Map<String, dynamic> toJson() => {
        "message": message,
      };

  @override
  RegisterDTOResponse fromJson(Map<String, dynamic> json) =>
      RegisterDTOResponse.fromJson(json);
}
