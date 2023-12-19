import 'dart:typed_data';

import 'package:flutter/material.dart';

class DisplayAvatar extends StatelessWidget {
  final ByteData? byteData;
  final VoidCallback? onPressed;
  final int size;
  final String? imageLink;

  const DisplayAvatar(
      {super.key,
      this.byteData,
      this.imageLink,
      this.onPressed,
      this.size = 75});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).primaryColor;

    return Center(
        child: Stack(children: [
      buildImage(color),
      onPressed != null
          ? Positioned(right: 4, top: 10, child: buildEditIcon(color, onPressed!))
          : const SizedBox.shrink()
    ]));
  }

  Widget buildImage(Color color) {
    return CircleAvatar(
      radius: size.toDouble(),
      child: CircleAvatar(
        radius: size.toDouble(),
        child: byteData == null
            ? (imageLink == null || imageLink!.isEmpty)
                ? Icon(
                    Icons.account_circle,
                    color: color,
                    size: 130,
                  )
                : ClipRRect(
                    borderRadius: BorderRadius.circular(120),
                    child: Image.network(
                      imageLink!,
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }                      
                    ))
            : ClipRRect(
                borderRadius: BorderRadius.circular(120),
                child: Image.memory(
                  byteData!.buffer.asUint8List(),
                  fit: BoxFit.cover,
                ),
              ),
      ),
    );
  }

  // Builds Edit Icon on Profile Picture
  Widget buildEditIcon(Color color, VoidCallback onPressed) => ClipOval(
      child: Container(
          padding: const EdgeInsets.all(1),
          color: Colors.white,
          child: IconButton(
            icon: Icon(
              Icons.edit,
              color: color,
              size: 20,
            ),
            onPressed: onPressed,
          )));
}
