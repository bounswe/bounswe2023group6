import 'dart:convert';

import 'package:mobile/data/models/dto/base_dto_object.dart';
import 'package:mobile/data/models/dto/content/single_content_dto_response.dart';

class MultipleContentAsDTO extends BaseDTOObject<MultipleContentAsDTO> {
  List<SingleContentDTO>? posts;

  MultipleContentAsDTO({
    this.posts,
  });

  @override
  void validate() {
    for (var post in posts!) {
      post.validate();
    }
  }

  factory MultipleContentAsDTO.fromJson(Map<String, dynamic> json) =>
      MultipleContentAsDTO(
        posts: List<SingleContentDTO>.from(
            json["response"].map((x) => SingleContentDTO.fromJson(x))),
      );

  @override
  Map<String, dynamic> toJson() => {
        "response": List<dynamic>.from(posts!.map((x) => x.toJson())),
      };

  @override
  MultipleContentAsDTO fromJson(Map<String, dynamic> json) =>
      MultipleContentAsDTO.fromJson(json);
}