import 'package:flutter/material.dart';
import 'package:plasma_delivery/app/constants.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const PlasmaDelivery());
}

class PlasmaDelivery extends StatelessWidget {
  const PlasmaDelivery({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Plasma Delivery",
      debugShowMaterialGrid: false,
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
    );
  }
}