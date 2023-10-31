import 'dart:convert';
import 'dart:typed_data';

import 'package:mobile/data/models/dto/base_dto_object.dart';
import 'package:mobile/utils/service_validation_util.dart';

class UserDTOResponse extends BaseDTOObject<UserDTOResponse> {
  final String? name;
  final String? surname;
  final String? email;
  final String? username;
  final ByteData? profileImage;

  UserDTOResponse({
    this.name,
    this.surname,
    this.email,
    this.username,
    this.profileImage,
  });

  @override
  void validate() {
    ValidationUtil.validate(name, ValidationPolicy.stringNotEmptyValidation());
    ValidationUtil.validate(
        surname, ValidationPolicy.stringNotEmptyValidation());
    ValidationUtil.validate(email, ValidationPolicy.emailValidation());
    ValidationUtil.validate(
        username, ValidationPolicy.stringNotEmptyValidation());
  }

  factory UserDTOResponse.fromJson(Map<String, dynamic> json) =>
      UserDTOResponse(
        name: json["name"],
        surname: json["surname"],
        email: json["email"],
        username: json["username"],
        profileImage: ByteData.view(json['image']),
      );

  @override
  Map<String, dynamic> toJson() => {
        "name": name,
        "surname": surname,
        "email": email,
        "username": username,
        "image": profileImage.toString(),
      };

  @override
  UserDTOResponse fromJson(Map<String, dynamic> json) =>
      UserDTOResponse.fromJson(json);
}
