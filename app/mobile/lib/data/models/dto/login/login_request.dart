import 'package:mobile/data/models/dto/base_dto_object.dart';
import 'package:mobile/utils/validation_util.dart';

class LoginDTORequest extends BaseDTOObject<LoginDTORequest> {
  String? email;
  String? password;

  LoginDTORequest({
    required this.email,
    required this.password,
  });

  @override
  void validate() {
    ValidationUtil.validate(email, ValidationPolicy.emailValidation());
    ValidationUtil.validate(password, ValidationPolicy.passwordValidation());
  }

  factory LoginDTORequest.fromJson(Map<String, dynamic> json) =>
      LoginDTORequest(
        email: json["email"],
        password: json["password"],
      );

  @override
  Map<String, dynamic> toJson() => {
        "email": email,
        "password": password,
      };

  @override
  LoginDTORequest fromJson(Map<String, dynamic> json) =>
      LoginDTORequest.fromJson(json);
}
