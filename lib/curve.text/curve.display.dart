import 'package:flutter/material.dart';
import 'package:flutter_arc_text/flutter_arc_text.dart';

class CurveDisplay extends StatefulWidget {
  const CurveDisplay({Key? key}) : super(key: key);

  @override
  State<CurveDisplay> createState() => _CurveDisplayState();
}

class _CurveDisplayState extends State<CurveDisplay> {
  //install plugin
  // flutter_arc_text: ^0.5.0

  String subtitle = "Nilai, Patriotisme, Iktibar, Jom Belajar!";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ArcText(
            radius: 210,
            text: subtitle,
            textStyle: const TextStyle(fontSize: 18, color: Colors.black),
            startAngle: 2.37,
            startAngleAlignment: StartAngleAlignment.end,
            placement: Placement.outside,
            direction: Direction.counterClockwise),
      ),
    );
  }
}
