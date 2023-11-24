import 'package:mobile/data/models/dto/base_dto_object.dart';

class EmptyResponse extends BaseDTOObject<EmptyResponse> {
  EmptyResponse();

  @override
  void validate() {}

  factory EmptyResponse.fromJson(Map<String, dynamic> json) => EmptyResponse();

  @override
  Map<String, dynamic> toJson() => {};

  @override
  EmptyResponse fromJson(Map<String, dynamic> json) => EmptyResponse.fromJson(json);
}