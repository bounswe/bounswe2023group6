class Character {
  final int characterId;
  final String name;
  final String description;
  final int gameId;

  Character({
    required this.characterId,
    required this.name,
    required this.description,
    required this.gameId
  });

  factory Character.fromJson(Map<String, dynamic> json) {
    return Character(
      characterId: json['characterId'],
      name: json['name'],
      description: json['description'],
      gameId: json['gameID'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'characterId': characterId,
      'title': name,
      'description': description,
      'gameID': gameId,
    };
  }
}
