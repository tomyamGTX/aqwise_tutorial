import 'package:aqwise_stripe_payment/word.translation.module/surah.page.dart';
import 'package:flutter/material.dart';
import 'package:quran/quran.dart';

class SurahDisplay extends StatefulWidget {
  const SurahDisplay({
    super.key,
  });

  @override
  State<SurahDisplay> createState() => _SurahDisplayState();
}

class _SurahDisplayState extends State<SurahDisplay> {
  final List _sura = [];
  @override
  void initState() {
    getSurah();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Word Translation')),
        body: ListView.builder(
            itemCount: _sura.length,
            itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SurahPage(
                                  id: index + 1,
                                ))),
                    tileColor: Colors.primaries[0].shade200,
                    title: Text(_sura[index]),
                    trailing: const Icon(Icons.navigate_next),
                  ),
                )));
  }

  void getSurah() {
    for (int i = 0; i < 114; i++) {
      setState(() {
        _sura.add(getSurahName(i + 1));
      });
    }
  }
}
