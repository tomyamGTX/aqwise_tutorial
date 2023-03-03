
import 'package:flutter/material.dart';

class MapPin extends CustomPainter {
  Color color;
  String text;
  MapPin(this.color, this.text);
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = color
      ..strokeWidth = 5
      ..style = PaintingStyle.fill
      ..strokeCap = StrokeCap.round;
    var paint2 = Paint()
      ..color = Colors.white
      ..strokeWidth = 5
      ..style = PaintingStyle.fill
      ..strokeCap = StrokeCap.round;
    var path1 = Path();
    var height = 30;
    var width = 8.0;
    path1.moveTo(size.width / 2 - width, size.height / 2);
    path1.lineTo(size.width / 2, size.height / 2 + height);
    path1.lineTo(size.width / 2 + width, size.height / 2);
    canvas.drawPath(path1, paint);
    canvas.drawCircle(
        Offset((size.width * 0.5), (size.height * .5)), 12, paint);
    canvas.drawCircle(
        Offset((size.width * 0.5), (size.height * .5)), 10, paint2);
    const textStyle = TextStyle(
      color: Colors.black,
    );
    var textSpan = TextSpan(
      text: text,
      style: textStyle,
    );
    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
    );
    textPainter.layout(
      minWidth: 0,
      maxWidth: size.width,
    );
    final xCenter = (size.width - textPainter.width) / 2;
    final yCenter = (size.height - textPainter.height) / 2;
    final offset = Offset(xCenter, yCenter);
    textPainter.paint(canvas, offset);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
