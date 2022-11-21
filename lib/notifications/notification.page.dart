import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';

class NotificationPage extends StatefulWidget {
  final ReceivedAction receivedAction;
  const NotificationPage({super.key, required this.receivedAction});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        CircleAvatar(
          backgroundImage: widget.receivedAction.bigPictureImage!,
          radius: 40,
        ),
        Text(widget.receivedAction.title!),
        Text(widget.receivedAction.body!),
        Text(widget.receivedAction.actionDate!.toString()),
        ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('OK'))
      ]),
    ));
  }
}
