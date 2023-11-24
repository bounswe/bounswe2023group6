import 'package:mobile/data/models/dto/base_dto_object.dart';
import 'package:mobile/data/models/dto/content/single_post_dto_response.dart';
import 'package:mobile/utils/service_validation_util.dart';

class PostUpdateDTORequest extends BaseDTOObject<PostUpdateDTORequest> {
  int? postId; 
  SinglePostDTO? updatedPost; 

  PostUpdateDTORequest({
    this.postId, 
    this.updatedPost,
  });

  @override
  void validate() {
    ValidationUtil.validate(postId, ValidationPolicy.requiredValidation());
    updatedPost!.validate();
  }

  factory PostUpdateDTORequest.fromJson(Map<String, dynamic> json) =>
      PostUpdateDTORequest(
        postId: json["postId"],
        updatedPost: SinglePostDTO.fromJson(json["updatedPost"]),
      );

  @override
  Map<String, dynamic> toJson() => {
        "postId": postId,
        "updatedPost": updatedPost!.toJson(),
      };

  @override
  PostUpdateDTORequest fromJson(Map<String, dynamic> json) =>
      PostUpdateDTORequest.fromJson(json);
}