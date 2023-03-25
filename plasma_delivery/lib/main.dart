import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:plasma_delivery/app/constants.dart';
import 'package:plasma_delivery/firebase_options.dart';
import 'package:plasma_delivery/views/get_started.page.dart';
import 'package:plasma_delivery/views/home.page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const PlasmaDelivery());
}

class PlasmaDelivery extends StatelessWidget {
  const PlasmaDelivery({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Plasma Delivery",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          fontFamily: primaryFont,
          useMaterial3: true,
          primarySwatch: Colors.amber,
          primaryColor: Colors.amber,
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
          return const HomePage();
        },
      ),
    );
  }
}
