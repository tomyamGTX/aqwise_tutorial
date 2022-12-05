import 'package:aqwise_stripe_payment/juzuk/juz.container.dart';
import 'package:aqwise_stripe_payment/juzuk/juz.model.dart';
import 'package:aqwise_stripe_payment/juzuk/juz.provider.dart';
import 'package:aqwise_stripe_payment/theme/theme.provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class JuzDisplay extends StatefulWidget {
  const JuzDisplay({super.key});

  @override
  State<JuzDisplay> createState() => _JuzDisplayState();
}

class _JuzDisplayState extends State<JuzDisplay> {
  List juzFromDb = [
    {
      "aya": '1',
      "created_at": '2014-03-28 06:25:59.477459',
      "end_aya": '141',
      "end_sura_id": '2',
      "id": '1',
      "quran_text_id": '1',
      "sura_id": '1',
      "updated_at": '2014-03-28 06:28:51.40008'
    },
    {
      "aya": '142',
      "created_at": '2014-03-28 06:25:59.477459',
      "end_aya": '252',
      "end_sura_id": '2',
      "id": '2',
      "quran_text_id": '149',
      "sura_id": '2',
      "updated_at": '2014-03-28 06:28:51.40008'
    },
    {
      "aya": '253',
      "created_at": '2014-03-28 06:25:59.483082',
      "end_aya": '92',
      "end_sura_id": '3',
      "id": '3',
      "quran_text_id": '260',
      "sura_id": '2',
      "updated_at": '2014-03-28 06:28:51.40008'
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<JuzProvider>(builder: (context, juz, _) {
      final themeProvider = Provider.of<ThemeProvider>(context);
      return Scaffold(
          body: ListView.builder(
              itemCount: juzFromDb.length,
              itemBuilder: (context, index) => JuzContainer(
                  juzuk: Juz.fromJson(juzFromDb[index]),
                  themeProvider: themeProvider)));
    });
  }
}
