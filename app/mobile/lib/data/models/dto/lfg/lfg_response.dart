import 'package:mobile/data/models/character_model.dart';
import 'package:mobile/data/models/dto/base_dto_object.dart';
import 'package:mobile/data/models/game_model.dart';
import 'package:mobile/data/models/lfg_model.dart';

class LFGDTOResponse extends BaseDTOObject<LFGDTOResponse> {
  LFG? lfg;

  LFGDTOResponse({
    this.lfg,
  });

  @override
  void validate() {}

  factory LFGDTOResponse.fromJson(Map<String, dynamic> json) =>
      LFGDTOResponse(lfg: LFG.fromJson(json));

  @override
  Map<String, dynamic> toJson() => lfg!.toJson();

  @override
  LFGDTOResponse fromJson(Map<String, dynamic> json) =>
      LFGDTOResponse.fromJson(json);
}
