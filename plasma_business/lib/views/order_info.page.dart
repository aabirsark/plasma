import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:plasma_business/services/models/order.model.dart';
import 'package:plasma_business/views/widgets/order_code_bottom.widget.dart';
import 'package:plasma_business/views/widgets/primary_button.widget.dart';
import 'package:plasma_business/views/widgets/product_card.widget.dart';

class OrderInfoPage extends StatelessWidget {
  const OrderInfoPage({super.key, required this.order});

  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
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
                    "Product Price", "Rs. ${order.model?.price?.ceil()}"),
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
      padding: const EdgeInsets.symmetric(vertical: 4.0),
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
