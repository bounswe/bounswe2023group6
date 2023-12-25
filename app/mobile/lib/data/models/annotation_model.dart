import 'package:mobile/constants/network_constants.dart';
import 'package:uuid/uuid.dart';

enum AnnotationContext {
  post,
  lfg,
  comment,
  game,
}

abstract class BaseAnnotation {
  final String authorUsername;
  final String annotation;
  final int contextId; // post, lfg, comment, game
  final AnnotationContext context;

  BaseAnnotation({
    required this.authorUsername,
    required this.annotation,
    required this.contextId,
    required this.context,
  });

  factory BaseAnnotation.fromJson(Map<String, dynamic> json) {
    if (json['target']['selector']['type'] == 'TextPositionSelector') {
      return TextAnnotation.fromJson(json);
    } else {
      return ImageAnnotation.fromJson(json);
    }
  }

  Map<String, dynamic> toJson();
}

class TextAnnotation extends BaseAnnotation {
  final int startIndex;
  final int endIndex;

  TextAnnotation({
    required authorUsername,
    required annotation,
    required contextId,
    required context,
    required this.startIndex,
    required this.endIndex,
  }) : super(
          authorUsername: authorUsername,
          annotation: annotation,
          contextId: contextId,
          context: context,
        );

  factory TextAnnotation.fromJson(Map<String, dynamic> json) {
    // convert from json-ld format
    return TextAnnotation(
      startIndex: json['target']['selector']['start'],
      endIndex: json['target']['selector']['end'],
      authorUsername: json['creator'].split('/').last,
      annotation: json['body'][0]['value'],
      contextId: int.parse(json['target']['id'].split('/').last),
      context: AnnotationContext.values.firstWhere(
          (element) => element.toString() == json['body'][0]['purpose']),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    // convert to json-ld format
    var annotationId = const Uuid().v4();
    annotationId = "${NetworkConstants.BASE_LOCAL_URL}/annotation/text/$annotationId";
    return {
      "context": "http://www.w3.org/ns/anno.jsonld",
      "id": annotationId,
      "type": "Annotation",
      "body": [
        {
          "id": annotationId,
          "type": "TextualBody",
          "value": annotation,
          "format": "text/plain",
          "language": "en",
          "purpose": context.toString(),
        },
      ],
      "target": {
        "id":
            "${NetworkConstants.BASE_LOCAL_URL}/${context.toString().split(".")[1]}/$contextId",
        "type": "Text",
        "format": "text/html",
        "language": "en",
        "selector": {
          "type": "TextPositionSelector",
          "start": startIndex,
          "end": endIndex,
        },
      },
      "creator": "${NetworkConstants.BASE_LOCAL_URL}/user/$authorUsername",
      "created": DateTime.now().toIso8601String(),
    };
  }
}

class ImageAnnotation extends BaseAnnotation {
  final double x;
  final double y;
  final double width;
  final double height;

  ImageAnnotation({
    required authorUsername,
    required annotation,
    required contextId,
    required context,
    required this.x,
    required this.y,
    required this.width,
    required this.height,
  }) : super(
          authorUsername: authorUsername,
          annotation: annotation,
          contextId: contextId,
          context: context,
        );

  factory ImageAnnotation.fromJson(Map<String, dynamic> json) {
    return ImageAnnotation(
      x: double.parse(json['target']['selector']['value'].split('=')[1].split(',')[0].split(':')[1]),
      y: double.parse(json['target']['selector']['value'].split('=')[1].split(',')[1]),
      width: double.parse(json['target']['selector']['value'].split('=')[1].split(',')[2]),
      height: double.parse(json['target']['selector']['value'].split('=')[1].split(',')[3]),
      authorUsername: json['creator'].split('/').last,
      annotation: json['body'][0]['value'],
      contextId: int.parse(json['target']['id'].split('/').last),
      context: AnnotationContext.values.firstWhere(
          (element) => element.toString() == json['body'][0]['purpose']),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    // convert to json-ld format
    var annotationId = const Uuid().v4();
    annotationId = "${NetworkConstants.BASE_LOCAL_URL}/annotation/image/$annotationId";
    return {
      "context": "http://www.w3.org/ns/anno.jsonld",
      "id": annotationId,
      "type": "Annotation",
      "body": [
        {
          "id": annotationId,
          "type": "TextualBody",
          "value": annotation,
          "format": "text/plain",
          "language": "en",
          "purpose": context.toString(),
        },
      ],
      "target": {
        "id":
            "${NetworkConstants.BASE_LOCAL_URL}/${context.toString().split(".")[1]}/$contextId",
        "type": "Image",
        "format": "image/jpeg",
        "language": "en",
        "selector": {
          "type": "FragmentSelector",
          "conformsTo": "http://www.w3.org/TR/media-frags/",
          "value": "xywh=pixel:$x,$y,$width,$height",
        },
      },
      "creator": "${NetworkConstants.BASE_LOCAL_URL}/user/$authorUsername",
      "created": DateTime.now().toIso8601String(),
    };
  }
}

class MultipleAnnotation {
  List<TextAnnotation> annotations;

  MultipleAnnotation({
    required this.annotations,
  });

  void addAnnotation(TextAnnotation annotation) {
    annotations.add(annotation);
  }

  int get startIndex => annotations.first.startIndex;
  int get endIndex => annotations.last.endIndex;

  bool get isEmpty => annotations.isEmpty;
}
