import 'package:aqwise_stripe_payment/check_internet/internet_provider.dart';
import 'package:flutter/material.dart';
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
              : const NoInternetWidget(color: Colors.black,);
        }),
      ),
    );
  }
}
