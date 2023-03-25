import 'package:flutter/material.dart';
import 'package:plasma/services/models/shop_info.model.dart';
import 'package:plasma/views/shop_info.page.dart';

class ShopInfoCard extends StatelessWidget {
  const ShopInfoCard({
    Key? key,
    required this.shop,
  }) : super(key: key);

  final ShopInfoModel shop;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ShopInfoPage(model: shop),
            ));
      },
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
                image: NetworkImage(
                  shop.banner!,
                ),
                fit: BoxFit.cover)),
        height: 200,
        alignment: Alignment.bottomCenter,
        child: Container(
          color: Colors.black45,
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                (shop.shop ?? "").toUpperCase(),
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                shop.about ?? "",
                maxLines: 3,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 12, color: Colors.white),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                shop.address ?? "",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 9, color: Colors.grey.shade100),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
