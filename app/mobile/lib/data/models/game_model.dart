import 'package:mobile/data/models/character_model.dart';
import 'package:mobile/data/models/post_model.dart';

class Game {
  final int gameId;
  final String title;
  final String description;
  
  String? developers;
  List<String>? genres;
  List<String>? platforms;
  List<Character>? characters;
  String? playerNumber;
  int? releaseYear;
  String? universe;
  String? mechanics;
  String? playtime;
  int? totalRating;
  int? countRating;
  double? averageRating;
  String? creationDate;
  final String gamePicture;

  List<Game> similarGameList;
  List<Post> relatedPosts;
  String? status;

  Game({
    required this.gameId,
    required this.title,
    required this.description,
    this.genres,
    this.platforms,
    this.playerNumber,
    this.releaseYear,
    this.universe,
    this.mechanics,
    this.playtime,
    this.totalRating,
    this.countRating,
    this.averageRating,
    this.creationDate,
    required this.gamePicture,
    this.developers,
    this.similarGameList = const [],
    this.relatedPosts = const [],
    this.status,
    this.characters,
  });

  factory Game.fromJson(Map<String, dynamic> json) {
    return Game(
      gameId: json['gameId'],
      title: json['title'],
      description: json['description'],
      genres: json["genres"] != null ? List<String>.from(json["genres"].map((x) => x)) : [],
      platforms: json["platforms"] != null ? List<String>.from(json["platforms"].map((x) => x)) : [],
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
      status: json['status'],
      characters: json['characters'] != null ? List<Character>.from(json["characters"].map((x) => Character.fromJson(x))) : []
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'gameId': gameId,
      'title': title,
      'description': description,
      'genres': genres,
      'platforms': platforms,
      'playerNumber': playerNumber,
      'universe': universe,
      'mechanics': mechanics,
      'playtime': playtime,
      'totalRating': totalRating,
      'countRating': countRating,
      'averageRating': averageRating,
      'creationDate': creationDate,
      'gamePicture': gamePicture,
      'status': status,
      'characters': characters,
    };
  }
}
