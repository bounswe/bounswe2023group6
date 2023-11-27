import 'package:mobile/data/models/character_model.dart';
import 'package:mobile/data/models/dto/base_dto_object.dart';

class GameDTOResponse extends BaseDTOObject<GameDTOResponse> {
  int? id;
  int? gameId;
  String? title;
  String? description;
  String? developers;
  String? genre;
  String? platform;
  List<Character>? characters;
  String? playerNumber;
  String? releaseYear;
  String? universe;
  String? mechanics;
  String? playtime;
  int? totalRating;
  int? countRating;
  double? averageRating;
  String? creationDate;
  String? gamePicture;

  GameDTOResponse({
    this.gameId,
    this.title,
    this.description,
    this.genre,
    this.platform,
    this.playerNumber,
    this.releaseYear,
    this.universe,
    this.mechanics,
    this.playtime,
    this.totalRating,
    this.countRating,
    this.averageRating,
    this.creationDate,
    this.gamePicture,
  });

  @override
  void validate() {
  }

  factory GameDTOResponse.fromJson(Map<String, dynamic> json) =>
      GameDTOResponse(
        gameId: json['gameId'],
        title: json['title'],
        description: json['description'],
        genre: json['genre'],
        platform: json['platform'],
        playerNumber: json['playerNumber'],
        releaseYear: json['releaseYear'],
        universe: json['universe'],
        mechanics: json['mechanics'],
        playtime: json['playtime'],
        totalRating: json['totalRating'],
        countRating: json['countRating'],
        averageRating: json['averageRating'],
        creationDate: json['creationDate'],
        gamePicture: json['gamePicture'],
      );

  @override
  Map<String, dynamic> toJson() => {
        'gameId': gameId,
        'title': title,
        'description': description,
        'genre': genre,
        'platform': platform,
        'playerNumber': playerNumber,
        'universe': universe,
        'mechanics': mechanics,
        'playtime': playtime,
        'totalRating': totalRating,
        'countRating': countRating,
        'averageRating': averageRating,
        'creationDate': creationDate,
        'gamePicture': gamePicture,
      };

  @override
  GameDTOResponse fromJson(Map<String, dynamic> json) =>
      GameDTOResponse.fromJson(json);
}
