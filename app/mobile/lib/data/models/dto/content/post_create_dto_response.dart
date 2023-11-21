import 'package:mobile/data/models/dto/base_dto_object.dart';
import 'package:mobile/data/models/user_model.dart';
import 'package:mobile/utils/service_validation_util.dart';

class PostCreateDtoResponse extends BaseDTOObject<PostCreateDtoResponse> {
  int? id;
  String? title;
  String? content;
  DateTime? createdAt;
  User? ownerUser;

  PostCreateDtoResponse({
    this.id,
    this.title,
    this.content,
    this.createdAt,
    this.ownerUser,
  });

  @override
  void validate() {
    ValidationUtil.validate(id, ValidationPolicy.requiredValidation()); 
    ValidationUtil.validate(title, ValidationPolicy.stringNotEmptyValidation());
    ValidationUtil.validate(
        content, ValidationPolicy.stringNotEmptyValidation());
    ValidationUtil.validate(
        createdAt, ValidationPolicy.requiredValidation());
    // ValidationUtil.validate(
    //     ownerUser, ValidationPolicy.requiredValidation());
  }

  factory PostCreateDtoResponse.fromJson(Map<String, dynamic> json) =>
      PostCreateDtoResponse(
        id: json["id"],
        title: json["title"],
        content: json["content"],
        createdAt: DateTime.parse(json["createdAt"]),
        ownerUser: User.fromJson(json["user"]),
      );

  @override
  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "content": content,
        "createdAt": createdAt!.toIso8601String(),
        "user": ownerUser!.toJson(),
      };

  @override
  PostCreateDtoResponse fromJson(Map<String, dynamic> json) =>
      PostCreateDtoResponse.fromJson(json);
}
