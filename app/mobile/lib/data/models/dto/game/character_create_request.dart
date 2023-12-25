import 'package:mobile/data/models/dto/base_dto_object.dart';
import 'package:mobile/utils/service_validation_util.dart';

class CharacterCreateRequest extends BaseDTOObject<CharacterCreateRequest> {
  String name;
  String description;


  CharacterCreateRequest({
    required this.name,
    required this.description,

  });

  @override
  void validate() {
    ValidationUtil.validate(name, ValidationPolicy.stringNotEmptyValidation());
    ValidationUtil.validate(
        description, ValidationPolicy.stringNotEmptyValidation());
  }

  factory CharacterCreateRequest.fromJson(Map<String, dynamic> json) =>
      CharacterCreateRequest(
        name: json["name"],
        description: json["description"],
      );

  @override
  Map<String, dynamic> toJson() => {
        "name": name,
        "description": description,
      };

  @override
  CharacterCreateRequest fromJson(Map<String, dynamic> json) =>
      CharacterCreateRequest.fromJson(json);
}