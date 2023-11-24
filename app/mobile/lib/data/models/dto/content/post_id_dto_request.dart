
import 'package:mobile/data/models/dto/base_dto_object.dart';
import 'package:mobile/utils/service_validation_util.dart';

class PostIdDTORequest extends BaseDTOObject<PostIdDTORequest> {
  int? postId;

  PostIdDTORequest({
    this.postId,
  });

  @override
  void validate() {
    ValidationUtil.validate(postId, ValidationPolicy.requiredValidation());
  }

  factory PostIdDTORequest.fromJson(Map<String, dynamic> json) =>
      PostIdDTORequest(
        postId: json["postId"],
      );

  @override
  Map<String, dynamic> toJson() => {
        "postId": postId,
      };

  @override
  PostIdDTORequest fromJson(Map<String, dynamic> json) =>
      PostIdDTORequest.fromJson(json);
}