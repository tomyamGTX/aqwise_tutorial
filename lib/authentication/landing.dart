import 'package:aqwise_stripe_payment/authentication/auth.provider.dart';
import 'package:aqwise_stripe_payment/authentication/home.dart';
import 'package:aqwise_stripe_payment/authentication/login.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    var user = Provider.of<AuthProvider>(context).user;
    if (user == null) {
      return const LoginPage();
    } else {
      return const HomePage();
    }
  }
}
