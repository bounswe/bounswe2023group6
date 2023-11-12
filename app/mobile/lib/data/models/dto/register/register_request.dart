import 'package:mobile/data/models/dto/base_dto_object.dart';
import 'package:mobile/utils/service_validation_util.dart';

class RegisterDTORequest extends BaseDTOObject<RegisterDTORequest> {
  String? username;
  String? email;
  String? password;
  String? name;
  String? surname;

  RegisterDTORequest({
    required this.username,
    required this.password,
    required this.email,
    required this.name,
    required this.surname,
  });

  @override
  void validate() {
    ValidationUtil.validate(
        username, ValidationPolicy.stringNotEmptyValidation());
    ValidationUtil.validate(password, ValidationPolicy.passwordValidation());
    ValidationUtil.validate(email, ValidationPolicy.emailValidation());
  }

  factory RegisterDTORequest.fromJson(Map<String, dynamic> json) =>
      RegisterDTORequest(
        username: json["username"],
        password: json["password"],
        email: json["email"],
        name: json["name"],
        surname: json["surname"],
      );

  @override
  Map<String, dynamic> toJson() => {
        "username": username,
        "password": password,
        "email": email,
        "name": name,
        "surname" : surname
      };

  @override
  RegisterDTORequest fromJson(Map<String, dynamic> json) =>
      RegisterDTORequest.fromJson(json);
}
