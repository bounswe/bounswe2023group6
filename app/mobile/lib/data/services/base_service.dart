import 'dart:convert';

import 'package:dio/dio.dart' as dio;
import 'package:dio/dio.dart';

// ignore: implementation_imports
import 'package:dio/src/adapters/io_adapter.dart'
    if (dart.library.html) 'package:dio/src/adapters/browser_adapter.dart'
    as adapter;
import 'package:flutter/foundation.dart';
import 'package:mobile/constants/network_constants.dart';

import 'package:mobile/data/models/dto/base_dto_object.dart';

import 'package:mobile/data/models/service_response.dart';

class BaseNetworkService
    with
        // ignore: prefer_mixin
        DioMixin
    implements
        Dio {
  static const String _baseUrl = kDebugMode
      ? NetworkConstants.BASE_LOCAL_URL
      : NetworkConstants.BASE_PROD_URL;
  static const Duration _connectionTimeout = Duration(milliseconds: 100000);
  static const Duration _receiveTimeout = Duration(milliseconds: 60000);

  BaseNetworkService._init() {
    options = BaseOptions(
      baseUrl: _baseUrl,
      contentType: 'application/json',
      connectTimeout: _connectionTimeout,
      receiveTimeout: _receiveTimeout,
    );

    httpClientAdapter = adapter.createAdapter();
  }
  static final BaseNetworkService _instance = BaseNetworkService._init();

  factory BaseNetworkService() => _instance;
  static BaseNetworkService get instance => _instance;

  Future<ServiceResponse<DTORes>> sendRequestSafe<
      DTOReq extends BaseDTOObject<DTOReq>,
      DTORes extends BaseDTOObject<DTORes>>(
    String path,
    DTOReq? request,
    DTORes responseModel,
    String requestType,
  ) async {
    try {
      if (requestType != "GET") {
        request?.validate();
      }

      final ServiceResponse<DTORes> serviceResponse =
          await sendRequest<DTOReq, DTORes>(path, request, requestType);

      if (serviceResponse.success) {
        DTORes? response = parseResponse<DTORes>(
            serviceResponse.response?.data, responseModel);
        serviceResponse.responseConverted = response;
      }
      return serviceResponse;
    } on Exception catch (error) {
      if (kDebugMode) {
        print('Exception is occurred on path $path: ${error.toString()}');
      }
      return ServiceResponse(
        success: false,
        errorMessage: error.toString(),
      );
    }
  }

  Future<ServiceResponse<DTORes>> sendRequest<
      DTOReq extends BaseDTOObject<DTOReq>,
      DTORes extends BaseDTOObject<DTORes>>(
    String path,
    DTOReq? requestDTO,
    String type,
  ) async {
    Options customOptions = Options();
    customOptions
      ..method = type
      ..extra ??= <String, dynamic>{}
      ..headers ??= <String, dynamic>{};

    try {
      Map<String, dynamic>? data;
      if (type != "GET") {
        data = requestDTO?.toJson();
      }
      final Response<dynamic> response = await request(
        path,
        data: data,
        options: customOptions,
      );

      final dio.Response<Map<String, dynamic>> responseData =
          dio.Response<Map<String, dynamic>>(
        requestOptions: response.requestOptions,
        extra: response.extra,
        headers: response.headers,
        isRedirect: response.isRedirect,
        redirects: response.redirects,
        statusCode: response.statusCode,
        statusMessage: response.statusMessage,
        data: response.data is Map<String, dynamic>
            ? response.data
            : jsonDecode(response.data),
      );

      ServiceResponse<DTORes> serviceResponse = ServiceResponse(
        success: true,
        response: responseData,
      );
      return serviceResponse;
    } on DioException catch (error) {
      if (kDebugMode) {
        print('DioError is occurred on path $path: ${error.toString()}');
      }
      String? errorMessage = error.message;
      if (error.response?.data is Map<String, dynamic>) {
        errorMessage = error.response?.data['errorMessage'];
      }
      ServiceResponse<DTORes> serviceResponse = ServiceResponse(
        success: false,
        errorMessage: errorMessage,
      );
      return serviceResponse;
    }
  }

  DTORes? parseResponse<DTORes extends BaseDTOObject<DTORes>>(
      dynamic responseData, DTORes responseModel) {
    if (responseData == null) return null;
    if (responseData is DTORes) return responseData;

    if (responseData is Map<String, dynamic>) {
      DTORes response = responseModel.fromJson(responseData);
      responseModel = response;
      responseModel.validate();
      return response;
    }
    return null;
  }
}
