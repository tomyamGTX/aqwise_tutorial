import 'dart:convert';

import 'package:aqwise_stripe_payment/payment/receipt.screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' hide Card;
import 'package:flutter_credit_card/credit_card_form.dart';
import 'package:flutter_credit_card/credit_card_model.dart';
import 'package:flutter_credit_card/credit_card_widget.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../services/stripe.service.dart';
import '../models/payment.output.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final _phone = TextEditingController();
  final _email = TextEditingController();
  PaymentOutput? _paymentOutput;

  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Future<void> checkout(BuildContext context, String phone, cardNumber,
      expiryDate, cardHolderName, cvvCode, email) async {
    try {
      var customer;
      var paymentIntent;
      var paymentMethod;
      var custId;
      if (custId == null) {
        customer = await StripeService.createCustomer(
            cardHolderName, '+6$phone', email, cardHolderName);
        setState(() {});
        custId = customer['id'];
      } else {
        customer = await StripeService.getCustomer(custId);
      }

      paymentMethod = await StripeService.createCardPaymentMethod(
          number: cardNumber,
          expMonth: expiryDate.substring(0, 2),
          expYear: '20${expiryDate.substring(3)}',
          cvc: cvvCode);
      setState(() {});
      var paymentMethodID = paymentMethod['id'];

      ///todo:change price here 5000= RM50
      paymentIntent = await StripeService.createPaymentIntent('5000', 'MYR');
      showDialog(
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Buy Premium Product'),
              content: ListTile(
                  title: Text("Name: ${customer!['name']}"),
                  subtitle: Text(
                      'Total: RM ${paymentIntent!['amount'].toString().substring(0, 2)}\nTel-No: ${_phone.text}')),
              actions: [
                ElevatedButton.icon(
                  onPressed: () async {
                    var paymentConfirm;
                    try {
                      setState(() {});
                      paymentConfirm = await StripeService.confirmPayment(
                          paymentIntent!['id'], paymentMethodID);
                      setState(() {});
                      _paymentOutput =
                          paymentOutputFromJson(jsonEncode(paymentConfirm));
                      Navigator.pop(context);
                      if (_paymentOutput!.status == 'succeeded') {
                        ///todo: do something when payment success
                      }
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('Payment ${_paymentOutput!.status}')));
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text(
                              'Error. Payment already made or card had been blacklist')));
                      Navigator.pop(context);
                    }
                  },
                  label: const Text('Confirm Payment'),
                  icon: const Icon(Icons.save),
                )
              ],
            );
          },
          context: context);
    } catch (e) {
      showDialog(
          builder: (BuildContext context) {
            return AlertDialog(
              content: Text(e.toString()),
            );
          },
          context: context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stripe Payment'),
      ),
      resizeToAvoidBottomInset: true,
      body: Container(
        decoration: const BoxDecoration(
          border: Border(),
        ),
        child: _paymentOutput == null
            ? Column(
                children: [
                  CreditCardWidget(
                    cardNumber: cardNumber,
                    expiryDate: expiryDate,
                    cardHolderName: cardHolderName,
                    cvvCode: cvvCode,
                    showBackView: isCvvFocused,
                    obscureCardNumber: true,
                    obscureCardCvv: true,
                    onCreditCardWidgetChange: (creditCardBrand) {},
                  ),
                  Expanded(
                      child: SingleChildScrollView(
                    child: Column(
                      children: [
                        CreditCardForm(
                          cardNumber: cardNumber,
                          expiryDate: expiryDate,
                          cardHolderName: cardHolderName,
                          cvvCode: cvvCode,
                          onCreditCardModelChange: onCreditCardModelChange,
                          themeColor: Theme.of(context).primaryColor,
                          formKey: formKey,
                          cardNumberDecoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              label: Text('Number'),
                              hintText: 'xxxx xxxx xxxx xxxx'),
                          expiryDateDecoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              label: Text('Expired Date'),
                              hintText: 'xx/xx'),
                          cvvCodeDecoration: const InputDecoration(
                              label: Text('CVV'), hintText: 'xxx'),
                          cardHolderDecoration: const InputDecoration(
                            label: Text('Card Holder'),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: TextFormField(
                            decoration: const InputDecoration(
                              label: Text('Phone Number'),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(width: 1, color: Colors.blue),
                              ),
                            ),
                            validator: (e) {
                              if (e!.isEmpty) {
                                return 'Phone number cannot be null';
                              }
                            },
                            controller: _phone,
                            keyboardType: const TextInputType.numberWithOptions(
                                decimal: false),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: TextFormField(
                            decoration: const InputDecoration(
                              label: Text('Email'),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(width: 1, color: Colors.blue),
                              ),
                            ),
                            validator: (e) {
                              if (e!.isEmpty) {
                                return 'Email cannot be null';
                              }
                            },
                            controller: _email,
                            keyboardType: const TextInputType.numberWithOptions(
                                decimal: false),
                          ),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              primary: const Color(0xff1b447b)),
                          child: Container(
                            margin: const EdgeInsets.all(8.0),
                            child: const Text(
                              'validate',
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'halter',
                                fontSize: 14,
                                package: 'flutter_credit_card',
                              ),
                            ),
                          ),
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              ///todo:replace email with user email
                              await checkout(
                                  context,
                                  _phone.text,
                                  cardNumber,
                                  expiryDate,
                                  cardHolderName,
                                  cvvCode,
                                  _email.text);
                              print('valid');
                            } else {
                              print('inValid');
                            }
                          },
                        )
                      ],
                    ),
                  )),
                ],
              )
            : Column(
                children: [
                  Flexible(
                    child: ListView(
                      children: [
                        ListTile(
                            title: const Text('Payment ID'),
                            subtitle: Text(_paymentOutput!.id)),
                        ListTile(
                            title: const Text('Payment Status'),
                            subtitle: Text(_paymentOutput!.status)),
                        ListTile(
                            title: const Text('Payment Amount'),
                            subtitle: Text(
                                '${_paymentOutput!.currency} ${_paymentOutput!.amount.toString().substring(0, _paymentOutput!.amount.toString().length - 2)}')),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.orange),
                              onPressed: () async {
                                if (!kIsWeb) {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ReceiptScreen(
                                              _paymentOutput!.charges.data.last
                                                  .receiptUrl)));
                                } else {
                                  launchUrl(Uri.parse(_paymentOutput!
                                      .charges.data.last.receiptUrl));
                                }
                              },
                              child: const Text('Get Receipt')),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  void onCreditCardModelChange(CreditCardModel creditCardModel) {
    setState(() {
      cardNumber = creditCardModel.cardNumber;
      expiryDate = creditCardModel.expiryDate;
      cardHolderName = creditCardModel.cardHolderName;
      cvvCode = creditCardModel.cvvCode;
      isCvvFocused = creditCardModel.isCvvFocused;
    });
  }
}
