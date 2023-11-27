import 'package:mobile/data/models/dto/base_dto_object.dart';
import 'package:mobile/utils/service_validation_util.dart';

class GameIdDTORequest extends BaseDTOObject<GameIdDTORequest> {
  int? gameId;

  GameIdDTORequest({
    this.gameId,
  });

  @override
  void validate() {
    ValidationUtil.validate(gameId, ValidationPolicy.requiredValidation());
  }

  factory GameIdDTORequest.fromJson(Map<String, dynamic> json) =>
      GameIdDTORequest(
        gameId: json["gameId"],
      );

  @override
  Map<String, dynamic> toJson() => {
        "gameId": gameId,
      };

  @override
  GameIdDTORequest fromJson(Map<String, dynamic> json) =>
      GameIdDTORequest.fromJson(json);
}