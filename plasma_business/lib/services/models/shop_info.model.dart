import 'dart:convert';

class ShopInfoModel {
  final String? shop;
  final String? about;
  final String? address;
  String? phone;
  final String? banner;

  ShopInfoModel({this.shop, this.about, this.address, this.phone, this.banner});

  Map<String, dynamic> toMap() {
    return {
      'shop': shop,
      'About': about,
      'Address': address,
      'phone': phone,
      'Banner': banner,
    };
  }

  factory ShopInfoModel.fromMap(Map<String, dynamic> map) {
    return ShopInfoModel(
      shop: map['Store'],
      about: map['About'],
      address: map['Address'],
      phone: map['phone'],
      banner: map['Banner'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ShopInfoModel.fromJson(String source) =>
      ShopInfoModel.fromMap(json.decode(source));
}
