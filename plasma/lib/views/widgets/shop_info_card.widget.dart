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
        color: Colors.grey.shade50,
        height: 200,
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            SizedBox(
              width: 120,
              child:
                  Hero(tag: shop.banner!, child: Image.network(shop.banner!)),
            ),
            const SizedBox(
              width: 20,
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    (shop.shop ?? "").toUpperCase(),
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    shop.about ?? "",
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const Text(
                    "Address",
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    shop.address ?? "",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
