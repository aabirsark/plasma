import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:plasma_business/views/pages/home.page.dart';
import 'package:plasma_business/views/pages/order.page.dart';
import 'package:plasma_business/views/pages/shop_info.page.dart';
import 'package:plasma_business/views/widgets/coming_soon.widget.dart';

const String appname = "PLASMA";

const onboardingBanner =
    "https://images.unsplash.com/photo-1601599561213-832382fd07ba?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=464&q=80";

// fonts to be used
final String? primaryFont = GoogleFonts.raleway().fontFamily;
final String? headerFont = GoogleFonts.orbitron().fontFamily;

// colors
const Color primaryColor = Colors.amber;

// tabs
class Tabs {
  final Widget page;
  final String label;
  final int id;
  final IconData icon;

  Tabs(this.page, this.label, this.id, this.icon);
}

List<Tabs> tabs = [
  Tabs(const HomePage(), "Product", 0, Iconsax.box),
  Tabs(const OrdersPage(), "Orders", 1, Iconsax.activity),
  Tabs(const ComingSoon(), "Earnings", 2, Iconsax.money),
  Tabs(const ShopInfoPage(), "Shop info", 3, Iconsax.shop),
];

// stripe keys
const String stripeSecretKey =
    "sk_test_51MbQ0lSE59RYsI4gpgFlEirxSJaqqXLxg7hwJLs7P6CAB3LPnzH5nEehXEu3KwnX3kBwszdaHtdGkWJfRyEICBpV008qQJ6QHy";
const String publishableKey =
    "pk_test_51MbQ0lSE59RYsI4g2FaiNx1E3UK7TuDEkWyyl6kECKFZPCBurnECmZiLw4yZX5GAanewGNEjja0cGfiiZAGDVJTY00DS8vQ1Rn";
