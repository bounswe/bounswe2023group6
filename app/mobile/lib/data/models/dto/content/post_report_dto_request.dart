import 'package:mobile/data/models/dto/base_dto_object.dart';
import 'package:mobile/utils/service_validation_util.dart';

class PostReportDTORequest extends BaseDTOObject<PostReportDTORequest> {
  String? reason;

  PostReportDTORequest({
    this.reason,
  });

  @override
  void validate() {
    ValidationUtil.validate(reason, ValidationPolicy.stringNotEmptyValidation());
  }

  factory PostReportDTORequest.fromJson(Map<String, dynamic> json) =>
      PostReportDTORequest(
        reason: json["reason"],
      );

  @override
  Map<String, dynamic> toJson() => {
        "reason": reason,
      };

  @override
  PostReportDTORequest fromJson(Map<String, dynamic> json) =>
      PostReportDTORequest.fromJson(json);
}