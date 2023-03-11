import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserInfoDB {
  static Future<String?> userAddress() async {
    try {
      final db = FirebaseFirestore.instance;
      final auth = FirebaseAuth.instance;

      final value =
          await db.collection("users").doc(auth.currentUser!.uid).get();

      return value.data()?['address'];
    } catch (e) {
      return null;
    }
  }

  static Future<bool> setUsersAddress(String address) async {
    try {
      final db = FirebaseFirestore.instance;
      final auth = FirebaseAuth.instance;

      await db
          .collection("users")
          .doc(auth.currentUser!.uid)
          .set({"address": address});

      return true;
    } catch (e) {
      return false;
    }
  }
}
