import 'package:dio/dio.dart';

class ServiceResponse<T> {
  bool success;
  Response<dynamic>? response;
  T? responseConverted;
  String? errorMessage;

  ServiceResponse({
    required this.success,
    this.response,
    this.errorMessage,
  });
}
