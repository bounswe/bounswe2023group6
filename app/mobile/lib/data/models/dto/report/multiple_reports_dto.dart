import 'package:mobile/data/models/dto/base_dto_object.dart';
import 'package:mobile/data/models/dto/report/report_dto.dart';

class MultipleReportDTO extends BaseDTOObject<MultipleReportDTO> {
  List<ReportDTO>? reports;

  MultipleReportDTO({
    this.reports,
  });

  @override
  void validate() {}

  factory MultipleReportDTO.fromJson(Map<String, dynamic> json) =>
      MultipleReportDTO(
        reports: List<ReportDTO>.from(
            json["annotations"].map((x) => ReportDTO.fromJson(x))),
      );

  @override
  Map<String, dynamic> toJson() => {
        "annotations": List<dynamic>.from(reports!.map((x) => x.toJson())),
      };

  @override
  MultipleReportDTO fromJson(Map<String, dynamic> json) =>
      MultipleReportDTO.fromJson(json);
}