import 'package:flutter/foundation.dart';

class Juz {
  String? id;
  String? aya;
  String? createdAt;
  String? endAya;
  String? endSuraId;
  String? quranTextId;
  String? suraId;
  String? updatedAt;
  Juz(
      {required this.aya,
      required this.createdAt,
      required this.endAya,
      required this.endSuraId,
      required this.id,
      required this.quranTextId,
      required this.suraId,
      required this.updatedAt});

  Juz.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    aya = json['aya'];
    createdAt = json['created_at'];
    endAya = json['end_aya'];
    endSuraId = json['end_sura_id'];
    quranTextId = json['quran_text_id'];
    suraId = json['sura_id'];
    updatedAt = json['updated_at'];
  }
}
