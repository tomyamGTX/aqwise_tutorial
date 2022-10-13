import 'package:aqwise_stripe_payment/payment/payment.provider.dart';
import 'package:aqwise_stripe_payment/payment/stripe.service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:provider/provider.dart';

import '../widgets/constant.dart';

class PaymentSheet extends StatefulWidget {
  const PaymentSheet({Key? key}) : super(key: key);

  @override
  State<PaymentSheet> createState() => _PaymentSheetState();
}

class _PaymentSheetState extends State<PaymentSheet> {
  Future<void> initPayment() async {
    try {
      //get user detail before proceed
      dynamic customer = await StripeService.createCustomer('Hakimi',
          '013456789', 'hakimimdnoor90@gmail.com', 'buy test premium');
      String custId = customer['id'];
      if (!mounted) return;
      Provider.of<PaymentProvider>(context, listen: false).setCid(custId);
      //change price and get user email
      dynamic paymentIntent = await StripeService.createPaymentIntent(
          '5000', 'MYR', custId, 'hakimimdnoor90@gmail.com');
      dynamic ephmeralkey = await StripeService.createEphemeralKey(custId);
      String clientSecret = paymentIntent['client_secret'];
      await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
        paymentIntentClientSecret: clientSecret,
        merchantDisplayName: 'AQ WISE TUTORIAL',
        customerId: custId,
        customerEphemeralKeySecret: ephmeralkey['secret'],
      ));
      await Stripe.instance.presentPaymentSheet();
      if (!mounted) return;
      Provider.of<PaymentProvider>(context, listen: false)
          .setPid(paymentIntent['id']);
      var updatedIntent = await StripeService.getIntent(paymentIntent['id']);

      //receipt url
      if (kDebugMode) {
        print(updatedIntent['charges']['data'].last['receipt_url']);
      }
      //status payment
      if (kDebugMode) {
        print(updatedIntent['status']);
      }

      if (!mounted) return;
      if (updatedIntent['status'] == 'succeeded') {
        //update user data on db here
        //go to receipt/etc
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Payment Success')));
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Payment Fail')));
      }
    } catch (error) {
      if (error is StripeException) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(error.error.message!)));
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(error.toString())));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: kPrimaryColor,
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Join the Premium',
            style: TextStyle(
              fontFamily: "MontserratBold",
              fontSize: 24,
              color: Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
          backgroundColor: Colors.white,
          iconTheme: const IconThemeData(color: Colors.black),
        ),
        body: Center(
            child: Container(
          width: screenWidth * 1,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.all(10),
                child: Icon(
                  Icons.diamond_outlined,
                  size: 70,
                  color: Color(0xFFFAD399),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Get Premium!',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w700),
              ),
              Container(
                width: screenWidth * 1,
                height: screenHeight * 0.15,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Padding(
                      padding: EdgeInsets.fromLTRB(40, 0, 20, 0),
                      child: Icon(
                        Icons.person,
                        size: 30,
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Padding(
                          padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                          child: Text(
                            'Lifetime Premium Membership',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                              fontFamily: 'PoppinsRegular',
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(20, 5, 20, 10),
                          child: Text(
                            'Pay once and get lifetime\npremium access!',
                            textAlign: TextAlign.justify,
                            overflow: TextOverflow.clip,
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 14,
                              fontFamily: 'PoppinsRegular',
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                width: screenWidth * 1,
                height: screenHeight * 0.15,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(40, 0, 20, 0),
                      child: Icon(
                        Icons.subscriptions_rounded,
                        size: 30,
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                          child: Text(
                            'Premium Contents',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                              fontFamily: 'PoppinsRegular',
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 5, 20, 10),
                          child: Text(
                            'Get access over 50 premium\neducational contents!',
                            textAlign: TextAlign.justify,
                            overflow: TextOverflow.clip,
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 14,
                              fontFamily: 'PoppinsRegular',
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
              Container(
                width: screenWidth * 1,
                height: screenHeight * 0.15,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(40, 0, 20, 0),
                      child: Icon(
                        Icons.support_agent_rounded,
                        size: 30,
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                          child: Text(
                            'Exclusive Support',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                              fontFamily: 'PoppinsRegular',
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 5, 20, 10),
                          child: Text(
                            'Exclusive support from our team\nfor premium user!',
                            textAlign: TextAlign.justify,
                            overflow: TextOverflow.clip,
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 14,
                              fontFamily: 'PoppinsRegular',
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: TextButton(
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.all(20),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    backgroundColor: Color(0xff2196f3),
                  ),
                  onPressed: () => initPayment(),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.diamond_outlined,
                        color: Colors.white,
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                        child: Text(
                          'Buy Premium',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontFamily: 'PoppinsRegular'),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        )));
  }
}
