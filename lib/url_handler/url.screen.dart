import 'package:aqwise_stripe_payment/url_handler/webview.screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class URLScreen extends StatefulWidget {
  const URLScreen({Key? key}) : super(key: key);

  @override
  State<URLScreen> createState() => _URLScreenState();
}

class _URLScreenState extends State<URLScreen> {
  String _url = '';
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('URL handler'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Url'),
                initialValue: 'https://',
                onChanged: (v) {
                  setState(() {
                    _url = v;
                  });
                },
              ),
              ElevatedButton(
                  onPressed: () {
                    if (kIsWeb) {
                      launchUrl(Uri.parse(_url));
                    } else {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => WebViewScreen(url: _url)));
                    }
                  },
                  child: const Text('Navigate'))
            ],
          ),
        ),
      ),
    );
  }
}
