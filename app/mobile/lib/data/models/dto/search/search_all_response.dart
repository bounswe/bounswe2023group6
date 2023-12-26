import 'package:mobile/data/models/dto/base_dto_object.dart';
import 'package:mobile/data/models/game_model.dart';
import 'package:mobile/data/models/lfg_model.dart';
import 'package:mobile/data/models/post_model.dart';

class SearchAllResponse extends BaseDTOObject<SearchAllResponse> {
  List<Post>? posts;
  List<Game>? games;
  List<LFG>? lfgs;
  
  SearchAllResponse({
    this.posts,
    this.games,
    this.lfgs,
  });

  @override
  void validate() {
  }

  factory SearchAllResponse.fromJson(Map<String, dynamic> json) => SearchAllResponse(
        posts: List<Post>.from(json["postResults"].map((x) => Post.fromJson(x))),
        games: List<Game>.from(json["gameResults"].map((x) => Game.fromJson(x))),
        lfgs: List<LFG>.from(json["lfgResults"].map((x) => LFG.fromJson(x))),
      );

  @override
  Map<String, dynamic> toJson() => {
        "posts": List<dynamic>.from(posts!.map((x) => x.toJson())),
        "games": List<dynamic>.from(games!.map((x) => x.toJson())),
        "lfgs": List<dynamic>.from(lfgs!.map((x) => x.toJson())),
      };

  @override
  SearchAllResponse fromJson(Map<String, dynamic> json) {
    return SearchAllResponse.fromJson(json);
  }
}