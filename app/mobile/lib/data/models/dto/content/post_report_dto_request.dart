import 'package:mobile/data/models/dto/base_dto_object.dart';
import 'package:mobile/utils/service_validation_util.dart';

class PostReportDTORequest extends BaseDTOObject<PostReportDTORequest> {
  int? postId;
  String? reason;
  String? description;

  PostReportDTORequest({
    this.postId,
    this.reason,
    this.description,
  });

  @override
  void validate() {
    ValidationUtil.validate(postId, ValidationPolicy.requiredValidation());
    ValidationUtil.validate(reason, ValidationPolicy.stringNotEmptyValidation());
    ValidationUtil.validate(description, ValidationPolicy.stringNotEmptyValidation());
  }

  factory PostReportDTORequest.fromJson(Map<String, dynamic> json) =>
      PostReportDTORequest(
        postId: json["postId"],
        reason: json["reason"],
        description: json["description"],
      );

  @override
  Map<String, dynamic> toJson() => {
        "postId": postId,
        "reason": reason,
        "description": description,
      };

  @override
  PostReportDTORequest fromJson(Map<String, dynamic> json) =>
      PostReportDTORequest.fromJson(json);
}