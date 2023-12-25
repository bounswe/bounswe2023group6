import 'package:mobile/constants/network_constants.dart';
import 'package:mobile/data/models/annotation_model.dart';
import 'package:mobile/data/models/dto/annotation/annotation_dto.dart';
import 'package:mobile/data/models/dto/annotation/get_annotation_request.dart';
import 'package:mobile/data/models/dto/annotation/multiple_annotation.dart';
import 'package:mobile/data/models/dto/empty_response.dart';
import 'package:mobile/data/models/service_response.dart';
import 'package:mobile/data/services/base_service.dart';

class AnnotationService {
  BaseNetworkService service = BaseNetworkService();
  final String _baseUrl = NetworkConstants.ANNOTATION_SERVICE_URL;

  AnnotationService._init();
  static final AnnotationService _instance = AnnotationService._init();

  factory AnnotationService() => _instance;

  static const String _getAnnotationsByTargetId =
      "/annotation/get-annotations-by-target";
  static const String _createAnnotation = '/annotation/create';
  static const String _deleteAnnotation = '/annotation';

  Future<List<BaseAnnotation>> getAnnotationsByTargetId(
      AnnotationContext context, int id) async {
    String targetId =
        "${NetworkConstants.BASE_LOCAL_URL}/${context.toString().split(".")[1]}/$id";
    GetAnnotationRequest request = GetAnnotationRequest(targetId: targetId);

    ServiceResponse<MultipleAnnotationDTO> response = await service
        .sendRequestSafe<GetAnnotationRequest, MultipleAnnotationDTO>(
      _getAnnotationsByTargetId,
      request,
      MultipleAnnotationDTO(),
      'POST',
      baseUrl: _baseUrl,
    );

    if (response.success) {
      return response.responseConverted!.annotations!
          .map((e) => e.annotation!)
          .toList();
    } else {
      throw Exception('Failed to load annotations ${response.errorMessage}');
    }
  }

  Future<bool> createAnnotation(BaseAnnotation annotation) async {
    AnnotationDTO annotationDTO = AnnotationDTO();
    annotationDTO.annotation = annotation;

    ServiceResponse<EmptyResponse> response =
        await service.sendRequestSafe<AnnotationDTO, EmptyResponse>(
      _createAnnotation,
      annotationDTO,
      EmptyResponse(),
      'POST',
      baseUrl: _baseUrl,
    );

    if (response.success) {
      return true;
    } else {
      throw Exception('Failed to create annotation ${response.errorMessage}');
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
}
