import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;
import 'package:plasma/app/constants.dart';

class PaymentServ {
  static Future payment(int amount) async {
    try {
      final paymentIntentData = await createPaymentIntent(amount);
      if (paymentIntentData != null) {
        await Stripe.instance.initPaymentSheet(
            paymentSheetParameters: SetupPaymentSheetParameters(
          merchantDisplayName: 'Plasma',
          googlePay: const PaymentSheetGooglePay(
              merchantCountryCode: "in", currencyCode: "inr", testEnv: true),
          appearance: PaymentSheetAppearance(
              colors: PaymentSheetAppearanceColors(
                background: Colors.white,
                componentBackground: Colors.black.withOpacity(0.03),
                primary: primaryColor,
                primaryText: Colors.black,
                componentText: Colors.black,
                secondaryText: Colors.black38,
                placeholderText: Colors.black45,
                icon: Colors.black,
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
      final Map<String, String> data = {
        "amount": calculateAmount(amount),
        "currency": "inr",
        'payment_method_types[]': 'card',
      };

      print(data);

      final response = await http.post(
          Uri.parse("https://api.stripe.com/v1/payment_intents"),
          headers: {
            'Authorization': 'Bearer $stripeSecretKey',
            'Content-Type': 'application/x-www-form-urlencoded'
          },
          body: data);

      print(response.body);

      final jsonData = jsonDecode(response.body);

      return jsonData;
    } catch (e) {
      return null;
    }
  }
}

String calculateAmount(int amount) {
  final a = (amount) * 100;
  return a.toString();
}
