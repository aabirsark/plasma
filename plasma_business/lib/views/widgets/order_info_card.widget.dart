import 'package:flutter/material.dart';
import 'package:plasma_business/services/db/order_db.service.dart';
import 'package:plasma_business/services/models/order.model.dart';
import 'package:plasma_business/views/order_info.page.dart';

class OrderInfoCard extends StatelessWidget {
  const OrderInfoCard({
    Key? key,
    required this.order,
  }) : super(key: key);

  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => OrderInfoPage(
                order: order,
              ),
            ));
      },
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
        child: Row(
          children: [
            Container(
              height: 85,
              width: 105,
              clipBehavior: Clip.antiAlias,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(10)),
              child: Image.network(
                order.model!.images![0],
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${order.quantity} gm of ${order.model!.product}",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const CircleAvatar(
                        backgroundColor: Colors.orange,
                        radius: 5,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(order.status ?? "")
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    order.address ?? "",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 12, color: Colors.black54),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
