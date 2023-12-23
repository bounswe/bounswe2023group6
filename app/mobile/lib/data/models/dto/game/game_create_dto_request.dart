import 'package:mobile/data/models/dto/base_dto_object.dart';
import 'package:mobile/utils/service_validation_util.dart';

class GameCreateDTORequest extends BaseDTOObject<GameCreateDTORequest> {
  String title;
  String description;
  String? genre;
  String? platform;
  String? numberOfPlayer;
  int year;
  String? universe;
  String playtime;
  String? mechanics;


  GameCreateDTORequest({
    required this.title,
    required this.description,
    required this.genre,
    required this.platform,
    required this.numberOfPlayer,
    required this.year,
    required this.universe,
    required this.playtime,
    required this.mechanics,
  });

  @override
  void validate() {
    ValidationUtil.validate(title, ValidationPolicy.stringNotEmptyValidation());
    ValidationUtil.validate(
        description, ValidationPolicy.stringNotEmptyValidation());
  }

  factory GameCreateDTORequest.fromJson(Map<String, dynamic> json) =>
      GameCreateDTORequest(
        title: json["title"],
        description: json["description"],
        genre: json["genre"],
        platform: json["platform"],
        numberOfPlayer: json["playerNumber"],
        year: json["releaseYear"],
        universe: json["universe"],
        playtime: json["playtime"],
        mechanics: json["mechanics"]
      );

  @override
  Map<String, dynamic> toJson() => {
        "title": title,
        "description": description,
        "genre": genre,
        "platform": platform,
        "playerNumber": numberOfPlayer,
        "releaseYear": year,
        "mechanics": mechanics,
        "universe": universe,
        "playtime": playtime,
        "totalRating": 0,
        "countRating": 0,
        "averageRating": 0,
      };
      
  @override
  GameCreateDTORequest fromJson(Map<String, dynamic> json) =>
      GameCreateDTORequest.fromJson(json);
}
