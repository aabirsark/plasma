import 'package:flutter/material.dart';
import 'package:plasma_business/services/models/product_model.dart';
import 'package:plasma_business/views/product_info.page%20copy.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    Key? key,
    required this.model,
  }) : super(key: key);

  final ProductModel model;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductInfoPage(
                productModel: model,
              ),
            ));
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.only(bottom: 20.0, top: 10),
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(color: Colors.black.withOpacity(0.1)))),
        child: Row(
          children: [
            Container(
                height: 120,
                width: 120,
                clipBehavior: Clip.antiAlias,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(10)),
                child: Hero(
                    tag: model.images![0],
                    child: Image.network(
                      model.images![0],
                      fit: BoxFit.cover,
                    ))),
            const SizedBox(
              width: 20,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Rs. ${model.price!.ceil()}",
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      model.product ?? "",
                      style: const TextStyle(
                        fontSize: 25,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      model.about ?? "",
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                      style:
                          const TextStyle(fontSize: 12, color: Colors.black38),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
