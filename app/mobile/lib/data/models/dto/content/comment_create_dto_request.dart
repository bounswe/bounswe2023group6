import 'package:mobile/data/models/dto/base_dto_object.dart';
import 'package:mobile/utils/service_validation_util.dart';

class CommentCreateDTORequest extends BaseDTOObject<CommentCreateDTORequest> {
  String content;
  int? parentContentId;

  CommentCreateDTORequest({
    required this.content,
    this.parentContentId,
  });

  @override
  void validate() {
    ValidationUtil.validate(content, ValidationPolicy.stringNotEmptyValidation());
  }

  factory CommentCreateDTORequest.fromJson(Map<String, dynamic> json) =>
      CommentCreateDTORequest(
        content: json["content"],
        parentContentId: json["replyToCommentId"],
      );

  @override
  Map<String, dynamic> toJson() => {
        "content": content,
        "replyToCommentId": parentContentId,
      };

  @override
  CommentCreateDTORequest fromJson(Map<String, dynamic> json) =>
      CommentCreateDTORequest.fromJson(json);  
}
