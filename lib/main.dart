import 'package:aqwise_stripe_payment/authentication/auth.provider.dart';
import 'package:aqwise_stripe_payment/authentication/landing.dart';
import 'package:aqwise_stripe_payment/edit.module/aya.number.provider.dart';
import 'package:aqwise_stripe_payment/favourite_list/favourite.provider.dart';
import 'package:aqwise_stripe_payment/juzuk/juz.provider.dart';
import 'package:aqwise_stripe_payment/notifications/firebase.messaging.dart';
import 'package:aqwise_stripe_payment/payment/payment.provider.dart';
import 'package:aqwise_stripe_payment/theme/theme.provider.dart';
import 'package:aqwise_stripe_payment/toyyibpay.payment/toyyibpay.provider.dart';
import 'package:aqwise_stripe_payment/widgets/constant.dart';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'authentication/home.dart';
import 'firebase_options.dart';
import 'notifications/notification.controller.dart';
import 'notifications/notification.page.dart';

Future<void> main() async {
  //initiliaze firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  ///stripe
  if (!kIsWeb) {
    Stripe.publishableKey = publishkey;
    await Stripe.instance.applySettings();
  }
  await GetStorage.init();

  ///nootification
  AwesomeNotifications().initialize(
      // set the icon to null if you want to use the default app icon
      null,
      [
        NotificationChannel(
            channelGroupKey: 'basic_channel_group',
            channelKey: 'basic_channel',
            channelName: 'Basic notifications',
            channelDescription: 'Notification channel for basic tests',
            defaultColor: Color(0xFF9D50DD),
            ledColor: Colors.white)
      ],
      // Channel groups are only visual and are not required
      channelGroups: [
        NotificationChannelGroup(
            channelGroupKey: 'basic_channel_group',
            channelGroupName: 'Basic group')
      ],
      debug: true);

  ///fm
  await FirebaseNotification.initFirebaseMessaging();
  ReceivedAction? receivedAction = await AwesomeNotifications()
      .getInitialNotificationAction(removeFromActionEvents: false);
  if (receivedAction?.channelKey == 'call_channel') {
    const MyApp();
  } else {
    const MyHomePage(
      title: 'AQ WISE - Tutorial App',
    );
  }
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  static const String name = 'AQ WISE - Tutorial App';

  const MyApp({Key? key}) : super(key: key);
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // Only after at least the action method is set, the notification events are delivered
    AwesomeNotifications().setListeners(
        onActionReceivedMethod: NotificationController.onActionReceivedMethod,
        onNotificationCreatedMethod:
            NotificationController.onNotificationCreatedMethod,
        onNotificationDisplayedMethod:
            NotificationController.onNotificationDisplayedMethod,
        onDismissActionReceivedMethod:
            NotificationController.onDismissActionReceivedMethod);

    super.initState();
  }

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
        ChangeNotifierProvider<JuzProvider>(create: (context) => JuzProvider()),
        ChangeNotifierProvider<ThemeProvider>(
            create: (context) => ThemeProvider()),
      ],
      child: MaterialApp(
        navigatorKey: MyApp.navigatorKey,
        title: 'AQ WISE - Tutorial App', initialRoute: '/',
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case '/':
              return MaterialPageRoute(
                  builder: (context) => const MyHomePage(title: MyApp.name));

            case '/notification-page':
              return MaterialPageRoute(builder: (context) {
                final ReceivedAction receivedAction =
                    settings.arguments as ReceivedAction;
                return NotificationPage(receivedAction: receivedAction);
              });

            default:
              assert(false, 'Page ${settings.name} not found');
              return null;
          }
        },
        theme: ThemeData(
            useMaterial3: true,
            textTheme: GoogleFonts.poppinsTextTheme(),
            primaryColor: kPrimaryColor,
            canvasColor: kSecondaryColor),
        //SET HOME TO LANDING PAGE
        home: const LandingPage(),
      ),
    );
  }
}
