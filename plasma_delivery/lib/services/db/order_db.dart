import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:plasma_delivery/services/models/order_model.dart';

class OrderDBFnctions {
  static Future<OrderResponse> getOrders() async {
    try {
      final db = FirebaseFirestore.instance;
      final auth = FirebaseAuth.instance;
      final List<OrderModel> orders = [];
      final List<OrderModel> pickUpOrder = [];

      final picked = await db
          .collection("orders")
          .where("status", isEqualTo: "Picked")
          .where("deliveryPhone", isEqualTo: auth.currentUser?.phoneNumber)
          .get();

      final ordered = await db
          .collection("orders")
          .where("status", isEqualTo: "Ordered")
          .get();

      for (var element in picked.docs) {
        final order = OrderModel.fromMap(element.data());
        order.id = element.id;
        pickUpOrder.add(order);
      }

      for (var element in ordered.docs) {
        final order = OrderModel.fromMap(element.data());
        order.id = element.id;
        orders.add(order);
      }

      return OrderResponse(picked: pickUpOrder, ordered: orders);
    } catch (e) {
      return OrderResponse(picked: [], ordered: []);
    }
  }

  static Future<bool> pickUpOrder(String id) async {
    try {
      final db = FirebaseFirestore.instance;
      final auth = FirebaseAuth.instance;

      await db.collection("orders").doc(id).update({
        "status": "Picked",
        "deliveryPhone": auth.currentUser?.phoneNumber,
        "pickup_at": FieldValue.serverTimestamp()
      });

      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> deliverOrder(String id) async {
    try {
      final db = FirebaseFirestore.instance;

      await db.collection("orders").doc(id).update({
        "status": "Delivered",
        "delivered_at": FieldValue.serverTimestamp()
      });

      return true;
    } catch (e) {
      return false;
    }
  }
}

class OrderResponse {
  final List<OrderModel> picked;
  final List<OrderModel> ordered;

  OrderResponse({required this.picked, required this.ordered});
}
