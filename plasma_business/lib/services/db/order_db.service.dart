import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:plasma_business/services/models/order.model.dart';

class OrderDBFnctions {
  static Future<OrderInfo?> getOrders() async {
    try {
      final auth = FirebaseAuth.instance;
      final db = FirebaseFirestore.instance;
      final List<OrderModel> orders = [];
      int pendingOrder = 0;
      int deliveredOrder = 0;

      final value = await db
          .collection("orders")
          .where("seller", isEqualTo: auth.currentUser!.uid)
          .get();

      for (var element in value.docs) {
        final order = OrderModel.fromMap(element.data());
        order.id = element.id;
        orders.add(order);

        if (order.status?.toLowerCase() == "ordered") {
          pendingOrder++;
        } else if (order.status?.toLowerCase() == "delivered") {
          deliveredOrder++;
        }
      }

      return OrderInfo(
          orders: orders,
          pendingOrder: pendingOrder,
          deliverdOrder: deliveredOrder);
    } catch (e) {
      return null;
    }
  }

  static Future<bool> deliverOrder(String id) async {
    try {
      final db = FirebaseFirestore.instance;

      await db.collection("orders").doc(id).update({"status": "delivered"});

      return true;
    } catch (e) {
      return false;
    }
  }
}

class OrderInfo {
  final List<OrderModel> orders;
  final int pendingOrder;
  final int deliverdOrder;

  OrderInfo(
      {required this.orders,
      required this.pendingOrder,
      required this.deliverdOrder});
}
