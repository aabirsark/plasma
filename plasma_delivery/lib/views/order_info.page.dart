import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:plasma_delivery/services/db/order_db.dart';

import 'package:plasma_delivery/services/models/order_model.dart';
import 'package:plasma_delivery/views/widgets/order_code_bottom.widget.dart';
import 'package:plasma_delivery/views/widgets/primary_button.widget.dart';
import 'package:plasma_delivery/views/widgets/product_card.widget.dart';

class OrderInfoPage extends HookWidget {
  const OrderInfoPage({super.key, required this.order});

  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    final isLoading = useState(false);

    return Scaffold(
      appBar: AppBar(),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(12.0),
        child: order.status == "Ordered"
            ? PrimaryButton(
                callback: () {
                  if (!isLoading.value) {
                    isLoading.value = true;
                    OrderDBFnctions.pickUpOrder(order.id!).then((value) {
                      isLoading.value = false;
                      Navigator.pop(context);
                    });
                  }
                },
                customWidget: isLoading.value
                    ? const CircularProgressIndicator(
                        color: Colors.black,
                        strokeWidth: 2,
                      )
                    : const Text(
                        "Pick Up",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
              )
            : Row(
                children: [
                  Expanded(
                    child: PrimaryButton(
                      customWidget: const Text(
                        "Cancel & Refund",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      callback: () {},
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: PrimaryButton(
                      customWidget: const Text(
                        "Confirm Delivery",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      callback: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          builder: (context) => OrderCodeBottomSheet(
                            order: order,
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ProductCard(model: order.model!),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Order Details",
                  style: TextStyle(fontSize: 24),
                ),
                const SizedBox(
                  height: 20,
                ),
                _orderDetail("Customer Id", "${order.customer}"),
                const Divider(),
                _orderDetail("Address", order.address ?? ""),
                const Divider(),
                _orderDetail(
                    "Quantity",
                    order.quantity! < 1000
                        ? ' ${order.quantity} gm'
                        : '${order.quantity! / 10000} Kg'),
                const Divider(),
                _orderDetail(
                    "Order Type", order.isChopped! ? "Chopped" : "Whole"),
                const Divider(),
                _orderDetail(
                    "Product Price", "Rs. ${order.model?.price?.ceil()}"),
                const Divider(),
                _orderDetail("Product Price",
                    "Rs. ${(order.model!.price! * (order.quantity! / 250)).ceil()}"),
                const Divider(),
                _orderDetail("Delivery Charge", "Rs. 20"),
                const Divider(),
                _orderDetail("Total Amount", "Rs. ${order.price}"),
                const SizedBox(
                  height: 40,
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _orderDetail(String label, String detail) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          const Spacer(),
          Expanded(
              child: Text(
            detail,
            textAlign: TextAlign.right,
            style: const TextStyle(fontSize: 15),
          ))
        ],
      ),
    );
  }
}
