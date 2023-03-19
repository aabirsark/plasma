import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class OrderConfrimedPage extends StatelessWidget {
  const OrderConfrimedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(),
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 350,
                  child: LottieBuilder.asset(
                    'assets/confirm.json',
                    repeat: false,
                    reverse: false,
                    height: 200,
                    width: 200,
                  ),
                ),
                const Text(
                  "ORDER CONFIRMED",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(
                  "Continue shopping",
                  style: TextStyle(color: Colors.grey.shade400),
                )
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.popUntil(context, (route) => route.isFirst);
            },
          )
        ],
      ),
    );
  }
}
