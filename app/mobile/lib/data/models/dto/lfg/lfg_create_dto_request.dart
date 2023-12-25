import 'package:mobile/data/models/dto/base_dto_object.dart';
import 'package:mobile/utils/service_validation_util.dart';

class LFGCreateDTORequest extends BaseDTOObject<LFGCreateDTORequest> {
  String title;
  String description;
  String requiredPlatform;
  String requiredLanguage;
  bool micCamRequirement;
  int memberCapacity;
  int? gameId;
  List<String> tags;

  LFGCreateDTORequest({
    required this.title,
    required this.description,
    required this.requiredPlatform,
    required this.requiredLanguage,
    required this.micCamRequirement,
    required this.memberCapacity,
    required this.gameId,
    required this.tags,
  });

  @override
  void validate() {
    ValidationUtil.validate(title, ValidationPolicy.stringNotEmptyValidation());
    ValidationUtil.validate(
        description, ValidationPolicy.stringNotEmptyValidation());
  }

  factory LFGCreateDTORequest.fromJson(Map<String, dynamic> json) =>
      LFGCreateDTORequest(
        title: json["title"],
        description: json["description"],
        requiredPlatform: json["requiredPlatform"],
        requiredLanguage: json["requiredLanguage"],
        micCamRequirement: json["micCamRequirement"],
        memberCapacity: json["memberCapacity"],
        gameId: json["gameId"],
        tags: json["tags"] != null
            ? List<String>.from(json["tags"].map((x) => x))
            : [],
      );

  @override
  Map<String, dynamic> toJson() => {
        "title": title,
        "description": description,
        "requiredPlatform": requiredPlatform,
        "requiredLanguage": requiredLanguage,
        "micCamRequirement": micCamRequirement,
        "memberCapacity": memberCapacity,
        "gameId": gameId,
        "tags": tags,
      };

  @override
  LFGCreateDTORequest fromJson(Map<String, dynamic> json) =>
      LFGCreateDTORequest.fromJson(json);
}
