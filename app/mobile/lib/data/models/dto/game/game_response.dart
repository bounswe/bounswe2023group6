import 'package:mobile/data/models/dto/base_dto_object.dart';

class GameDTOResponse extends BaseDTOObject<GameDTOResponse> {
  int? id;
  String? name;
  String? description;
  String? imageLink;
  String? releaseYear;
  String? developers;
  String? genre;
  String? platforms;
  String? gameModes;
  String? themes;
  String? playerPerspective;
  String? artStyle;
  String? series;

  GameDTOResponse({
    this.id,
    this.name,
    this.description,
    this.imageLink,
    this.releaseYear,
    this.developers,
    this.genre,
    this.platforms,
    this.gameModes,
    this.themes,
    this.playerPerspective,
    this.artStyle,
    this.series,
  });

  @override
  void validate() {
  }

  factory GameDTOResponse.fromJson(Map<String, dynamic> json) =>
      GameDTOResponse(
        id: json['id'],
        name: json['title'],
        description: json['description'],
        imageLink: json['imageLink'],
        releaseYear: json['releaseYear'],
        developers: json['developers'],
        genre: json['genre'],
      );

  @override
  Map<String, dynamic> toJson() => {
        'id': id,
        'title': name,
        'description': description,
        'imageLink': imageLink,
        'releaseYear': releaseYear,
        'developers': developers,
        'genre': genre,
      };

  @override
  GameDTOResponse fromJson(Map<String, dynamic> json) =>
      GameDTOResponse.fromJson(json);
}
