import 'package:aqwise_stripe_payment/check_internet/internet_provider.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/async.dart';
import 'package:flutter/src/widgets/basic.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:provider/provider.dart';

import 'no_internet.dart';

class CheckNetworkScreen extends StatefulWidget {
  const CheckNetworkScreen({super.key});

  @override
  State<CheckNetworkScreen> createState() => _CheckNetworkScreenState();
}

class _CheckNetworkScreenState extends State<CheckNetworkScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Internet Connection')),
      body: Center(
        ///need to apply to all screen that require internet connection
        child: Consumer<InternetProvider>(builder: (context, conn, _) {
          ///checking every second
          conn.checkConnection();

          ///on true display content, on false display no internet UI
          return conn.isDeviceConnected
              ? const Text('Internet access available')
              : const NoInternetWidget();
        }),
      ),
    );
  }
}
