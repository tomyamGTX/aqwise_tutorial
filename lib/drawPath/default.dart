import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

Future<BitmapDescriptor> circleCanvasWithText({
  required Size size,
  required String text,
  double fontSize = 15.0,
  Color circleColor = Colors.red,
  Color fontColor = Colors.black,
  FontWeight fontWeight = FontWeight.w500,
}) async {
  final PictureRecorder pictureRecorder = PictureRecorder();
  final Canvas canvas = Canvas(pictureRecorder);
  final Paint paint = Paint()..color = circleColor;
  Path path = Path(); path.moveTo(0, size.height / 2);
    path.lineTo(size.width, size.height / 2);
  canvas.drawPath(path, paint);

  TextPainter painter = TextPainter(textDirection: TextDirection.ltr);
  painter.text = TextSpan(
    text: text,
    style:
        TextStyle(fontSize: fontSize, color: fontColor, fontWeight: fontWeight),
  );

  painter.layout();
  painter.paint(
      canvas,
      Offset((size.width * 0.5) - painter.width * 0.5,
          (size.height * .5) - painter.height * 0.5));

  final img = await pictureRecorder
      .endRecording()
      .toImage(size.width.toInt(), size.height.toInt());
  final data = await img.toByteData(format: ImageByteFormat.png);

  return BitmapDescriptor.fromBytes(data!.buffer.asUint8List());
}
