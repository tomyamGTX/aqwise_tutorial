import 'package:aqwise_stripe_payment/authentication/auth.provider.dart';
import 'package:aqwise_stripe_payment/authentication/landing.dart';
import 'package:aqwise_stripe_payment/edit.module/aya.number.provider.dart';
import 'package:aqwise_stripe_payment/favourite_list/favourite.provider.dart';
import 'package:aqwise_stripe_payment/payment/payment.provider.dart';
import 'package:aqwise_stripe_payment/toyyibpay.payment/toyyibpay.provider.dart';
import 'package:aqwise_stripe_payment/widgets/constant.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

Future<void> main() async {
  //initiliaze firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  if (!kIsWeb) {
    Stripe.publishableKey = publishkey;
    await Stripe.instance.applySettings();
  }
  await GetStorage.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        //auth provider
        ChangeNotifierProvider<AuthProvider>(
            create: (context) => AuthProvider()),

        ChangeNotifierProvider<FavouriteProvider>(
            create: (context) => FavouriteProvider()),
        ChangeNotifierProvider<PaymentProvider>(
            create: (context) => PaymentProvider()),
        ChangeNotifierProvider<ToyyibPayPaymentProvider>(
            create: (context) => ToyyibPayPaymentProvider()),
        ChangeNotifierProvider<AyaProvider>(create: (context) => AyaProvider()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
            useMaterial3: true,
            primaryColor: kPrimaryColor,
            canvasColor: kSecondaryColor),
        //SET HOME TO LANDING PAGE
        home: const LandingPage(),
      ),
    );
  }
}
