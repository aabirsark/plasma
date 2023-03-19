import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:iconsax/iconsax.dart';
import 'package:plasma/app/constants.dart';
import 'package:plasma/services/db/products.service.db.dart';
import 'package:plasma/services/models/product_model.dart';
import 'package:plasma/views/check_out.single.page.dart';
import 'package:plasma/views/widgets/custom_chip.widget.dart';
import 'package:plasma/views/widgets/primary_button.widget.dart';
import 'package:plasma/views/widgets/product_image_card.widget.dart';

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
                    const Text(
                      "Select quantity",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Wrap(
                      spacing: 5,
                      runSpacing: 5,
                      children: weightage
                          .map((e) => CustomChip(
                                callback: () {
                                  selectedQantity.value = e;
                                },
                                label: e < 1000 ? "$e gm" : "${e / 1000} Kg",
                                color: selectedQantity.value == e
                                    ? primaryColor.withOpacity(0.3)
                                    : Colors.grey.shade100,
                              ))
                          .toList(),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: PrimaryButton(
                            callback: () {},
                            customWidget: const Text(
                              "Order Now",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Tooltip(
                          message: "Add to cart",
                          child: InkWell(
                            onTap: () {
                              if (!isloading.value) {
                                isloading.value = true;
                                ProductsAndStoreFunctions.addToCart(
                                        productModel,
                                        selectedQantity.value,
                                        price.value.toDouble())
                                    .then((value) {
                                  isloading.value = false;
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                          behavior: SnackBarBehavior.floating,
                                          backgroundColor: Colors.black,
                                          content: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              value
                                                  ? const Icon(
                                                      Icons.done,
                                                      color: Colors.green,
                                                    )
                                                  : const Icon(
                                                      Iconsax.warning_2,
                                                      color: Colors.red,
                                                    ),
                                              const SizedBox(
                                                width: 20,
                                              ),
                                              Text(value
                                                  ? "Added to cart"
                                                  : "Some error occured! "),
                                              const Spacer(),
                                              if (!value)
                                                const Text(
                                                  "try again",
                                                  style: TextStyle(
                                                      color: primaryColor),
                                                )
                                            ],
                                          )));
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
                                    : const Icon(Iconsax.heart),
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
