import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:plasma/services/models/order.model.dart';
import 'package:plasma/services/models/product_model.dart';

class OrderDBFnctions {
  static Future orderProduct(String address, int price,
      List<ProductModel> model, bool isChopped, bool isCOD) async {
    try {
      // add product to db
      final auth = FirebaseAuth.instance;
      final db = FirebaseFirestore.instance;

      for (var element in model) {
        final code = Random().nextInt(9999);

        final order = {
          "address": address,
          "code": code,
          "customer": auth.currentUser!.uid,
          "name": auth.currentUser!.displayName,
          "seller": element.uid,
          "product": element.toMap(),
          "status": "Ordered",
          "quantity": element.weightage,
          "type": isChopped,
          "price": element.orderAmount,
          "payment": isCOD ? "COD" : "Card",
          "time": FieldValue.serverTimestamp(),
        };

        await db.collection("orders").add(order);
      }

      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<List<OrderModel>> getOrders() async {
    try {
      final auth = FirebaseAuth.instance;
      final db = FirebaseFirestore.instance;
      final List<OrderModel> orders = [];

      final value = await db
          .collection("orders")
          .where("customer", isEqualTo: auth.currentUser!.uid)
          .get();

      for (var element in value.docs) {
        orders.add(OrderModel.fromMap(element.data()));
      }

      return orders;
    } catch (e) {
      return [];
    }
  }
}
