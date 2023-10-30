import 'package:mobile/data/models/dto/base_dto_object.dart';
import 'package:mobile/utils/service_validation_util.dart';

class LoginDTORequest extends BaseDTOObject<LoginDTORequest> {
  String? username;
  String? password;

  LoginDTORequest({
    required this.username,
    required this.password,
  });

  @override
  void validate() {
    ValidationUtil.validate(
        username, ValidationPolicy.stringNotEmptyValidation());
    ValidationUtil.validate(password, ValidationPolicy.passwordValidation());
  }

  factory LoginDTORequest.fromJson(Map<String, dynamic> json) =>
      LoginDTORequest(
        username: json["username"],
        password: json["password"],
      );

  @override
  Map<String, dynamic> toJson() => {
        "username": username,
        "password": password,
      };

  @override
  LoginDTORequest fromJson(Map<String, dynamic> json) =>
      LoginDTORequest.fromJson(json);
}
