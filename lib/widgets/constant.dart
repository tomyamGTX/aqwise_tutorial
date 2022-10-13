import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

Color kPrimaryColor = const Color(0xffF7ECDE);
String publishkey =
    'pk_test_51KUoMmH8qbOVfW8TpDMbk4SQbcncSFc9y8sEOE2iHtIvm7nKd0MdQrs8SZp49jY5ZiDKI2qYLS276RcvmKfIe55Z00yIGfZX2g';
String secretKey =
    'sk_test_51KUoMmH8qbOVfW8To6sFBH3Mg7yXUzdBXUw6VOM7dy0I9LA8JqaTFIS44SenWfY61DrKSvgWmm4Pi05OZWed7SRn00GI4jxA9V';

// If you are using a real device to test the integration replace this url
// with the endpoint of your test server (it usually should be the IP of your computer)
final kApiUrl = defaultTargetPlatform == TargetPlatform.android
    ? 'http://10.0.2.2:4242'
    : 'http://localhost:4242';
String paymentIntentURL = '$kApiUrl/payment_intents';
Map<String, String> headers = {
  'Authorization': 'Bearer $secretKey',
  'Content-Type': 'application/x-www-form-urlencoded'
};
