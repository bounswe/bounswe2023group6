import 'package:mobile/data/models/dto/base_dto_object.dart';
import 'package:mobile/data/models/user_model.dart';
import 'package:mobile/utils/service_validation_util.dart';

class UserDTOResponse extends BaseDTOObject<UserDTOResponse> {
  User? user;

  UserDTOResponse({
    this.user,
  });

  @override
  void validate() {
    ValidationUtil.validate(user!.username, ValidationPolicy.stringNotEmptyValidation());
    ValidationUtil.validate(user!.email, ValidationPolicy.emailValidation());
  }

  factory UserDTOResponse.fromJson(Map<String, dynamic> json) => UserDTOResponse(
        user: User.fromJson(json),
      );

  @override
  Map<String, dynamic> toJson() => user!.toJson();

  @override
  UserDTOResponse fromJson(Map<String, dynamic> json) =>
      UserDTOResponse.fromJson(json);
}
