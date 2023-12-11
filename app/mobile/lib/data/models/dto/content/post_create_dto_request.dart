import 'dart:convert';

import 'package:mobile/data/models/dto/base_dto_object.dart';
import 'package:mobile/utils/service_validation_util.dart';

class PostCreateDTORequest extends BaseDTOObject<PostCreateDTORequest> {
  String title; 
  String content;
  int relatedGameId;
  String category;
  List<String> tags = [];

  PostCreateDTORequest({
    required this.title,
    required this.content,
    required this.relatedGameId,
    required this.category,
    required this.tags,
  });

  @override
  void validate() {
    ValidationUtil.validate(title, ValidationPolicy.stringNotEmptyValidation());
    ValidationUtil.validate(content, ValidationPolicy.stringNotEmptyValidation());
    ValidationUtil.validate(relatedGameId, ValidationPolicy.requiredValidation());
  }

  factory PostCreateDTORequest.fromJson(Map<String, dynamic> json) =>
      PostCreateDTORequest(
        title: json["title"],
        content: json["content"],
        relatedGameId: json["relatedGameId"],
        category: json["category"],
        tags: json["tags"] != null ? List<String>.from(json["tags"].map((x) => x)) : [],
      );

  @override
  Map<String, dynamic> toJson() => {
        "title": title,
        "content": content,
        "relatedGameId": relatedGameId,
        "category": category,
        "tags": tags,
      };

  @override
  PostCreateDTORequest fromJson(Map<String, dynamic> json) =>
      PostCreateDTORequest.fromJson(json);  
}
