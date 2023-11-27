import 'package:mobile/data/models/character_model.dart';
import 'package:mobile/data/models/dto/base_dto_object.dart';
import 'package:mobile/data/models/game_model.dart';

class GameDTOResponse extends BaseDTOObject<GameDTOResponse> {
  Game? game;

  GameDTOResponse({
    this.game,
  });

  @override
  void validate() {
  }

  factory GameDTOResponse.fromJson(Map<String, dynamic> json) =>
      GameDTOResponse(
        game: Game.fromJson(json)
      );

  @override
  Map<String, dynamic> toJson()  => game!.toJson();

  @override
  GameDTOResponse fromJson(Map<String, dynamic> json) =>
      GameDTOResponse.fromJson(json);
}
