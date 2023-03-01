import 'package:aqwise_stripe_payment/readFirebase/sample.model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ReadFromFirebase extends StatefulWidget {
  const ReadFromFirebase({super.key});

  @override
  State<ReadFromFirebase> createState() => _ReadFromFirebaseState();
}

class _ReadFromFirebaseState extends State<ReadFromFirebase> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        ///use stream to fetch data
        child: StreamBuilder<List<SampleModel>>(
            stream: getFirebaseData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState.name == 'waiting') {
                return const CircularProgressIndicator();
              }
              if (snapshot.hasError) {
                ///handle error
                return const Text('Error');
              } else if (!snapshot.hasData) {
                ///handle for empty value
                return const Text('No data');
              } else {
                ///display data on UI
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      margin: const EdgeInsets.all(8),
                      child: ListTile(
                        title: Text(snapshot.data![index].name!),
                      ),
                    );
                  },
                );
              }
            }),
      ),
    );
  }

  Stream<List<SampleModel>>? getFirebaseData() async* {
    debugPrint('fecthing data...');

    ///collection name
    var name = 'sample';

    List<SampleModel>? model;

    ///try catch to check any error during fetch
    try {
      ///get data from firebase
      var data = await FirebaseFirestore.instance.collection(name).get();

      ///convert json to model
      model = data.docs.map((e) => SampleModel.fromJson(e.data())).toList();
    } catch (e) {
      debugPrint(e.toString());
    }

    yield model!;
  }
}
