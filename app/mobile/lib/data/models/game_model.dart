import 'package:mobile/data/models/post_model.dart';

class Game {
  final int id;
  final String name;
  final String description;
  final String imageLink;
  String? releaseYear;
  String? developers;
  String? genre;
  String? platforms;
  String? gameModes;
  String? themes;
  String? playerPerspective;
  String? artStyle;
  String? series;
  List<Game> similarGameList;
  List<Post> relatedPosts;

  Game({
    required this.id,
    required this.name,
    required this.description,
    required this.imageLink,
    this.releaseYear,
    this.developers,
    this.genre,
    this.platforms,
    this.gameModes,
    this.themes,
    this.playerPerspective,
    this.artStyle,
    this.series,
    this.similarGameList = const [],
    this.relatedPosts = const [],
  });


  factory Game.fromJson(Map<String, dynamic> json) {
    return Game(
      id: json['id'],
      name: json['title'],
      description: json['description'],
      imageLink: json['imageLink'],
      releaseYear: json['releaseYear'],
      developers: json['developers'],
      genre: json['genre'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': name,
      'description': description,
      'imageLink': imageLink,
      'releaseYear': releaseYear,
      'developers': developers,
      'genre': genre,
    };
  }
}
