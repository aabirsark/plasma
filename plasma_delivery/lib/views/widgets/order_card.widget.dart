import 'package:flutter/material.dart';

import 'package:plasma_delivery/services/models/order_model.dart';
import 'package:plasma_delivery/views/order_info.page.dart';
import 'package:plasma_delivery/views/widgets/custom_chip.widget.dart';

class OrderCard extends StatelessWidget {
  const OrderCard({
    Key? key,
    required this.orders,
  }) : super(key: key);

  final OrderModel orders;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => OrderInfoPage(order: orders),
            ));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: Row(
          children: [
            Container(
                width: 105,
                height: 85,
                clipBehavior: Clip.antiAlias,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(10)),
                child: Image.network(
                  orders.model!.images![0],
                  fit: BoxFit.cover,
                )),
            const SizedBox(
              width: 15,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Rs. ${orders.price?.ceil()} ",
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    orders.model!.product ?? "",
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    orders.address ?? "",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 12),
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
                        orders.status ?? "Ordered",
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
      ),
    );
  }
}
