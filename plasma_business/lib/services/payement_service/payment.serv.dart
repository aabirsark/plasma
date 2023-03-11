import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;
import 'package:plasma_business/app/constants.dart';

class PaymentServ {
  static Future payment(int amount) async {
    try {
      final paymentIntentData = await createPaymentIntent(amount);
      if (paymentIntentData != null) {
        await Stripe.instance.initPaymentSheet(
            paymentSheetParameters: SetupPaymentSheetParameters(
          merchantDisplayName: 'Plasma',
          style: ThemeMode.dark,
          googlePay: const PaymentSheetGooglePay(
              testEnv: true, merchantCountryCode: "IN", currencyCode: "INR"),
          appearance: PaymentSheetAppearance(
              colors: PaymentSheetAppearanceColors(
                background: Colors.black,
                componentBackground: Colors.white.withOpacity(0.03),
                primary: primaryColor,
                primaryText: Colors.white,
                componentText: Colors.white30,
                secondaryText: Colors.white38,
                placeholderText: Colors.white,
                icon: Colors.white,
              ),
              primaryButton: const PaymentSheetPrimaryButtonAppearance(
                  colors: PaymentSheetPrimaryButtonTheme(
                      dark: PaymentSheetPrimaryButtonThemeColors(
                          background: primaryColor)))),
          customerId: paymentIntentData!['customer'],
          paymentIntentClientSecret: paymentIntentData!['client_secret'],
          customerEphemeralKeySecret: paymentIntentData!['ephemeralKey'],
        ));
      }
    } catch (e, s) {
      print('exception:$e$s');
    }
  }

  static Future createPaymentIntent(int amount) async {
    try {
      final Map<String, dynamic> data = {
        "amount": calculateAmount(amount),
        "currency": "inr",
        'payment_method_types[]': 'card',
      };

      final response = await http.post(
          Uri.parse("https://api.stripe.com/v1/payment_intents"),
          headers: {
            'Authorization': 'Bearer $stripeSecretKey',
            'Content-Type': 'application/x-www-form-urlencoded'
          },
          body: jsonEncode(data));

      final jsonData = jsonDecode(response.body);

      return jsonData;
    } catch (e) {
      return null;
    }
  }
}

calculateAmount(int amount) {
  final a = (amount) * 100;
  return a.toString();
}
