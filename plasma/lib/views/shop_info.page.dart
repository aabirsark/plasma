import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:plasma/services/models/shop_info.model.dart';
import 'package:plasma/views/widgets/primary_button.widget.dart';

class ShopInfoPage extends StatelessWidget {
  const ShopInfoPage({super.key, required this.model});

  final ShopInfoModel model;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Shop Info"),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 300,
              color: Colors.grey.shade200,
              child: Hero(
                tag: model.banner!,
                child: Image.network(
                  model.banner!,
                  fit: BoxFit.cover,
                ),
              ),
            ),
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
                  Text(
                    (model.shop ?? "").toUpperCase(),
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    model.about ?? "",
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Text(
                    "Address",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(model.address ?? ""),
                  const SizedBox(
                    height: 30,
                  ),
                  const Text(
                    "Phone",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      const Icon(Iconsax.call),
                      const SizedBox(
                        width: 15,
                      ),
                      Text(model.phone ?? "<-- No Number -->")
                    ],
                  ),
                  const SizedBox(
                    height: 60,
                  ),
                  PrimaryButton(
                    callback: () {},
                    customWidget: const Text(
                      "Contact Shop",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(
                    height: 60,
                  ),
                ],
              ),
            )
          ],
        ),
      )),
    );
  }
}
