
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
    return Annotation(
      startIndex: json['startIndex'],
      endIndex: json['endIndex'],
      authorUsername: json['authorUsername'],
      annotation: json['annotation'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'startIndex': startIndex,
      'endIndex': endIndex,
      'authorUsername': authorUsername,
      'annotation': annotation,
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