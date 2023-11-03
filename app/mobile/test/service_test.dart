import 'dart:io';

import 'package:dio/dio.dart';
import 'package:mobile/constants/network_constants.dart';
import 'package:mobile/data/models/dto/login/login_request.dart';
import 'package:mobile/data/models/dto/login/login_response.dart';
import 'package:mobile/data/models/service_response.dart';
import 'package:test/test.dart';

import "package:mobile/data/services/base_service.dart";

void main() {
  test("Service test", () async {
    final dio = Dio();

    try {
      final response = await dio.post(
        '${NetworkConstants.BASE_LOCAL_URL}/register',
        data: {
          'username': 'erkam.kavak',
          'password': '123456',
          'email': 'erkam@boun.edu.tr',
          'name': 'Erkam',
          'surname': 'Kavak',
          'image': await File.fromUri(Uri.parse('./lib/assets/avatar.jpg'))
              .readAsBytes(),
        },
      );
      expect(response.data['message'], 'Registered successfully!');
    } on DioException catch (error) {
      expect(error.response?.statusCode, 400);
      print(
          "Test failed with 400 error code because of ${error.response?.data['errorMessage']}");
    }
  });

  test("Login test", () async {
    final BaseNetworkService service = BaseNetworkService();
    expect(service, isNotNull);

    const String path = '/login';
    final LoginDTORequest loginRequest = LoginDTORequest(
      username: "erkam.kavak",
      password: "123456",
    );
    ServiceResponse serviceResponse =
        await service.sendRequestSafe<LoginDTORequest, LoginDTOResponse>(
      path,
      loginRequest,
      LoginDTOResponse(),
      'POST',
    );

    expect(serviceResponse, isNotNull);
    if (serviceResponse.success) {
      LoginDTOResponse loginResponse = serviceResponse.responseConverted;
      expect(loginResponse.message, isNotNull);
      expect(loginResponse.message, 'Logged in successfully.');
      // expect(loginModel.sessionId, isNotNull);
    } else {
      expect(serviceResponse.errorMessage, isNotNull);
      print(serviceResponse.errorMessage);
    }
  });
}
