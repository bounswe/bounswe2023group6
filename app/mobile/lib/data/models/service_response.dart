import 'package:dio/dio.dart';

class ServiceResponse {
  bool success;
  Response<dynamic>? response;
  String? errorMessage;

  ServiceResponse({
    required this.success,
    this.response,
    this.errorMessage,
  });
}
