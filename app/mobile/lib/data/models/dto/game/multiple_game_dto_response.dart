import 'package:mobile/data/models/dto/base_dto_object.dart';
import 'package:mobile/data/models/dto/game/game_response.dart';

class MultipleGameAsDTO extends BaseDTOObject<MultipleGameAsDTO> {
  List<GameDTOResponse>? games;

  MultipleGameAsDTO({
    this.games,
  });

  @override
  void validate() {
    for (var game in games!) {
      game.validate();
    }
  }

  factory MultipleGameAsDTO.fromJson(Map<String, dynamic> json) =>
      MultipleGameAsDTO(
        games: List<GameDTOResponse>.from(
            json["response"].map((x) => GameDTOResponse.fromJson(x))),
      );

  @override
  Map<String, dynamic> toJson() => {
        "response": List<dynamic>.from(games!.map((x) => x.toJson())),
      };

  @override
  MultipleGameAsDTO fromJson(Map<String, dynamic> json) =>
      MultipleGameAsDTO.fromJson(json);
}