import 'package:mobile/data/models/comment_model.dart';
import 'package:mobile/data/models/content_model.dart';
import 'package:mobile/data/models/dto/base_dto_object.dart';
import 'package:mobile/data/models/post_model.dart';

class SingleContentDTO extends BaseDTOObject<SingleContentDTO> {
  Content? content;

  SingleContentDTO({
    this.content,
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

  factory SingleContentDTO.fromJson(Map<String, dynamic> json) {
    try {
      return SingleContentDTO(
        content: Post.fromJson(json),
      );
    } catch (e) {
      try {
        return SingleContentDTO(
          content: Comment.fromJson(json),
        );
      } catch (e) {
        rethrow;
      }
    }
  }

  @override
  Map<String, dynamic> toJson() {
    switch (content!.type) {
      case ContentType.post:
        return (content as Post).toJson();
      case ContentType.comment:
        return (content as Comment).toJson();
      default:
        throw Exception('Unknown type');
    }
  }

  @override
  SingleContentDTO fromJson(Map<String, dynamic> json) =>
      SingleContentDTO.fromJson(json);
}