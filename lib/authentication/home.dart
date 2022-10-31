import 'package:aqwise_stripe_payment/api/api.screen.dart';
import 'package:aqwise_stripe_payment/auth/login.dart';
import 'package:aqwise_stripe_payment/edit.module/edit.module.dart';
import 'package:aqwise_stripe_payment/email/email.js.dart';
import 'package:aqwise_stripe_payment/favourite_list/favourite.screen.dart';
import 'package:aqwise_stripe_payment/loop/loop.screen.dart';
import 'package:aqwise_stripe_payment/payment/payment.provider.dart';
import 'package:aqwise_stripe_payment/payment/payment.screen.dart';
import 'package:aqwise_stripe_payment/payment/payment.sheet.dart';
import 'package:aqwise_stripe_payment/toyyibpay.payment/toyyibpay.screen.dart';
import 'package:aqwise_stripe_payment/quiz/quiz.screen.dart';
import 'package:aqwise_stripe_payment/url_handler/url.screen.dart';
import 'package:aqwise_stripe_payment/widgets/constant.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
            spacing: 8,
            runSpacing: 8,
            children: <Widget>[
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ToyyibPayScreen()));
                  },
                  child: Text(
                    'ToyyibPay Payment',
                    style: buttonStyle,
                  )),
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
