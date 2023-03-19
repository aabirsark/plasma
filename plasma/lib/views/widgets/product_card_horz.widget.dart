import 'package:flutter/material.dart';
import 'package:plasma/services/models/product_model.dart';
import 'package:plasma/views/product_info.page.dart';
import 'package:plasma/views/widgets/custom_chip.widget.dart';

class ProductCardHorz extends StatelessWidget {
  const ProductCardHorz({
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
        padding: const EdgeInsets.symmetric(vertical: 15.0),
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(color: Colors.black.withOpacity(0.1)))),
        child: Row(
          children: [
            Container(
                clipBehavior: Clip.antiAlias,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(10)),
                width: 105,
                height: 85,
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
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Rs. ${model.orderAmount?.ceil()}",
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          model.product ?? "",
                          style: const TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        const Text(
                          "2.5 Km away",
                          maxLines: 4,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 12, color: Colors.black38),
                        )
                      ],
                    ),
                    const Spacer(),
                    const SizedBox(
                      width: 5,
                    ),
                    Transform.scale(
                        scale: 0.9,
                        child: CustomChip(label: "${model.weightage} gm"))
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
