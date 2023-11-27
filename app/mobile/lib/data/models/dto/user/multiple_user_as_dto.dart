import 'package:mobile/data/models/dto/base_dto_object.dart';
import 'package:mobile/data/models/dto/user/user_response.dart';

class MultipleUserAsDTO extends BaseDTOObject<MultipleUserAsDTO> {
  List<UserDTOResponse>? users;

  MultipleUserAsDTO({
    this.users,
  });

  @override
  void validate() {
    for (var user in users!) {
      user.validate();
    }
  }

  factory MultipleUserAsDTO.fromJson(Map<String, dynamic> json) =>
      MultipleUserAsDTO(
        users: List<UserDTOResponse>.from(
            json["response"].map((x) => UserDTOResponse.fromJson(x))),
      );

  @override
  Map<String, dynamic> toJson() => {
        "response": List<dynamic>.from(users!.map((x) => x.toJson())),
      };

  @override
  MultipleUserAsDTO fromJson(Map<String, dynamic> json) =>
      MultipleUserAsDTO.fromJson(json);
}