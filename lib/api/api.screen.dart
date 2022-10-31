import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class APIScreen extends StatefulWidget {
  const APIScreen({Key? key}) : super(key: key);

  @override
  State<APIScreen> createState() => _APIScreenState();
}

class _APIScreenState extends State<APIScreen> {
  dynamic dataMain;
  Future<void> getPsts() async {
    var url = Uri.parse(
        'https://stage.tsbdev.co/api/v1/content?clientContentId=Client-Story-Id-1&clientId=5f92a62013332e0f667794dc');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      setState(() {});
      dataMain = jsonDecode(response.body);
      if (kDebugMode) {
        print("dataMain");
        print(dataMain);
        print("dataMain");
      }
    } else {
      throw Exception('Failed to load album');
    }
  }

  bool visible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Get data from API'),
        ),
        body: Center(
          child: Column(
            children: [
              Visibility(
                  visible: !visible,
                  child: const Padding(
                    padding: EdgeInsets.all(80.0),
                    child: Text('No data from API'),
                  )),
              Visibility(
                visible: dataMain == null
                    ? false
                    : dataMain["validPass"] == null
                        ? false
                        : true,
                child: ListTile(
                  title: Text(dataMain != null && dataMain["validPass"] == null
                      ? 'Data NotFrom Valid Pass'
                      : 'Data From Valid Pass'),
                  tileColor: Colors.amber,
                  subtitle: Text(
                    dataMain == null
                        ? ""
                        : "${dataMain["validPass"] == null ? 'No hrs' : dataMain["validPass"]['duration'] ?? 'No data'} - hrs unlimited access to premium content",
                  ),
                ),
              ),
              //todo:to indicate no validPass. you can remove this
              Visibility(
                visible: dataMain == null
                    ? false
                    : dataMain["validPass"] == null
                        ? visible
                            ? true
                            : false
                        : false,
                child: ListTile(
                  title: Text(dataMain != null && dataMain["validPass"] == null
                      ? 'No data From Valid Pass'
                      : 'Data From Valid Pass'),
                  tileColor: Colors.amber,
                  subtitle: Text(
                    dataMain == null
                        ? ""
                        : "${dataMain["validPass"] == null ? '0' : dataMain["validPass"]['duration'] ?? 'No data'} - hrs unlimited access to premium content",
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: ElevatedButton(
                    onPressed: () async {
                      await getPsts();
                      setState(() {
                        visible = !visible;
                      });
                    },
                    child: const Text('Get/Hide API')),
              )
            ],
          ),
        ));
  }
}
