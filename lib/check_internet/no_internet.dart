import 'package:flutter/material.dart';

class NoInternetWidget extends StatelessWidget {
  const NoInternetWidget({
    required this.color,
    super.key,
  });
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.wifi_off,
            color: color,
            size: 80,
          ),
          Text(
            'No internet',
            style: TextStyle(color: color),
          ),
        ],
      ),
    );
  }
}
