import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:plasma_business/services/models/product_model.dart';

class ProductFuctions {
  static Future addProduct(String name, String descriptions, double price,
      List<dynamic> images) async {
    try {
      final db = FirebaseFirestore.instance;
      final auth = FirebaseAuth.instance.currentUser;

      final storeInfo = <String, dynamic>{
        "product": name,
        "about": descriptions,
        "price": price,
        "image": images,
        "author": auth?.displayName,
        "uid": auth?.uid
      };

      await db.collection("products").add(storeInfo);

      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  static Future uploadImages(List<String> images) async {
    List<String> files = [];
    try {
      for (var element in images) {
        final storageRef = FirebaseStorage.instance.ref();

        final mountainsRef =
            storageRef.child("store/banner/${DateTime.now().millisecond}.jpg");

        await mountainsRef.putFile(File(element));

        files.add(await mountainsRef.getDownloadURL());
      }

      return files;
    } catch (e) {
      print(e);
      return files;
    }
  }

  static Future<List<ProductModel>?> getProducts() async {
    try {
      final db = FirebaseFirestore.instance;
      final auth = FirebaseAuth.instance.currentUser;

      final List<ProductModel> products = [];

      final value = await db
          .collection("products")
          .where("uid", isEqualTo: auth?.uid)
          .get();

      for (var element in value.docs) {
        products.add(ProductModel.fromMap(element.data())..id = element.id);
      }

      return products;
    } catch (e) {
      print(e);
      return null;
    }
  }

  static Future<bool> deleteProduct(String id) async {
    try {
      final db = FirebaseFirestore.instance;

      final value = await db.collection("products").doc(id).delete();

      return true;
    } catch (e) {
      return false;
    }
  }
}
