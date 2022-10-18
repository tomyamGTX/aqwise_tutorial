import 'package:aqwise_stripe_payment/edit.module/aya.number.provider.dart';
import 'package:aqwise_stripe_payment/favourite_list/favourite.provider.dart';
import 'package:aqwise_stripe_payment/favourite_list/favourite.screen.dart';
import 'package:aqwise_stripe_payment/payment/payment.provider.dart';
import 'package:aqwise_stripe_payment/payment/payment.screen.dart';
import 'package:aqwise_stripe_payment/payment/payment.sheet.dart';
import 'package:aqwise_stripe_payment/quiz/quiz.screen.dart';
import 'package:aqwise_stripe_payment/url_handler/url.screen.dart';
import 'package:aqwise_stripe_payment/widgets/constant.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';

import 'api/api.screen.dart';
import 'auth/login.dart';
import 'edit.module/edit.module.dart';
import 'email/email.js.dart';
import 'firebase_options.dart';
import 'loop/loop.screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (!kIsWeb) {
    Stripe.publishableKey = publishkey;
    await Stripe.instance.applySettings();
  }
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
        ChangeNotifierProvider<AyaProvider>(create: (context) => AyaProvider()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
            useMaterial3: true,
            primaryColor: kPrimaryColor,
            canvasColor: kSecondaryColor),
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
        backgroundColor: kPrimaryColor,
        appBar: AppBar(
          title: Text(
            widget.title,
            style: buttonStyle,
          ),
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
                  child: Text(
                    'Stripe Custom Payment',
                    style: buttonStyle,
                  )),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const PaymentSheet()));
                  },
                  child: Text(
                    'Stripe Payment Sheet',
                    style: buttonStyle,
                  )),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const EmailScreen()));
                  },
                  child: Text(
                    'Email Sender',
                    style: buttonStyle,
                  )),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const URLScreen()));
                  },
                  child: Text(
                    'URL Handler',
                    style: buttonStyle,
                  )),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const FavScreen()));
                  },
                  child: Text(
                    'Favourite List',
                    style: buttonStyle,
                  )),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoopScreen()));
                  },
                  child: Text(
                    'Loop test',
                    style: buttonStyle,
                  )),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const Login()));
                  },
                  child: Text(
                    'Login',
                    style: buttonStyle,
                  )),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const EditModule()));
                  },
                  child: Text(
                    'Edit Module',
                    style: buttonStyle,
                  )),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const APIScreen()));
                  },
                  child: Text(
                    'Get data from API',
                    style: buttonStyle,
                  )),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const QuizScreen()));
                  },
                  child: Text(
                    'Quiz Sound',
                    style: buttonStyle,
                  )),
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
