import 'package:mobile/data/models/dto/base_dto_object.dart';
import 'package:mobile/data/models/dto/game/game_response.dart';
import 'package:mobile/data/models/dto/lfg/lfg_response.dart';

class MultipleLFGAsDTO extends BaseDTOObject<MultipleLFGAsDTO> {
  List<LFGDTOResponse>? lfgs;

  MultipleLFGAsDTO({
    this.lfgs,
  });

  @override
  void validate() {
    for (var lfg in lfgs!) {
      lfg.validate();
    }
  }

  factory MultipleLFGAsDTO.fromJson(Map<String, dynamic> json) =>
      MultipleLFGAsDTO(
        lfgs: List<LFGDTOResponse>.from(
            json["response"].map((x) => LFGDTOResponse.fromJson(x))),
      );

  @override
  Map<String, dynamic> toJson() => {
        "response": List<dynamic>.from(lfgs!.map((x) => x.toJson())),
      };

  @override
  MultipleLFGAsDTO fromJson(Map<String, dynamic> json) =>
      MultipleLFGAsDTO.fromJson(json);
}
