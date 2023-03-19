import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:plasma/services/models/product_model.dart';
import 'package:plasma/services/models/shop_info.model.dart';

class ProductsAndStoreFunctions {
  static Future<List<ProductModel>?> getProducts() async {
    try {
      final db = FirebaseFirestore.instance;

      final List<ProductModel> products = [];

      final value = await db
          .collection("products")
          .get(const GetOptions(source: Source.serverAndCache));

      for (var element in value.docs) {
        products.add(ProductModel.fromMap(element.data()));
      }

      return products;
    } catch (e) {
      return null;
    }
  }

  static Future<List<ShopInfoModel>?> getShops() async {
    try {
      final db = FirebaseFirestore.instance;

      final List<ShopInfoModel> products = [];

      final value = await db
          .collection("stores")
          .get(const GetOptions(source: Source.serverAndCache));

      for (var element in value.docs) {
        products.add(ShopInfoModel.fromMap(element.data()));
      }

      return products;
    } catch (e) {
      return null;
    }
  }

  static Future<HomeRespose> getHomeData() async {
    try {
      final products = await getProducts();
      final shops = await getShops();

      return HomeRespose(isError: false, products: products, shops: shops);
    } catch (e) {
      return HomeRespose(isError: true);
    }
  }

  // add to cart
  static Future addToCart(
      ProductModel model, int weight, double orderAmount) async {
    try {
      final db = FirebaseFirestore.instance;
      final auth = FirebaseAuth.instance;

      final cartItem = model.toMap();

      cartItem['weightage'] = weight;
      cartItem['orderAmount'] = orderAmount;

      await db
          .collection("users")
          .doc(auth.currentUser!.uid)
          .collection("cart")
          .add(cartItem);

      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<List<ProductModel>?> getCartItems() async {
    try {
      final db = FirebaseFirestore.instance;
      final auth = FirebaseAuth.instance;
      final List<ProductModel> items = [];

      final value = await db
          .collection("users")
          .doc(auth.currentUser!.uid)
          .collection("cart")
          .get();

      for (var element in value.docs) {
        items.add(ProductModel.fromMap(element.data())..id = element.id);
      }

      return items;
    } catch (e) {
      return null;
    }
  }

  static Future<bool> delCartItem(String docId) async {
    try {
      final db = FirebaseFirestore.instance;
      final auth = FirebaseAuth.instance;

      final value = await db
          .collection("users")
          .doc(auth.currentUser!.uid)
          .collection("cart")
          .doc(docId)
          .delete();

      return true;
    } catch (e) {
      return false;
    }
  }
}

class HomeRespose {
  final bool isError;
  final List<ProductModel>? products;
  final List<ShopInfoModel>? shops;

  HomeRespose({required this.isError, this.products, this.shops});
}
