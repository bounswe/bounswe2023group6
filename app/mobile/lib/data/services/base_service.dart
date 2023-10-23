import 'dart:convert';

import 'package:dio/dio.dart' as dio;
import 'package:dio/dio.dart';

// ignore: implementation_imports
import 'package:dio/src/adapters/io_adapter.dart'
    if (dart.library.html) 'package:dio/src/adapters/browser_adapter.dart'
    as adapter;
import 'package:flutter/foundation.dart';

import 'package:mobile/data/models/dto/base_dto_object.dart';

import 'package:mobile/data/models/base_model.dart';

class BaseNetworkService
    with
        // ignore: prefer_mixin
        DioMixin
    implements
        Dio {
  static const String _baseUrl = '';
  static const Duration _connectionTimeout = Duration(milliseconds: 10000);
  static const Duration _receiveTimeout = Duration(milliseconds: 6000);

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

  Future<void> sendRequestSafe<
      DTOReq extends BaseDTOObject<DTOReq>,
      DTORes extends BaseDTOObject<DTORes>,
      T extends BaseModel<T, DTOReq, DTORes>>(
    String path,
    T requestModel,
  ) async {
    DTOReq request = requestModel.validateAndConvertRequest();

    try {
      final Response<dynamic> response =
          await sendRequest<DTOReq>(path, request);

      parseResponse<DTOReq, DTORes, T>(response, requestModel);
    } on Exception catch (error) {
      if (kDebugMode) {
        print('Exception is occurred on path $path: ${error.toString()}');
      }
      rethrow;
    }
  }

  Future<Response<dynamic>> sendRequest<DTOReq extends BaseDTOObject<DTOReq>>(
      String path, DTOReq requestDTO) async {
    final Response<dynamic> response =
        await request(path, data: requestDTO.toJson());

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
    return responseData;
  }

  DTORes? parseResponse<
          DTOReq extends BaseDTOObject<DTOReq>,
          DTORes extends BaseDTOObject<DTORes>,
          T extends BaseModel<T, DTOReq, DTORes>>(
      Response<dynamic> response, T requestModel) {
    if (response.data == null) return null;
    if (response.data is DTORes) return response.data;

    if (response.data is Map<String, dynamic>) {
      requestModel.parseValidateAndConvertResponse(response.data);
    }
    return null;
  }
}
