import 'package:mobile/data/models/dto/base_dto_object.dart';

abstract class BaseModel<T, DTOReq extends BaseDTOObject,
    DTORes extends BaseDTOObject> {
  BaseModel();

  DTOReq convertToDTORequest();
  DTORes parseResponse(Map<String, dynamic> response);
  void convertFromDTOResponse(DTORes dtoResponse);

  DTOReq validateAndConvertRequest() {
    DTOReq requestAsDTO = convertToDTORequest();
    requestAsDTO.validate();

    return requestAsDTO;
  }

  void parseValidateAndConvertResponse(Map<String, dynamic> response) {
    final DTORes responseAsDTO = parseResponse(response);
    responseAsDTO.validate();
    convertFromDTOResponse(responseAsDTO);
  }
}
