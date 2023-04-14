import 'package:aqwise_stripe_payment/api/api.screen.dart';
import 'package:aqwise_stripe_payment/auth/login.dart';
import 'package:aqwise_stripe_payment/curve.text/curve.display.dart';
import 'package:aqwise_stripe_payment/delete_account/delete_account.dart';
import 'package:aqwise_stripe_payment/drawPath/map.dart';
import 'package:aqwise_stripe_payment/edit.module/edit.module.dart';
import 'package:aqwise_stripe_payment/email/email.js.dart';
import 'package:aqwise_stripe_payment/favourite_list/favourite.screen.dart';
import 'package:aqwise_stripe_payment/juzuk/juz.display.dart';
import 'package:aqwise_stripe_payment/loop/loop.screen.dart';
import 'package:aqwise_stripe_payment/notifications/firebase.messaging.dart';
import 'package:aqwise_stripe_payment/payment/payment.provider.dart';
import 'package:aqwise_stripe_payment/payment/payment.screen.dart';
import 'package:aqwise_stripe_payment/payment/payment.sheet.dart';
import 'package:aqwise_stripe_payment/quiz/quiz.screen.dart';
import 'package:aqwise_stripe_payment/readFirebase/read.dart';
import 'package:aqwise_stripe_payment/share_app/index.dart';
import 'package:aqwise_stripe_payment/toyyibpay.payment/toyyibpay.screen.dart';
import 'package:aqwise_stripe_payment/url_handler/url.screen.dart';
import 'package:aqwise_stripe_payment/widgets/constant.dart';
import 'package:aqwise_stripe_payment/word.translation.module/sura.display.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'check_internet/check_network.dart';
import 'check_internet/internet_provider.dart';
import 'check_internet/no_internet.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<PaymentProvider>(builder: (context, pay, _) {
      return Scaffold(
        backgroundColor: kPrimaryColor,
        appBar: AppBar(
          automaticallyImplyLeading: false,
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
          ///need to apply to all screen that require internet connection
          child: Consumer<InternetProvider>(builder: (context, conn, _) {
            ///checking every second
            conn.checkConnection();

            ///on true display content, on false display no internet UI
            return conn.isDeviceConnected || kIsWeb
                ? Center(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: <Widget>[
                          ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const ToyyibPayScreen()));
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
                                        builder: (context) =>
                                            const PaymentScreen()));
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
                                        builder: (context) =>
                                            const PaymentSheet()));
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
                                        builder: (context) =>
                                            const EmailScreen()));
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
                                        builder: (context) =>
                                            const URLScreen()));
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
                                        builder: (context) =>
                                            const FavScreen()));
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
                                        builder: (context) =>
                                            const LoopScreen()));
                              },
                              child: Text(
                                'Loop test',
                                style: buttonStyle,
                              )),
                          ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const Login()));
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
                                        builder: (context) =>
                                            const EditModule()));
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
                                        builder: (context) =>
                                            const APIScreen()));
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
                                        builder: (context) =>
                                            const QuizScreen()));
                              },
                              child: Text(
                                'Quiz Sound',
                                style: buttonStyle,
                              )),
                          ElevatedButton(
                              onPressed: () async {
                                final fcmToken =
                                    await FirebaseMessaging.instance.getToken();
                                await FirebaseNotification.sendMessage(
                                    fcmToken);
                              },
                              child: Text(
                                'Send Notification',
                                style: buttonStyle,
                              )),
                          ElevatedButton(
                              onPressed: () async {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const JuzDisplay()));
                              },
                              child: Text(
                                'Juzuk',
                                style: buttonStyle,
                              )),
                          ElevatedButton(
                              onPressed: () async {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const SurahDisplay()));
                              },
                              child: Text(
                                'Word Translation Module',
                                style: buttonStyle,
                              )),
                          ElevatedButton(
                              onPressed: () async {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const CurveDisplay()));
                              },
                              child: Text(
                                'Curve text',
                                style: buttonStyle,
                              )),
                          ElevatedButton(
                              onPressed: () async {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const ShareScreen()));
                              },
                              child: Text(
                                'Share App',
                                style: buttonStyle,
                              )),
                          ElevatedButton(
                              onPressed: () async {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const CheckNetworkScreen()));
                              },
                              child: Text(
                                'Check Network Status',
                                style: buttonStyle,
                              )),
                          ElevatedButton(
                              onPressed: () async {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const MapPathScreen()));
                              },
                              child: Text(
                                'Draw Map Path',
                                style: buttonStyle,
                              )),
                          ElevatedButton(
                              onPressed: () async {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const ReadFromFirebase()));
                              },
                              child: Text(
                                'Read Data from Firebase',
                                style: buttonStyle,
                              )),
                          ElevatedButton(
                              onPressed: () async {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const DeleteAccountWidget()));
                              },
                              child: Text(
                                'Delete Account',
                                style: buttonStyle,
                              )),
                        ],
                      ),
                    ),
                  )
                : NoInternetWidget(
                    color: Theme.of(context).primaryColorLight,
                  );
          }),
        ),
        // This trailing comma makes auto-formatting nicer for build methods.
      );
    });
  }
}
