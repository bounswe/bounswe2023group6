import 'dart:typed_data';

import 'package:flutter/material.dart';

class DisplayAvatar extends StatelessWidget {
  final ByteData? byteData;
  final VoidCallback onPressed;
  final int size;

  const DisplayAvatar({super.key, required this.byteData, required this.onPressed, this.size = 75});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).primaryColor;

    return Center(
        child: Stack(children: [
      buildImage(color),
      Positioned(right: 4, top: 10, child: buildEditIcon(color)),
    ]));
  }

  Widget buildImage(Color color) {
    return CircleAvatar(
      radius: size.toDouble(),
      child: CircleAvatar(
        radius: size.toDouble() - 5,
        child: byteData == null
            ? Icon(
                Icons.account_circle,
                color: color,
                size: 130,
              )
            : 
            ClipOval(
              child: Image.memory(
                byteData!.buffer.asUint8List(),
                fit: BoxFit.cover,
              ),
            ),
      ),
    );
  }

  // Builds Edit Icon on Profile Picture
  Widget buildEditIcon(Color color) => ClipOval(
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
        )
      ));
}
