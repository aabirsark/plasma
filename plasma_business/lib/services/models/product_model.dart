import 'dart:convert';

import 'package:flutter/foundation.dart';

class ProductModel {
  final List<dynamic>? images;
  final String? product;
  final String? author;
  final String? about;
  final double? price;
  final String? uid;
  String? id;

  ProductModel({
    required this.images,
    this.uid,
    required this.product,
    required this.author,
    required this.about,
    this.price,
  });

  Map<String, dynamic> toMap() {
    return {
      'images': images,
      'product': product,
      'author': author,
      'about': about,
      'price': price,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      images: map['image'],
      product: map['product'],
      author: map['author'],
      about: map['about'],
      price: map['price'],
      uid: map['uid'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductModel.fromJson(String source) =>
      ProductModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ProductModel(images: $images, product: $product, author: $author, about: $about, price: $price)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ProductModel &&
        listEquals(other.images, images) &&
        other.product == product &&
        other.author == author &&
        other.about == about &&
        other.price == price;
  }

  @override
  int get hashCode {
    return images.hashCode ^
        product.hashCode ^
        author.hashCode ^
        about.hashCode ^
        price.hashCode;
  }
}
