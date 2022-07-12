import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ReceiptScreen extends StatefulWidget {
  const ReceiptScreen(this.url, {Key? key}) : super(key: key);

  final String url;

  @override
  State<ReceiptScreen> createState() => _ReceiptScreenState();
}

class _ReceiptScreenState extends State<ReceiptScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Receipt detail'),
      ),
      body: WebView(
        initialUrl: widget.url,
      ),
    );
  }
}
