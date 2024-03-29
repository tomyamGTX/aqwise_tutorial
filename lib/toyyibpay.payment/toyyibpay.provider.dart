import 'dart:convert';

import 'package:aqwise_stripe_payment/authentication/auth.provider.dart';
import 'package:aqwise_stripe_payment/toyyibpay.payment/bill.transaction.model.dart';
import 'package:aqwise_stripe_payment/toyyibpay.payment/category.model.dart';
import 'package:aqwise_stripe_payment/toyyibpay.payment/toyyibpay.constant.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ToyyibPayPaymentProvider extends ChangeNotifier {
  ToyyibPayPaymentProvider() {
    // init();
    getBillCodeFromDb();
  }
  List<String?> billCode = [];
  List<bool> paid = [false];

  var userSecretkey =
      isLive ? secretkeyToyyibPayAQWise : secretkeyToyyibTesting;

  //replace with category code based on app
  String? categoryCode = categoryCodeAQWiseTutorial;

  var createCategoryUrl = Uri.parse(isLive
      ? 'https://toyyibpay.com/index.php/api/createCategory'
      : 'https://dev.toyyibpay.com/index.php/api/createCategory');
  var createBillUrl = Uri.parse(isLive
      ? 'https://toyyibpay.com/index.php/api/createBill'
      : 'https://dev.toyyibpay.com/index.php/api/createBill');
  var getBillTransaction = Uri.parse(isLive
      ? 'https://toyyibpay.com/index.php/api/getBillTransactions'
      : 'https://dev.toyyibpay.com/index.php/api/getBillTransactions');

  void init() async {
    //for multipartrequest
    var request = http.MultipartRequest('POST', createCategoryUrl);

    // //for token
    // request.headers.addAll({"Authorization": "Bearer token"});

    //for image and videos and files
    // request.files.add(await http.MultipartFile.fromPath(
    //     "key_value_from_api", "image_path/video/path"));

    request.fields['catname'] = 'EZFlutter${AuthProvider.instance.user!.uid}';
    request.fields['catdescription'] =
        'Category for all transaction from user id ${AuthProvider.instance.user!.uid}';
    request.fields['userSecretKey'] = userSecretkey;

    //for completeing the request
    var response = await request.send();

    //for getting and decoding the response into json format
    var responsed = await http.Response.fromStream(response);
    final responseData = json.decode(responsed.body);

    if (response.statusCode == 200) {
      var data = CreateCategoryResponse.fromJson(responseData);
      categoryCode = data.categoryCode;
      notifyListeners();
    } else {
      if (kDebugMode) {
        print("ERROR");
      }
    }
  }

  Future<void> createBill(BuildContext context,
      {required String billName,
      required String billDesc,
      required double price,
      required String phone}) async {
    notifyListeners();
    var request = http.MultipartRequest('POST', createBillUrl);
    request.fields['userSecretKey'] = userSecretkey;
    request.fields['categoryCode'] = categoryCode!;
    request.fields['billName'] = billName;
    request.fields['billDescription'] = billDesc;
    request.fields['billPriceSetting'] = '1';
    request.fields['billPayorInfo'] = '1';
    request.fields['billAmount'] = '${price * 100}';
    request.fields['billReturnUrl'] = '';
    request.fields['billCallbackUrl'] = '';
    request.fields['billExternalReferenceNo'] = 'AFR341DFI';
    request.fields['billTo'] =
        AuthProvider().user!.displayName ?? 'User${AuthProvider().user!.uid}';
    request.fields['billEmail'] = AuthProvider().user!.email!;
    request.fields['billPhone'] = phone;
    request.fields['billSplitPayment'] = '0';
    request.fields['billSplitPaymentArgs'] = '';
    request.fields['billPaymentChannel'] = '2';
    request.fields['billContentEmail'] =
        'Thank you for purchasing our product!';
    request.fields['billChargeToCustomer'] = '1';
    // request.fields['billExpiryDays'] = '$expired';
    // request.fields['billExpiryDate'] = DateTime(DateTime.now().year,
    //         DateTime.now().month, DateTime.now().day + expired)
    //     .toString();
    try {
      var response = await request.send();

      var responsed = await http.Response.fromStream(response);
      final responseData = json.decode(responsed.body);

      if (response.statusCode == 200) {
        billCode.add(responseData[0]['BillCode']);
        notifyListeners();
      } else {
        if (kDebugMode) {
          print("ERROR");
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<void> getBillTransactions(
      BuildContext context, String billCode) async {
    var request = http.MultipartRequest('POST', getBillTransaction);
    request.fields['billCode'] = billCode;
    try {
      var response = await request.send();

      var responsed = await http.Response.fromStream(response);
      final responseData = json.decode(responsed.body);

      if (response.statusCode == 200) {
        for (var item in responseData) {
          var data = BillTransaction.fromJson(item);
          if (data.billpaymentStatus == '1') {
            successPayment();
            if (kDebugMode) {
              print('Successful transaction');
            }
          } else if (data.billpaymentStatus == '2') {
            if (kDebugMode) {
              print('Pending transaction');
            }
          } else if (data.billpaymentStatus == '3') {
            failPayment();
            if (kDebugMode) {
              print('Unsuccessful transaction');
            }
          } else if (data.billpaymentStatus == '4') {
            if (kDebugMode) {
              print('Pending');
            }
          }
        }
      } else {
        if (kDebugMode) {
          print("ERROR");
        }
      }
      notifyListeners();
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  void successPayment() {
    paid.clear();
    paid.add(true);
    notifyListeners();
  }

  void failPayment() {
    paid.clear();
    paid.add(false);
    notifyListeners();
  }

  void getBillCodeFromDb() {
    //func here and assign to bill code. Bill code in String datatype
    billCode = [];
    notifyListeners();
    getAccStatus();
  }

  void getAccStatus() {
    //func here and assign to paid. Set true if user is premium
    paid = [false];
    notifyListeners();
  }
}
