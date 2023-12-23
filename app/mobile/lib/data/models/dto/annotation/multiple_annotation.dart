import 'package:mobile/data/models/dto/annotation/annotation_dto.dart';
import 'package:mobile/data/models/dto/base_dto_object.dart';

class MultipleAnnotationDTO extends BaseDTOObject<MultipleAnnotationDTO> {
  List<AnnotationDTO>? annotations;

  MultipleAnnotationDTO({
    this.annotations,
  });

  @override
  void validate() {}

  factory MultipleAnnotationDTO.fromJson(Map<String, dynamic> json) =>
      MultipleAnnotationDTO(
        annotations: List<AnnotationDTO>.from(
            json["annotations"].map((x) => AnnotationDTO.fromJson(x))),
      );

  @override
  Map<String, dynamic> toJson() => {
        "annotations": List<dynamic>.from(annotations!.map((x) => x.toJson())),
      };

  @override
  MultipleAnnotationDTO fromJson(Map<String, dynamic> json) =>
      MultipleAnnotationDTO.fromJson(json);
}