import 'dart:convert';

import 'package:plasma_business/services/models/product_model.dart';

class OrderModel {
  final String? customer;
  final String? seller;
  final String? address;
  final int? code;
  final int? quantity;
  final int? price;
  final ProductModel? model;
  final String? status;
  String? id;
  final String? payment;
  final String? isChopped;

  OrderModel({
    this.payment,
    this.isChopped,
    this.customer,
    this.seller,
    this.status,
    this.address,
    this.code,
    this.quantity,
    this.price,
    this.model,
  });

  Map<String, dynamic> toMap() {
    return {
      'customer': customer,
      'seller': seller,
      'address': address,
      'code': code,
      'quantity': quantity,
      'price': price,
      'status': status,
      'model': model?.toMap(),
    };
  }

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      customer: map['customer'],
      seller: map['seller'],
      address: map['address'],
      code: map['code'],
      status: map['status'] ?? "Ordered",
      quantity: map['quantity'],
      payment: map['payment'],
      isChopped: map['type'],
      price: map['price'],
      model:
          map['product'] != null ? ProductModel.fromMap(map['product']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderModel.fromJson(String source) =>
      OrderModel.fromMap(json.decode(source));
}
