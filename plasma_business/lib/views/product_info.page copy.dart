import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:iconsax/iconsax.dart';
import 'package:plasma_business/services/db/product_functions.db.dart';
import 'package:plasma_business/services/models/product_model.dart';
import 'package:plasma_business/views/create_product.page.dart';
import 'package:plasma_business/views/widgets/coming_soon.widget.dart';
import 'package:plasma_business/views/widgets/custom_chip.widget.dart';
import 'package:plasma_business/views/widgets/primary_button.widget.dart';
import 'package:plasma_business/views/widgets/product_image_card.widget.dart';

class ProductInfoPage extends HookWidget {
  const ProductInfoPage({super.key, required this.productModel});

  final ProductModel productModel;

  @override
  Widget build(BuildContext context) {
    final isloading = useState(false);
    final selectedQantity = useState(250);
    final price = useState(productModel.price!.ceil());

    useEffect(() {
      price.value =
          ((productModel.price!.ceil() / 250) * selectedQantity.value).toInt();
      return;
    }, [selectedQantity.value]);

    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ProductImageCard(productModel: productModel),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Text(
                          "Rs. ${price.value}",
                          style: const TextStyle(fontSize: 40),
                        ),
                        const Spacer(),
                        CustomChip(
                          label: "${selectedQantity.value} gm",
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      productModel.product ?? "",
                      style: const TextStyle(
                          fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      productModel.about ?? "",
                      style: const TextStyle(color: Colors.black),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const Text(
                      "deliverd between 16:00 - 20:00",
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: PrimaryButton(
                            callback: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CreateProduct(model: productModel),
                                  ));
                            },
                            customWidget: const Text(
                              "Edit Product",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Tooltip(
                          message: "Delete Product",
                          child: InkWell(
                            onTap: () {
                              if (!isloading.value) {
                                isloading.value = true;
                                ProductFuctions.deleteProduct(productModel.id!)
                                    .then((value) {
                                  isloading.value = false;
                                  Navigator.pop(context);
                                });
                              }
                            },
                            child: Container(
                              height: 60,
                              width: 60,
                              decoration: BoxDecoration(
                                  color: Colors.grey.shade200,
                                  borderRadius: BorderRadius.circular(20)),
                              child: Center(
                                child: isloading.value
                                    ? const CircularProgressIndicator(
                                        color: Colors.black,
                                        strokeWidth: 2,
                                      )
                                    : const Icon(Iconsax.trash),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
