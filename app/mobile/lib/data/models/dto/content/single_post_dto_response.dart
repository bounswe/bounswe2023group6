import 'package:mobile/data/models/dto/base_dto_object.dart';
import 'package:mobile/data/models/post_model.dart';

class SinglePostDTO extends BaseDTOObject<SinglePostDTO> {
  Post? post;

  SinglePostDTO({
    this.post,
  });

  @override
  void validate() {
    // ValidationUtil.validate(id, ValidationPolicy.requiredValidation());
    // ValidationUtil.validate(title, ValidationPolicy.stringNotEmptyValidation());
    // ValidationUtil.validate(
    //     content, ValidationPolicy.stringNotEmptyValidation());
    // ValidationUtil.validate(
    //     createdAt, ValidationPolicy.requiredValidation());
    // ValidationUtil.validate(
    //     ownerUser, ValidationPolicy.requiredValidation());
  }

  factory SinglePostDTO.fromJson(Map<String, dynamic> json) =>
      SinglePostDTO(
        post: Post.fromJson(json["post"]),
      );

  @override
  Map<String, dynamic> toJson() => {
        "post": post!.toJson(),
      };

  @override
  SinglePostDTO fromJson(Map<String, dynamic> json) =>
      SinglePostDTO.fromJson(json);
}