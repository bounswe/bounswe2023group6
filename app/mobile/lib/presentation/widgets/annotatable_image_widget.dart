import 'dart:async';
import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:mobile/data/models/annotation_model.dart';
import 'package:mobile/data/services/annotation_service.dart';
import 'package:mobile/presentation/widgets/crop_image_widget.dart';
import 'package:mobile/utils/cache_manager.dart';

class AnnotatableImageWidget extends StatelessWidget {
  final AnnotationService annotationService = AnnotationService();

  final String imageUrl;
  final int contentId;
  final AnnotationContext contentContext;

  AnnotatableImageWidget({
    Key? key,
    required this.imageUrl,
    required this.contentId,
    required this.contentContext,
  }) : super(key: key);

  final annotationTextController = TextEditingController();

  final double imageWidth = 200;
  final double imageHeight = 200;

  Future<List<ImageAnnotation>> loadAnnotations() async {
    List<ImageAnnotation> annotations = await annotationService
        .getAnnotationsByTargetId(contentContext, contentId)
        .then((value) => value.whereType<ImageAnnotation>().toList());
    return annotations;
  }

  Future<ui.Image> getImageAsUi(NetworkImage image) async {
    var completer = Completer<ImageInfo>();
    image
        .resolve(const ImageConfiguration())
        .addListener(ImageStreamListener((info, _) {
      completer.complete(info);
    }));
    ImageInfo imageInfo = await completer.future;
    return imageInfo.image;
  }

  Offset convertPointToImageCoordinates(Offset point, ui.Image image) {
    final widthRatio = image.width / imageWidth;
    final heightRatio = image.height / imageHeight;

    return Offset(
      point.dx * widthRatio,
      point.dy * heightRatio,
    );
  }

  @override
  Widget build(BuildContext context) {
    NetworkImage image = NetworkImage(imageUrl);

    return FutureBuilder<List<Object>>(
      future: Future.wait([
        getImageAsUi(image),
        loadAnnotations(),
      ]),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            if (snapshot.hasError) {
              return const Center(
                child: Text("Error"),
              );
            }
            ui.Image uiImage = snapshot.data![0] as ui.Image;
            List<ImageAnnotation> annotations =
                snapshot.data![1] as List<ImageAnnotation>;
            return buildImageWithGestures(
              context,
              Column(
                children: [
                  Container(
                    height: imageHeight,
                    width: imageWidth,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                      image: image,
                      fit: BoxFit.fill,
                    )),
                  ),
                  annotations.isEmpty
                      ? const Text(
                          "No annotations",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      : TextButton(
                          onPressed: () {
                            showAnnotationsForImage(
                                context, uiImage, annotations);
                          },
                          child: const Text(
                            "Show Annotations",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                ],
              ),
              uiImage,
            );
          default:
            return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  void showAnnotationsForImage(
      BuildContext context, ui.Image image, List<ImageAnnotation> annotations) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Annotations for this image"),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (final annotation in annotations)
              Column(
                children: [
                  CustomPaint(
                    painter: CropImageWidget(
                      image: image,
                      cropRect: Rect.fromLTWH(
                        annotation.x,
                        annotation.y,
                        annotation.width,
                        annotation.height,
                      ),
                      scale: 80 / min(annotation.width, annotation.height),
                    ),
                    child: SizedBox(
                      width: min(annotation.width, 100),
                      height: min(annotation.height, 100),
                    ),
                  ),
                  Text(annotation.annotation),
                  Text(annotation.authorUsername),
                ],
              ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Close"),
          ),
        ],
      ),
    );
  }

  Widget buildImageWithGestures(
      BuildContext context, Widget imageWidget, ui.Image image) {
    Offset localOffset = Offset.zero;
    Offset topLeft = localOffset;
    final bottomRight = ValueNotifier<Offset>(Offset.zero);

    return GestureDetector(
      child: Stack(
        children: [
          imageWidget,
          ValueListenableBuilder(
            valueListenable: bottomRight,
            builder: (context, bottomRight, child) => bottomRight == Offset.zero
                ? Container()
                : Positioned(
                    left: min(topLeft.dx, bottomRight.dx),
                    top: min(topLeft.dy, bottomRight.dy),
                    child: Container(
                      width: (bottomRight.dx - topLeft.dx).abs(),
                      height: (bottomRight.dy - topLeft.dy).abs(),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black87,
                          width: 1,
                        ),
                      ),
                    ),
                  ),
          )
        ],
      ),
      onLongPressStart: (details) {
        localOffset = details.localPosition;
        topLeft = localOffset;
        bottomRight.value = localOffset;
      },
      onLongPressMoveUpdate: (details) {
        localOffset = details.localPosition;
        bottomRight.value = localOffset;
      },
      onLongPressEnd: (details) {
        topLeft = convertPointToImageCoordinates(topLeft, image);
        Offset bottomRightOffset =
            convertPointToImageCoordinates(bottomRight.value, image);
        double width = (bottomRightOffset.dx - topLeft.dx).abs();
        double height = (bottomRightOffset.dy - topLeft.dy).abs();
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("Make an annotation"),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomPaint(
                  painter: CropImageWidget(
                    image: image,
                    cropRect: Rect.fromPoints(
                      topLeft,
                      bottomRightOffset,
                    ),
                    scale: 80 / min(width, height),
                  ),
                  child: SizedBox(
                    width: min(width, 100),
                    height: min(height, 100),
                  ),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  key: GlobalObjectKey(UniqueKey()),
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
              ],
            ),
            actions: [
              TextButton(
                onPressed: () async {
                  ImageAnnotation imageAnnotation = ImageAnnotation(
                    x: topLeft.dx,
                    y: topLeft.dy,
                    width: width,
                    height: height,
                    authorUsername: CacheManager().getUser().username,
                    annotation: annotationTextController.text,
                    contextId: contentId,
                    context: contentContext,
                  );
                  await annotationService.createAnnotation(imageAnnotation);
                  Navigator.of(context).pop("Annotation saved");
                },
                child: const Text("Save Annotation"),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Cancel"),
              ),
            ],
          ),
        ).then((value) {
          bottomRight.value = Offset.zero;
          if (value != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(value.toString()),
              ),
            );
          }
        });
      },
    );
  }
}
