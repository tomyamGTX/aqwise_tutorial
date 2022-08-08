import 'package:flutter/material.dart';

class LoopScreen extends StatefulWidget {
  const LoopScreen({Key? key}) : super(key: key);

  @override
  State<LoopScreen> createState() => _LoopScreenState();
}

class _LoopScreenState extends State<LoopScreen> {
  List sura = [];
  List tafsir = [];
  @override
  void initState() {
    // TODO: implement initState
    getTafsir();
    getInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (int i = 0; i < sura.length; i++) Text(sura[i]),
            for (int i = 0; i < sura.length; i++) Text(sura[i]),
          ],
        ),
      ),
    );
  }

  void getTafsir() {
    setState(() {
      sura = [
        'sura a',
        'sura b',
      ];
    });
  }

  void getInfo() {
    for (var element in sura) {}
  }
}

void getTafsirs() {}
