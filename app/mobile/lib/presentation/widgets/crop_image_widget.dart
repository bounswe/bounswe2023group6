import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'dart:ui' as ui;

class CropImageWidget extends CustomPainter {
  final ui.Image image;
  final Rect cropRect;
  CropImageWidget({required this.image, required this.cropRect});
  
  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawAtlas(
        image,
        [
          /* Identity transform */
          RSTransform.fromComponents(
              rotation: 0.0,
              scale: 1.0,
              anchorX: 0.0,
              anchorY: 0.0,
              translateX: 0.0,
              translateY: 0.0)
        ],
        [
            Rect.fromLTWH(cropRect.left, cropRect.top, cropRect.width, cropRect.height)
        ],
        [/* No need for colors */],
        BlendMode.src,
        null /* No need for cullRect */,
        Paint());
  }

  @override
  bool shouldRepaint(CropImageWidget oldDelegate) => false;
  @override
  bool shouldRebuildSemantics(CropImageWidget oldDelegate) => false;
}