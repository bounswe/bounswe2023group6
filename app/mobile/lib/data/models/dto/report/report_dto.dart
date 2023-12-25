import 'package:mobile/data/models/report_model.dart';
import 'package:mobile/data/models/dto/base_dto_object.dart';

class ReportDTO extends BaseDTOObject<ReportDTO> {
  Report? report;

  ReportDTO({
    this.report,
  });

  @override
  void validate() {}

  factory ReportDTO.fromJson(Map<String, dynamic> json) => ReportDTO(
        report: Report.fromJson(json),
      );

  @override
  Map<String, dynamic> toJson() => report!.toJson();

  @override
  ReportDTO fromJson(Map<String, dynamic> json) =>
      ReportDTO.fromJson(json);
}
