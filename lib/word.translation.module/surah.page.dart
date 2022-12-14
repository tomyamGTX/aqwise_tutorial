import 'package:aqwise_stripe_payment/word.translation.module/sura.relationship.model.dart';
import 'package:aqwise_stripe_payment/word.translation.module/surah.word.id.dart';
import 'package:flutter/material.dart';
import 'package:quran/quran.dart';

class SurahPage extends StatefulWidget {
  final int id;
  const SurahPage({super.key, required this.id});

  @override
  State<SurahPage> createState() => _SurahPageState();
}

class _SurahPageState extends State<SurahPage> {
  final List<SuraRelationshipModel> _sura = [];
  @override
  void initState() {
    getSurah();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:
            AppBar(title: Text('List of Page (${getSurahName(widget.id)})')),
        body: ListView.builder(
            itemCount: _sura.length,
            itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SurahWordId(
                                  suraReletionshipModel: _sura[index],
                                ))),
                    tileColor: Colors.primaries[1].shade200,
                    title: Text('Page ${_sura[index].medinaMushafPageId}'),
                    trailing: const Icon(Icons.navigate_next),
                  ),
                )));
  }

  void getSurah() {
    ///get data from collection sura_relationship based on sura id
    var suraId = widget.id;

    //example
    var data = {
      "id": "1",
      "created_at": "2014-11-19 14:46:49.174963",
      "medina_mushaf_page_id": "1",
      "sura_id": "$suraId",
      "updated_at": "2014-11-19 14:46:49.174963"
    };
    setState(() {
      _sura.add(SuraRelationshipModel.fromJson(data));
    });
  }
}
