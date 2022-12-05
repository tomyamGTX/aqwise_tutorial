import 'package:flutter/cupertino.dart';
import 'package:quran/quran.dart';

import 'juz.model.dart';

class JuzProvider extends ChangeNotifier {
  // factory JuzProvider() => JuzProvider._();
  // JuzProvider._() {}

  Future<List<String>> getRange(Juz juz) async {
    var startSura = int.parse(juz.suraId!);
    var endSura = int.parse(juz.endSuraId!);
    var difference = endSura - startSura;
    if (difference == 0) {
      return ['${juz.aya} - ${juz.endAya}'];
    } else {
      List<String> data = [];
      for (int i = 0; i <= difference; i++) {
        var list = getSurahAndVersesFromJuz(int.parse(juz.id!));
        list.entries.forEach((element) {
          data.add('${element.value[0]} - ${element.value[1]}');
        });
      }

      return data;
    }
  }

  int getTotalSuraUnderJuz(Juz juz) {
    var startSura = int.parse(juz.suraId!);
    var endSura = int.parse(juz.endSuraId!);
    var difference = endSura - startSura;
    return difference;
  }
}
