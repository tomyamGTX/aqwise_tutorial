import 'package:aqwise_stripe_payment/word.translation.module/slice.model.dart';
import 'package:aqwise_stripe_payment/word.translation.module/sura.relationship.model.dart';
import 'package:aqwise_stripe_payment/word.translation.module/sura.translation.dart';
import 'package:aqwise_stripe_payment/word.translation.module/translation.model.dart';
import 'package:flutter/material.dart';
import 'package:quran/quran.dart';

class SurahWordId extends StatefulWidget {
  final SuraRelationshipModel suraReletionshipModel;
  const SurahWordId({super.key, required this.suraReletionshipModel});

  @override
  State<SurahWordId> createState() => _SurahWordIdState();
}

class _SurahWordIdState extends State<SurahWordId> {
  List<SlicingData> _wordId = [];

  @override
  void initState() {
    getWordIdBasedOnSura();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text(
                'Word ID for Sura ${getSurahName(int.parse(widget.suraReletionshipModel.id!))} (${widget.suraReletionshipModel.medinaMushafPageId})')),
        body: ListView.builder(
            itemCount: _wordId.length,
            itemBuilder: (context, index) {
              var name = getName(_wordId[index].wordId);
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              SuraTranslation(id: _wordId[index].wordId!))),
                  tileColor: Colors.primaries[3].shade200,
                  trailing: const Icon(Icons.navigate_next),
                  title: Text(name),
                ),
              );
            }));
  }

  void getWordIdBasedOnSura() {
    //fetch slice data from collection medina mushaf page and filter by page
    // var page = widget.suraReletionshipModel.medinaMushafPageId!;

    ///example data for sura id 1 and medina mushaf page 1
    var data = [
      {"start": 1, "end": 4, "word_id": 6760},
      {"start": 7, "end": 12, "word_id": 4034},
      {"start": 15, "end": 23, "word_id": 4037},
      {"start": 26, "end": 28, "word_id": 4038},
      {"start": 30, "end": 34, "word_id": 4039},
      {"start": 38, "end": 40, "word_id": 4040},
      {"start": 41, "end": 41, "word_id": 4041},
      {"start": 45, "end": 49, "word_id": 4042},
      {"start": 51, "end": 51, "word_id": 178708},
      {"start": 54, "end": 63, "word_id": 178709},
      {"start": 66, "end": 72, "word_id": 4045},
      {"start": 75, "end": 84, "word_id": 77372},
      {"start": 87, "end": 87, "word_id": 4048},
      {"start": 89, "end": 96, "word_id": 4049},
      {"start": 99, "end": 99, "word_id": 4052},
      {"start": 101, "end": 109, "word_id": 77373},
      {"start": 112, "end": 120, "word_id": 4053},
      {"start": 123, "end": 123, "word_id": 4054},
      {"start": 125, "end": 125, "word_id": 4095},
      {"start": 127, "end": 129, "word_id": 4096},
      {"start": 131, "end": 135, "word_id": 178710},
      {"start": 137, "end": 139, "word_id": 178711},
      {"start": 140, "end": 142, "word_id": 4058},
      {"start": 145, "end": 153, "word_id": 77374},
      {"start": 156, "end": 156, "word_id": 4061},
      {"start": 158, "end": 164, "word_id": 4062},
      {"start": 167, "end": 176, "word_id": 77375},
      {"start": 179, "end": 179, "word_id": 4066},
      {"start": 181, "end": 183, "word_id": 4067},
      {"start": 185, "end": 190, "word_id": 4069},
      {"start": 193, "end": 197, "word_id": 4068},
      {"start": 199, "end": 199, "word_id": 4070},
      {"start": 202, "end": 202, "word_id": 4071},
      {"start": 204, "end": 206, "word_id": 4072},
      {"start": 208, "end": 213, "word_id": 4073},
      {"start": 216, "end": 218, "word_id": 4074},
      {"start": 220, "end": 224, "word_id": 4075},
      {"start": 226, "end": 226, "word_id": 4076},
      {"start": 229, "end": 229, "word_id": 4077},
      {"start": 231, "end": 231, "word_id": 4078},
      {"start": 233, "end": 241, "word_id": 4079},
      {"start": 244, "end": 246, "word_id": 4080},
      {"start": 249, "end": 257, "word_id": 77376},
      {"start": 260, "end": 269, "word_id": 4083},
      {"start": 272, "end": 276, "word_id": 4084},
      {"start": 279, "end": 283, "word_id": 4085},
      {"start": 285, "end": 288, "word_id": 4086},
      {"start": 290, "end": 292, "word_id": 4087},
      {"start": 295, "end": 297, "word_id": 4088},
      {"start": 301, "end": 301, "word_id": 4089},
      {"start": 303, "end": 312, "word_id": 4090},
      {"start": 315, "end": 317, "word_id": 4091},
      {"start": 320, "end": 332, "word_id": 4092}
    ];
    List<SlicingData> list = data.map((e) => SlicingData.fromJson(e)).toList();
    setState(() {
      _wordId = list;
    });
  }

  getName(int? wordId) {
    //readJson
    var dataFromJson = {
      {
        "id": 1863,
        "text": "ﺍﻟﻢ",
        "language_id": 1,
        "word_id": 6760,
        "active": false,
        "created_at": "2014-04-08 14:11:54.664582",
        "updated_at": "2014-04-08 14:11:54.664582"
      },
      {
        "id": 1870,
        "text": "ﺫﻟﻚ",
        "language_id": 1,
        "word_id": 4034,
        "active": false,
        "created_at": "2014-04-08 14:37:59.236874",
        "updated_at": "2014-04-08 14:37:59.236874"
      },
    };
    var data = dataFromJson.map((e) => TranslationModel(
          id: e['id'] as int,
          languageId: e['language_id'] as int,
          text: e['text'] as String,
          wordId: e['word_id'] as int,
        ));

    var name = data.where(
        (element) => element.wordId == wordId && element.languageId == 1);

    return name.isNotEmpty ? name.first.text : 'Text for $wordId';
  }
}
