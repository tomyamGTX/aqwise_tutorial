import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class InternetProvider extends ChangeNotifier {
  ///declare boolean to check connection
  var isDeviceConnected = false;

  InternetProvider() {
    //add function to check internet on starting app
    checkConnection();
  }

  Future<void> checkConnection() async {
    bool result = await InternetConnectionChecker().hasConnection;
    ///update internet check output to boolean
    isDeviceConnected = result;
    print('listening internet connection...');
    notifyListeners();
  }
}
