import 'package:mobile/data/models/annotation_model.dart';
import 'package:mobile/data/models/dto/base_dto_object.dart';

class AnnotationDTO extends BaseDTOObject<AnnotationDTO> {
  Annotation? annotation;

  AnnotationDTO({
    this.annotation,
  });

  @override
  void validate() {}

  factory AnnotationDTO.fromJson(Map<String, dynamic> json) => AnnotationDTO(
        annotation: Annotation.fromJson(json),
      );

  @override
  Map<String, dynamic> toJson() => annotation!.toJson();

  @override
  AnnotationDTO fromJson(Map<String, dynamic> json) =>
      AnnotationDTO.fromJson(json);
}
