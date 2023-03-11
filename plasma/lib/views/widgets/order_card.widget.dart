import 'package:flutter/material.dart';
import 'package:plasma/services/models/order.model.dart';
import 'package:plasma/views/widgets/custom_chip.widget.dart';

class OrderCard extends StatelessWidget {
  const OrderCard({
    Key? key,
    required this.orders,
  }) : super(key: key);

  final OrderModel orders;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        children: [
          SizedBox(width: 120, child: Image.network(orders.model!.images![0])),
          const SizedBox(
            width: 15,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  orders.model!.product ?? "",
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(
                  "Rs. ${orders.price!} ",
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "Order Code : ${orders.code!} ",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    const CircleAvatar(
                      radius: 5,
                      backgroundColor: Colors.amber,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      orders.status ?? "ordered",
                      style: const TextStyle(
                          fontSize: 12, fontWeight: FontWeight.bold),
                    )
                  ],
                )
              ],
            ),
          ),
          CustomChip(
              label: orders.quantity! < 1000
                  ? "${orders.quantity!} gm"
                  : "${orders.quantity! / 1000} Kg")
        ],
      ),
    );
  }
}
