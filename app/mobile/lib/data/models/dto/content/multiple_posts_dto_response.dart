import 'package:mobile/data/models/dto/base_dto_object.dart';
import 'package:mobile/data/models/dto/content/single_post_dto_response.dart';

class MultiplePostAsDTO extends BaseDTOObject<MultiplePostAsDTO> {
  List<SinglePostDTO>? posts;

  MultiplePostAsDTO({
    this.posts,
  });

  @override
  void validate() {
    for (var post in posts!) {
      post.validate();
    }
  }

  factory MultiplePostAsDTO.fromJson(Map<String, dynamic> json) =>
      MultiplePostAsDTO(
        posts: List<SinglePostDTO>.from(
            json["posts"].map((x) => SinglePostDTO.fromJson(x))),
      );

  @override
  Map<String, dynamic> toJson() => {
        "posts": List<dynamic>.from(posts!.map((x) => x.toJson())),
      };

  @override
  MultiplePostAsDTO fromJson(Map<String, dynamic> json) =>
      MultiplePostAsDTO.fromJson(json);
}