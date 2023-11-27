import 'package:mobile/data/models/character_model.dart';
import 'package:mobile/data/models/post_model.dart';

class Game {
  final int gameId;
  final String title;
  final String description;
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
  final String gamePicture;

  List<Game> similarGameList;
  List<Post> relatedPosts;

  Game({
    required this.gameId,
    required this.title,
    required this.description,
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
    required this.gamePicture,
    this.developers,
    this.similarGameList = const [],
    this.relatedPosts = const [],
  });

  factory Game.fromJson(Map<String, dynamic> json) {
    return Game(
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
  }

  Map<String, dynamic> toJson() {
    return {
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
  }
}
