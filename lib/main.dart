import 'package:aqwise_stripe_payment/favourite_list/favourite.provider.dart';
import 'package:aqwise_stripe_payment/favourite_list/favourite.screen.dart';
import 'package:aqwise_stripe_payment/payment/payment.provider.dart';
import 'package:aqwise_stripe_payment/payment/payment.screen.dart';
import 'package:aqwise_stripe_payment/url_handler/url.screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';

import 'auth/login.dart';
import 'email/email.js.dart';
import 'firebase_options.dart';
import 'loop/loop.screen.dart';

Future<void> main() async {
  await WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<FavouriteProvider>(
            create: (context) => FavouriteProvider()),
        ChangeNotifierProvider<PaymentProvider>(
            create: (context) => PaymentProvider()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MyHomePage(title: 'AQ Wise Tutorial'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void _incrementCounter() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PaymentProvider>(builder: (context, pay, _) {
      return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          actions: [
            Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  pay.role,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            )
          ],
        ),
        body: Center(
          child: Wrap(
            alignment: WrapAlignment.spaceAround,
            spacing: 8,
            children: <Widget>[
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const PaymentScreen()));
                  },
                  child: const Text('Stripe Payment')),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const EmailScreen()));
                  },
                  child: const Text('Email Sender')),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const URLScreen()));
                  },
                  child: const Text('URL Handler')),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const FavScreen()));
                  },
                  child: const Text('Favourite List')),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoopScreen()));
                  },
                  child: const Text('Loop test')),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const Login()));
                  },
                  child: const Text('Login')),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _incrementCounter,
          tooltip: 'Increment',
          child: const Icon(Icons.add),
        ), // This trailing comma makes auto-formatting nicer for build methods.
      );
    });
  }
}
