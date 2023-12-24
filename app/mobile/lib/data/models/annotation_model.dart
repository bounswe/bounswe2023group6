class Annotation {
  final int startIndex;
  final int endIndex;
  final String authorUsername;
  final String annotation;

  Annotation({
    required this.startIndex,
    required this.endIndex,
    required this.authorUsername,
    required this.annotation,
  });

  factory Annotation.fromJson(Map<String, dynamic> json) {
    // convert from json-ld format
    return Annotation(
      startIndex: json['target']['selector']['start'],
      endIndex: json['target']['selector']['end'],
      authorUsername: json['creator']['name'],
      annotation: json['body']['value'],
    );
  }

  Map<String, dynamic> toJson() {
    // convert to json-ld format
    return {
      "@context": "http://www.w3.org/ns/anno.jsonld",
      "id": "http://example.org/anno1",
      "type": "Annotation",
      "body": {
        "type": "TextualBody",
        "value": annotation,
        "format": "text/plain",
      },
      "target": {
        "id": "http://example.org/page1",
        "type": "Text",
        "selector": {
          "type": "TextPositionSelector",
          "start": startIndex,
          "end": endIndex,
        },
      },
      "creator": {
        "id": "http://example.org/user1",
        "type": "Person",
        "name": authorUsername,
      },
    };
  }
}

class ImageAnnotation {
  final double x;
  final double y;
  final double width;
  final double height;
  final String authorUsername;
  final String annotation;

  ImageAnnotation({
    required this.x,
    required this.y,
    required this.width,
    required this.height,
    required this.authorUsername,
    required this.annotation,
  });

  factory ImageAnnotation.fromJson(Map<String, dynamic> json) {
    return ImageAnnotation(
      x: json['target']['selector']['value'].split('=')[1].split(',')[0],
      y: json['target']['selector']['value'].split('=')[1].split(',')[1],
      width: json['target']['selector']['value'].split('=')[1].split(',')[2],
      height: json['target']['selector']['value'].split('=')[1].split(',')[3],
      authorUsername: json['creator']['name'],
      annotation: json['body']['value'],
    );
  }

  Map<String, dynamic> toJson() {
    // convert to json-ld format
    return {
      "@context": "http://www.w3.org/ns/anno.jsonld",
      "id": "http://example.org/anno1",
      "type": "Annotation",
      "body": {
        "type": "TextualBody",
        "value": annotation,
        "format": "text/plain",
      },
      "target": {
        "id": "http://example.org/page1",
        "type": "Image",
        "selector": {
          "type": "FragmentSelector",
          "value": "xywh=$x,$y,$width,$height",
        },
      },
      "creator": {
        "id": "http://example.org/user1",
        "type": "Person",
        "name": authorUsername,
      },
    };
  }
}

class MultipleAnnotation {
  List<Annotation> annotations;

  MultipleAnnotation({
    required this.annotations,
  });

  void addAnnotation(Annotation annotation) {
    annotations.add(annotation);
  }

  int get startIndex => annotations.first.startIndex;
  int get endIndex => annotations.last.endIndex;

  bool get isEmpty => annotations.isEmpty;
}
