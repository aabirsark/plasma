import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:plasma_business/services/models/shop_info.model.dart';
import 'package:plasma_business/views/pages/shop_info.page.dart';

class ProfileFunctions {
  static Future setUp(
      String name, String address, String about, String bannerIcon) async {
    try {
      final db = FirebaseFirestore.instance;
      final auth = FirebaseAuth.instance.currentUser;

      final storeInfo = <String, dynamic>{
        "Store": name,
        "Address": address,
        "About": about,
        "Banner": bannerIcon,
        "phone": auth?.phoneNumber
      };

      auth?.updateDisplayName(name);

      await db.collection("stores").doc(auth!.uid).set(storeInfo);

      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  static Future uploadFile(File file) async {
    try {
      final storageRef = FirebaseStorage.instance.ref();

      final mountainsRef =
          storageRef.child("store/banner/${DateTime.now().millisecond}.jpg");

      await mountainsRef.putFile(file);

      return mountainsRef.getDownloadURL();
    } catch (e) {
      return null;
    }
  }

  static Future<ShopInfoModel?> getProfile() async {
    final db = FirebaseFirestore.instance;
    final auth = FirebaseAuth.instance.currentUser;
    ShopInfoModel? model;

    final value = await db.collection("stores").doc(auth!.uid).get();

    if (value.data() != null) {
      print(value.data());
      model = ShopInfoModel.fromMap(value.data()!);
      model.phone = auth.phoneNumber;
    }

    return model;
  }
}
