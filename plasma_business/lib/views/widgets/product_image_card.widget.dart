import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:plasma_business/services/models/product_model.dart';



class ProductImageCard extends HookWidget {
  const ProductImageCard({
    Key? key,
    required this.productModel,
  }) : super(key: key);

  final ProductModel productModel;

  @override
  Widget build(BuildContext context) {
    final currentImage = useState(productModel.images![0]);

    return SizedBox(
      height: 250,
      child: productModel.images!.length == 1
          ? Image.network(productModel.images![0])
          : Row(
              children: [
                Expanded(
                    child: InteractiveViewer(
                        child: Center(
                            child: Hero(
                  tag: productModel.images![0],
                  child: Image.network(currentImage.value),
                )))),
                const SizedBox(
                  width: 2,
                ),
                SizedBox(
                  child: Column(
                    children: productModel.images!
                        .map((e) => Expanded(
                                child: AspectRatio(
                              aspectRatio: 1,
                              child: GestureDetector(
                                onTap: () {
                                  currentImage.value = e;
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.white)),
                                  child: Image.network(
                                    e,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            )))
                        .toList(),
                  ),
                )
              ],
            ),
    );
  }
}
