import 'package:mobile/data/models/base_model.dart';
import 'package:mobile/data/models/dto/login/login_request.dart';
import 'package:mobile/data/models/dto/login/login_response.dart';

class LoginModel
    extends BaseModel<LoginModel, LoginDTORequest, LoginDTOResponse> {
  String? username;
  String? password;

  String? message;

  LoginModel();

  @override
  LoginDTORequest convertToDTORequest() {
    return LoginDTORequest(
      username: username,
      password: password,
    );
  }

  @override
  void convertFromDTOResponse(LoginDTOResponse dtoResponse) {
    message = dtoResponse.message;
  }

  @override
  LoginDTOResponse parseResponse(Map<String, dynamic> response) {
    return LoginDTOResponse.fromJson(response);
  }
}
