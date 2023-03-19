import 'package:flutter/material.dart';
import 'package:plasma/app/constants.dart';
import 'package:plasma/services/models/product_model.dart';
import 'package:plasma/views/product_info.page.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    Key? key,
    required this.product,
  }) : super(key: key);

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductInfoPage(productModel: product),
            ));
      },
      child: Container(
        margin: const EdgeInsets.all(8.0),
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.grey.shade50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
                alignment: Alignment.center,
                child: Container(
                    clipBehavior: Clip.antiAlias,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(10)),
                    height: 120,
                    width: double.maxFinite,
                    child: Hero(
                      tag: product.images![0],
                      child: Image.network(
                        product.images![0],
                        fit: BoxFit.cover,
                      ),
                    ))),
            const SizedBox(
              height: 12,
            ),
            Row(
              children: [
                Text(
                  "Rs. ${product.price!.ceil()}",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const Spacer(),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6),
                  decoration: ShapeDecoration(
                      shape: const StadiumBorder(),
                      color: primaryColor.withOpacity(0.3)),
                  child: const Text(
                    "500 gm",
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 3,
            ),
            Text(
              product.product ?? "",
              style: const TextStyle(
                fontSize: 16,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(
              height: 3,
            ),
            const Text(
              "2.0 km away ",
              style: TextStyle(fontSize: 12, color: Colors.grey),
            )
          ],
        ),
      ),
    );
  }
}


//TODO:
/// => checkout
/// => opt. b/w chopped and whole
/// => Wishlist
/// => Orders page
/// => 3 apps main app, delivery app, store app
/// => progress
/// => Map
/// => Search