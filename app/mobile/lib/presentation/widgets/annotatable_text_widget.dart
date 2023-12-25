import 'dart:math';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:mobile/data/models/annotation_model.dart';
import 'package:mobile/data/services/annotation_service.dart';
import 'package:mobile/utils/cache_manager.dart';

class AnnotatableTextWidget extends StatelessWidget {
  final AnnotationService annotationService = AnnotationService();

  final String text;
  final int contentId;
  final AnnotationContext contentContext;

  final annotationTextController = TextEditingController();

  AnnotatableTextWidget(
      {Key? key,
      required this.text,
      required this.contentId,
      required this.contentContext})
      : super(key: key);

  Future<List<TextAnnotation>> loadAnnotations() async {
    List<TextAnnotation> annotations = await annotationService
        .getAnnotationsByTargetId(contentContext, contentId)
        .then((value) => value.whereType<TextAnnotation>().toList());
    return annotations;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: loadTextWithAnnotations(context),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return const Center(
              child: CircularProgressIndicator(),
            );
          case ConnectionState.done:
            if (snapshot.hasError) {
              return const Center(
                child: Text("Error"),
              );
            } else {
              return SelectableText.rich(
                snapshot.data as TextSpan,
                textAlign: TextAlign.justify,
                contextMenuBuilder: (context, state) =>
                    getSelectionControls(context, state),
              );
            }
          default:
            return const Center(
              child: CircularProgressIndicator(),
            );
        }
      },
    );
  }

  Future<List<MultipleAnnotation>> loadAndMergeAnnotations() async {
    List<TextAnnotation> annotations = await loadAnnotations();
    annotations.sort((a, b) => a.startIndex.compareTo(b.startIndex));
    List<MultipleAnnotation> mergedAnnotations = [];
    int currentIndex = 0;
    for (final annotation in annotations) {
      if (annotation.startIndex >= currentIndex) {
        mergedAnnotations.add(
          MultipleAnnotation(
            annotations: [],
          ),
        );
      }
      mergedAnnotations.last.addAnnotation(annotation);
      currentIndex = annotation.endIndex;
    }

    return mergedAnnotations;
  }

  Future<TextSpan> loadTextWithAnnotations(BuildContext context) async {
    List<MultipleAnnotation> annotations = await loadAndMergeAnnotations();

    final textSpans = <TextSpan>[];
    int currentIndex = 0;
    for (final annotation in annotations) {
      textSpans.add(
        TextSpan(
          text: text.substring(currentIndex, annotation.startIndex),
        ),
      );
      textSpans.add(
        TextSpan(
          text: text.substring(annotation.startIndex, annotation.endIndex),
          style: const TextStyle(
            // TODO: maybe add color later
            // backgroundColor: Colors.yellow,
            decoration: TextDecoration.underline,
          ),
          recognizer: TapGestureRecognizer()
            ..onTap = () => showAnnotationDialog(context, annotation),
        ),
      );
      currentIndex = annotation.endIndex;
    }
    textSpans.add(
      TextSpan(
        text: text.substring(currentIndex),
      ),
    );
    return TextSpan(
      children: textSpans,
      style: const TextStyle(fontSize: 16),
    );
  }

  Future<dynamic> showAnnotationDialog(
      BuildContext context, MultipleAnnotation mergedAnnotations) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (TextAnnotation annotation in mergedAnnotations.annotations)
              showAnnotation(annotation)
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Close"),
          ),
          // TODO: get current user and do the followings
          // currentUser.username == annotation.authorUsername
          // ? TextButton(
          //     onPressed: () {

          //     },
          //     child: const Text("Edit"),
          //   ) : Container(),
          // currentUser.username == annotation.authorUsername
          // ? TextButton(
          //     onPressed: () {

          //     },
          //     child: const Text("Delete"),
          //   ) : Container(),
        ],
      ),
    );
  }

  Widget showAnnotation(TextAnnotation annotation) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text.rich(
            TextSpan(
              children: <TextSpan>[
                const TextSpan(text: "Annotated by "),
                TextSpan(
                  text: annotation.authorUsername,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          const Text("Annotated text: "),
          Text(text.substring(annotation.startIndex, annotation.endIndex)),
          const SizedBox(height: 8),
          const Text("Annotation: "),
          Text(
            annotation.annotation,
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  AdaptiveTextSelectionToolbar getSelectionControls(
      BuildContext context, EditableTextState state) {
    return AdaptiveTextSelectionToolbar.buttonItems(
      anchors: state.contextMenuAnchors,
      buttonItems: [
        ContextMenuButtonItem(
          type: ContextMenuButtonType.copy,
          onPressed: () => state.copySelection(SelectionChangedCause.toolbar),
        ),
        ContextMenuButtonItem(
          type: ContextMenuButtonType.selectAll,
          onPressed: () => state.selectAll(SelectionChangedCause.toolbar),
        ),
        ContextMenuButtonItem(
          type: ContextMenuButtonType.custom,
          label: "Annotate",
          onPressed: () => showDialog(
            context: context,
            builder: (context) => createAnnotationDialog(
              context,
              state.textEditingValue.selection.start,
              state.textEditingValue.selection.end,
              state.textEditingValue.text.substring(
                state.textEditingValue.selection.start,
                state.textEditingValue.selection.end,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget createAnnotationDialog(BuildContext context, int startIndex,
      int endIndex, String highlightedText) {
    return AlertDialog(
      title: const Text("Make an annotation"),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      content: TextFormField(
        controller: annotationTextController,
        keyboardType: TextInputType.multiline,
        maxLength: 500,
        decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: "Enter your annotation here"),
        maxLines: 8,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Please enter an annotation";
          }
          return null;
        },
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Cancel"),
        ),
        TextButton(
          onPressed: () async {
            TextAnnotation annotation = TextAnnotation(
              startIndex: startIndex,
              endIndex: endIndex,
              authorUsername: CacheManager().getUser().username,
              annotation: annotationTextController.text,
              contextId: contentId,
              context: contentContext,
            );
            await annotationService.createAnnotation(annotation);
            Navigator.of(context).pop("Annotation saved");
          },
          child: const Text("Submit"),
        ),
      ],
    );
  }
}
