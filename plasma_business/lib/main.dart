import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:plasma_business/app/constants.dart';
import 'package:plasma_business/firebase_options.dart';

import 'package:plasma_business/views/business_setup.page.dart';
import 'package:plasma_business/views/login.page.dart';
import 'package:plasma_business/views/main.page.dart';
import 'package:plasma_business/views/pages/home.page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  Stripe.publishableKey = publishableKey;

  runApp(const Plasma());
}

class Plasma extends StatelessWidget {
  const Plasma({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appname,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          fontFamily: primaryFont,
          useMaterial3: true,
          primarySwatch: Colors.amber,
          appBarTheme: AppBarTheme(
              elevation: 0.0,
              backgroundColor: Colors.white,
              titleTextStyle: TextStyle(
                  color: Colors.black,
                  fontFamily: headerFont,
                  fontWeight: FontWeight.bold,
                  fontSize: 18))),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.userChanges(),
        builder: (context, user) {
          if (user.data == null) {
            return const LoginPage();
          }
          return const MainPage();
        },
      ),
    );
  }
}
