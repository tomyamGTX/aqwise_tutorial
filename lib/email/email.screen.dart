import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';

class EmailScreen extends StatefulWidget {
  const EmailScreen({Key? key}) : super(key: key);

  @override
  State<EmailScreen> createState() => _EmailScreenState();
}

class _EmailScreenState extends State<EmailScreen> {
  final _formKey = GlobalKey<FormState>();

  final _subject = TextEditingController();
  final _body = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextFormField(
                  validator: (v) {
                    if (v!.isEmpty) {
                      return 'Please insert subject';
                    } else {
                      null;
                    }
                  },
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), labelText: 'Subject'),
                  controller: _subject,
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  validator: (v) {
                    if (v!.isEmpty) {
                      return 'Please insert your feedback';
                    } else {
                      null;
                    }
                  },
                  maxLines: 5,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), labelText: 'Body'),
                  controller: _body,
                ),
                ElevatedButton(onPressed: _sendEmail, child: const Text('Send'))
              ],
            ),
          )),
    );
  }

  Future<void> _sendEmail() async {
    // Validate returns true if the form is valid, or false otherwise.
    if (_formKey.currentState!.validate()) {
      final Email email = Email(
        body: _body.text,
        subject: _subject.text,
        recipients: ['kimimdnoor90@gmail.com'],
        // cc: ['cc@example.com'],
        // bcc: ['bcc@example.com'],
        // attachmentPaths: ['/path/to/attachment.zip'],
        isHTML: false,
      );
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Opening Email App ...')),
      );
      await FlutterEmailSender.send(email);
    }
  }
}
