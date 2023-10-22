import 'package:mobile/data/models/base_model.dart';
import 'package:mobile/data/models/dto/login/login_request.dart';
import 'package:mobile/data/models/dto/login/login_response.dart';

class LoginModel
    extends BaseModel<LoginModel, LoginDTORequest, LoginDTOResponse> {
  String? email;
  String? password;

  String? resultMessage;
  String? token;

  LoginModel();

  @override
  LoginDTORequest convertToDTORequest() {
    return LoginDTORequest(
      email: email,
      password: password,
    );
  }

  @override
  void convertFromDTOResponse(LoginDTOResponse dtoResponse) {
    resultMessage = dtoResponse.resultMessage;
    token = dtoResponse.token;
  }

  @override
  LoginDTOResponse parseResponse(Map<String, dynamic> response) {
    return LoginDTOResponse.fromJson(response);
  }
}
