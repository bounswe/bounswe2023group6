import 'package:mobile/data/models/dto/base_dto_object.dart';
import 'package:mobile/utils/service_validation_util.dart';

class PostCreateDTORequest extends BaseDTOObject<PostCreateDTORequest> {
  String title; 
  String content;

  PostCreateDTORequest({
    required this.title,
    required this.content,
  });

  @override
  void validate() {
    ValidationUtil.validate(title, ValidationPolicy.stringNotEmptyValidation());
    ValidationUtil.validate(content, ValidationPolicy.stringNotEmptyValidation());
  }

  factory PostCreateDTORequest.fromJson(Map<String, dynamic> json) =>
      PostCreateDTORequest(
        title: json["title"],
        content: json["content"],
      );

  @override
  Map<String, dynamic> toJson() => {
        "title": title,
        "content": content,
      };

  @override
  PostCreateDTORequest fromJson(Map<String, dynamic> json) =>
      PostCreateDTORequest.fromJson(json);  
}
