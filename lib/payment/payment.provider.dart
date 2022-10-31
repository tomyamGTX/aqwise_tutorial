import 'package:flutter/material.dart';

class PaymentProvider extends ChangeNotifier {
  dynamic cid;
  dynamic pid;
  String? receipt;
  String? status;
  String role = 'FREE';
  var price = 'RM 50.00';
  void setCid(custId) {
    cid = custId;
    notifyListeners();
  }

  void setPid(id) {
    pid = id;
    notifyListeners();
  }

  void updateData(url, code) {
    receipt = url;
    status = code;
    notifyListeners();
  }

  void updateRole(url, paymentId, custId) {
    //update user detail in database on success
    //line after this example execution
    role = 'PAID';
    notifyListeners();
  }
}
