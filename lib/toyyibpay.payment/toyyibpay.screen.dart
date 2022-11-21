import 'package:aqwise_stripe_payment/toyyibpay.payment/toyyibpay.provider.dart';
import 'package:aqwise_stripe_payment/toyyibpay.payment/webview.payment.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'toyyibpay.constant.dart';

class ToyyibPayScreen extends StatefulWidget {
  const ToyyibPayScreen({super.key});

  @override
  State<ToyyibPayScreen> createState() => _ToyyibPayScreenState();
}

class _ToyyibPayScreenState extends State<ToyyibPayScreen> {
  final _formKey = GlobalKey<FormState>();
  final phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Image.asset('assets/images/toyyibpay.png'),
          ),
          ElevatedButton(
              onPressed: () {
                showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (context) => Padding(
                          padding: EdgeInsets.only(
                              bottom: MediaQuery.of(context).viewInsets.bottom),
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 12.0),
                            child: Form(
                              key: _formKey,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Provider.of<ToyyibPayPaymentProvider>(context,
                                                  listen: false)
                                              .billCode
                                              .isEmpty ||
                                          !Provider.of<
                                                      ToyyibPayPaymentProvider>(
                                                  context,
                                                  listen: false)
                                              .paid
                                              .first
                                      ? Flexible(
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 8.0),
                                            child: TextFormField(
                                              controller: phoneController,
                                              validator: ((value) {
                                                if (value!.isEmpty) {
                                                  return 'Please input all field';
                                                } else {
                                                  return null;
                                                }
                                              }),
                                              decoration: const InputDecoration(
                                                border: InputBorder.none,
                                                prefixIcon: Icon(Icons.phone),
                                                hintText: '+60 123456789',
                                                labelText:
                                                    'Enter your phone number',
                                              ),
                                              autofocus: true,
                                            ),
                                          ),
                                        )
                                      : const Padding(
                                          padding: EdgeInsets.only(top: 8.0),
                                          child: Text(
                                              'You already bought this product'),
                                        ),
                                  Provider.of<ToyyibPayPaymentProvider>(context,
                                                  listen: false)
                                              .billCode
                                              .isEmpty ||
                                          !Provider.of<
                                                      ToyyibPayPaymentProvider>(
                                                  context,
                                                  listen: false)
                                              .paid
                                              .first
                                      ? const SizedBox(width: 20)
                                      : const Spacer(),
                                  ElevatedButton(
                                      onPressed: _payFunc,
                                      child: Text(
                                          Provider.of<ToyyibPayPaymentProvider>(
                                                          context,
                                                          listen: false)
                                                      .billCode
                                                      .isEmpty ||
                                                  !Provider.of<
                                                              ToyyibPayPaymentProvider>(
                                                          context,
                                                          listen: false)
                                                      .paid
                                                      .first
                                              ? 'Pay Now'
                                              : 'View Receipt'))
                                ],
                              ),
                            ),
                          ),
                        ));
              },
              child: const Text('Proceed'))
        ],
      ),
    );
  }

  Future<void> _payFunc() async {
    if (_formKey.currentState!.validate()) {
      //for new payment. premium user can get code from firestore
      if (Provider.of<ToyyibPayPaymentProvider>(context, listen: false)
          .billCode
          .isEmpty) {
        await Provider.of<ToyyibPayPaymentProvider>(context, listen: false)
            .createBill(context,
                billName: billName,
                billDesc: billDesc,
                price: price,
                phone: phoneController.text);
      }
      if (!mounted) return;
      //set false for new user
      var status = Provider.of<ToyyibPayPaymentProvider>(context, listen: false)
          .paid
          .first;
      var code = Provider.of<ToyyibPayPaymentProvider>(context, listen: false)
          .billCode
          .first;
      Navigator.pop(context);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => WebViewPayment(code!, status)));
    }
  }
}
