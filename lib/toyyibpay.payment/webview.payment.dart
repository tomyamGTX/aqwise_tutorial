import 'dart:async';
import 'dart:io';

import 'package:aqwise_stripe_payment/toyyibpay.payment/toyyibpay.constant.dart';
import 'package:aqwise_stripe_payment/toyyibpay.payment/toyyibpay.provider.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPayment extends StatefulWidget {
  final String billcode;
  final bool status;

  const WebViewPayment(this.billcode, this.status, {Key? key})
      : super(key: key);

  @override
  WebViewPaymentState createState() => WebViewPaymentState();
}

class WebViewPaymentState extends State<WebViewPayment> {
  late dynamic timer;
  bool receipt = false;
  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (!widget.status) {
        Provider.of<ToyyibPayPaymentProvider>(context, listen: false)
            .getBillTransactions(context, widget.billcode);
      }
    });

    if (Platform.isAndroid) WebView.platform = AndroidWebView();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ToyyibPayPaymentProvider>(builder: (context, bill, child) {
      return Scaffold(
        appBar: AppBar(
          title:
              Text(widget.status ? 'ToyyibPay Receipt' : 'ToyyibPay Payment'),
          centerTitle: true,
        ),
        body: bill.paid.first && !widget.status
            ? Center(
                child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    'Payment success',
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      radius: 60,
                      backgroundColor: Colors.greenAccent,
                      child: Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 80,
                      ),
                    ),
                  ),
                ],
              ))
            : WebView(
                javascriptMode: JavascriptMode.unrestricted,
                initialUrl: isLive
                    ? 'https://toyyibpay.com/${widget.billcode}'
                    : 'https://dev.toyyibpay.com/${widget.billcode}',
              ),
      );
    });
  }
}
