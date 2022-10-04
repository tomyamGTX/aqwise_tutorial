import 'package:aqwise_stripe_payment/payment/payment.provider.dart';
import 'package:aqwise_stripe_payment/payment/stripe.service.dart';
import 'package:aqwise_stripe_payment/widgets/exmple.scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:provider/provider.dart';

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
      print(updatedIntent['charges']['data'].last['receipt_url']);
      //status payment
      print(updatedIntent['status']);

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
    return ExampleScaffold(
      padding: const EdgeInsets.all(16),
      children: [
        ElevatedButton(onPressed: initPayment, child: const Text('Pay RM 50'))
      ],
    );
  }
}
