import 'package:mobile/data/models/dto/base_dto_object.dart';

class GetAnnotationRequest extends BaseDTOObject<GetAnnotationRequest> {
  String targetId; 

  GetAnnotationRequest({
    required this.targetId,
  });

  @override
  void validate() {}

  factory GetAnnotationRequest.fromJson(Map<String, dynamic> json) =>
      GetAnnotationRequest(
        targetId: json["targetId"],
      );

  @override
  Map<String, dynamic> toJson() => {
        "targetId": targetId,
      };

  @override
  GetAnnotationRequest fromJson(Map<String, dynamic> json) =>
      GetAnnotationRequest.fromJson(json);
}
