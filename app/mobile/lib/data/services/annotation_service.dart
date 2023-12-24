import 'package:mobile/data/models/annotation_model.dart';
import 'package:mobile/data/models/dto/annotation/annotation_dto.dart';
import 'package:mobile/data/models/dto/annotation/multiple_annotation.dart';
import 'package:mobile/data/models/dto/empty_response.dart';
import 'package:mobile/data/models/service_response.dart';
import 'package:mobile/data/services/base_service.dart';

class AnnotationService {
  BaseNetworkService service = BaseNetworkService();

  AnnotationService._init();
  static final AnnotationService _instance = AnnotationService._init();

  factory AnnotationService() => _instance;

  static const String _getAnnotations = '/annotation';
  static const String _createAnnotation = '/annotation';
  static const String _updateAnnotation = '/annotation';
  static const String _deleteAnnotation = '/annotation';

  Future<List<Annotation>> getAnnotations(int contentId) async {
    ServiceResponse<MultipleAnnotationDTO> response =
        await service.sendRequestSafe<EmptyResponse, MultipleAnnotationDTO>(
      "$_getAnnotations/$contentId",
      null,
      MultipleAnnotationDTO(),
      'GET',
    );

    if (response.success) {
      return response.responseConverted!.annotations!.map((e) => e.annotation!).toList();
    } else {
      throw Exception('Failed to load annotations ${response.errorMessage}');
    }
  }

  Future<bool> createAnnotation(Annotation annotation) async {
    AnnotationDTO annotationDTO = AnnotationDTO();
    annotationDTO.annotation = annotation;

    ServiceResponse<EmptyResponse> response =
        await service.sendRequestSafe<AnnotationDTO, EmptyResponse>(
      _createAnnotation,
      annotationDTO,
      EmptyResponse(),
      'POST',
    );

    if (response.success) {
      return true;
    } else {
      throw Exception('Failed to create annotation ${response.errorMessage}');
    }
  }

  Future<bool> updateAnnotation(Annotation annotation) async {
    AnnotationDTO annotationDTO = AnnotationDTO();
    annotationDTO.annotation = annotation;

    ServiceResponse<EmptyResponse> response =
        await service.sendRequestSafe<AnnotationDTO, EmptyResponse>(
      _updateAnnotation,
      annotationDTO,
      EmptyResponse(),
      'PUT',
    );

    if (response.success) {
      return true;
    } else {
      throw Exception('Failed to update annotation ${response.errorMessage}');
    }
  }

  Future<bool> deleteAnnotation(int annotationId) async {
    ServiceResponse<EmptyResponse> response =
        await service.sendRequestSafe<EmptyResponse, EmptyResponse>(
      "$_deleteAnnotation/$annotationId",
      null,
      EmptyResponse(),
      'DELETE',
    );

    if (response.success) {
      return true;
    } else {
      throw Exception('Failed to delete annotation ${response.errorMessage}');
    }
  }

  Future<bool> deleteAllAnnotations(int contentId) async {
    ServiceResponse<EmptyResponse> response =
        await service.sendRequestSafe<EmptyResponse, EmptyResponse>(
      "$_deleteAnnotation/$contentId",
      null,
      EmptyResponse(),
      'DELETE',
    );

    if (response.success) {
      return true;
    } else {
      throw Exception('Failed to delete annotations ${response.errorMessage}');
    }
  }

  Future<bool> deleteAllAnnotationsForUser(int userId) async {
    ServiceResponse<EmptyResponse> response =
        await service.sendRequestSafe<EmptyResponse, EmptyResponse>(
      "$_deleteAnnotation/user/$userId",
      null,
      EmptyResponse(),
      'DELETE',
    );

    if (response.success) {
      return true;
    } else {
      throw Exception('Failed to delete annotations ${response.errorMessage}');
    }
  }

  Future<bool> deleteAllAnnotationsForContent(int contentId) async {
    ServiceResponse<EmptyResponse> response =
        await service.sendRequestSafe<EmptyResponse, EmptyResponse>(
      "$_deleteAnnotation/content/$contentId",
      null,
      EmptyResponse(),
      'DELETE',
    );

    if (response.success) {
      return true;
    } else {
      throw Exception('Failed to delete annotations ${response.errorMessage}');
    }
  }
}