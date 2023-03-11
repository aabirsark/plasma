import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:iconsax/iconsax.dart';
import 'package:plasma/services/models/product_model.dart';
import 'package:plasma/views/widgets/primary_button.widget.dart';
import 'package:plasma/views/widgets/product_card_horz.widget.dart';

class CheckOutCart extends HookWidget {
  const CheckOutCart({super.key, required this.products});

  final List<ProductModel> products;

  @override
  Widget build(BuildContext context) {
    final totalPrice = useState(0);

    useEffect(() {
      for (var element in products) {
        totalPrice.value += element.price!.ceil();
      }

      return null;
    }, []);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Checkout"),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: PrimaryButton(
          callback: () {},
          customWidget: const Center(
            child: Text(
              "Order now",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
      body: products.isEmpty
          ? const Center(
              child: Text("No Data"),
            )
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        const Text(
                          "ADDRESS",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const Spacer(),
                        IconButton(
                            onPressed: () {}, icon: const Icon(Iconsax.edit))
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const Text("120 lane,mountain view, San fransico "),
                    const SizedBox(
                      height: 15,
                    ),
                    const Divider(
                      color: Colors.black,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const Text(
                      "ORDER DETAIL",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        const Text("products"),
                        const Spacer(),
                        Text("${products.length} qt.")
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        const Text("price"),
                        const Spacer(),
                        Text("Rs. ${totalPrice.value}")
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        const Text(
                          "Total Price",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        const Spacer(),
                        Text(
                          "Rs. ${totalPrice.value}",
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const Divider(
                      color: Colors.black,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const Text(
                      "PRODUCTS",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: products.length,
                      itemBuilder: (context, index) =>
                          ProductCardHorz(model: products[index]),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
