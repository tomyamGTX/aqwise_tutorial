import 'package:flutter/material.dart';

class SuraTranslation extends StatefulWidget {
  final int id;
  const SuraTranslation({super.key, required this.id});

  @override
  State<SuraTranslation> createState() => _SuraTranslationState();
}

class _SuraTranslationState extends State<SuraTranslation> {
  List translation = [];

  @override
  void initState() {
    getAlltranslationForWordID();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Translation for word ID ${widget.id}')),
        body: ListView.builder(
          itemCount: translation.length,
          itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              tileColor: Colors.amber,
              subtitle: Text(translation[index]['language_id'].toString()),
              title: Text('(${translation[index]['text']})'),
              trailing: IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {},
              ),
            ),
          ),
        ));
  }

  void getAlltranslationForWordID() {
    //fetch and parse json
    setState(() {});
    List data = [
      {
        "id": 270018,
        "text": "",
        "language_id": 5,
        "word_id": 6760,
        "active": false,
        "created_at": "2015-01-25 14:25:23.800709",
        "updated_at": "2015-01-25 14:25:23.800709"
      },
      {
        "id": 270017,
        "text": "",
        "language_id": 4,
        "word_id": 6760,
        "active": false,
        "created_at": "2015-01-25 14:25:23.787449",
        "updated_at": "2015-01-25 14:25:23.787449"
      },
      {
        "id": 270019,
        "text": "",
        "language_id": 6,
        "word_id": 6760,
        "active": false,
        "created_at": "2015-01-25 14:25:23.819767",
        "updated_at": "2015-01-25 14:25:23.819767"
      },
      {
        "id": 647415,
        "text": "",
        "language_id": 9,
        "word_id": 6760,
        "active": false,
        "created_at": "2017-04-13 02:54:07.786551",
        "updated_at": "2017-04-13 02:54:07.786551"
      },
      {
        "id": 647414,
        "text": "Alif Lam Mim",
        "language_id": 7,
        "word_id": 6760,
        "active": false,
        "created_at": "2017-04-13 02:54:07.638505",
        "updated_at": "2017-04-13 02:54:07.638505"
      },
      {
        "id": 1861,
        "text": "Aliff Laam Meem",
        "language_id": 2,
        "word_id": 6760,
        "active": false,
        "created_at": "2014-04-08 14:11:54.633506",
        "updated_at": "2014-04-08 14:11:54.633506"
      },
      {
        "id": 1862,
        "text": "Alif Lam Mim",
        "language_id": 3,
        "word_id": 6760,
        "active": false,
        "created_at": "2014-04-08 14:11:54.648794",
        "updated_at": "2014-04-08 14:11:54.648794"
      },
      {
        "id": 1863,
        "text": "ﺍﻟﻢ",
        "language_id": 1,
        "word_id": 6760,
        "active": false,
        "created_at": "2014-04-08 14:11:54.664582",
        "updated_at": "2014-04-08 14:11:54.664582"
      },
    ];
    data.sort((a, b) => a['language_id'].compareTo(b['language_id']));
    translation.addAll(data);
  }
}
