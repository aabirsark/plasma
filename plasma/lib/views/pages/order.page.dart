import 'package:flutter/material.dart';
import 'package:plasma/services/db/order_db.service.dart';
import 'package:plasma/services/models/order.model.dart';
import 'package:plasma/views/widgets/order_card.widget.dart';

class OrdersTab extends StatefulWidget {
  const OrdersTab({super.key});

  @override
  State<OrdersTab> createState() => _OrdersTabState();
}

class _OrdersTabState extends State<OrdersTab> {
  bool isloading = true;
  List<OrderModel> orders = [];

  @override
  void initState() {
    super.initState();
    OrderDBFnctions.getOrders().then((value) {
      setState(() {
        orders = value;
        isloading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        title: const Text("ORDERS"),
      ),
      body: isloading
          ? const Center(
              child: CircularProgressIndicator(
                color: Colors.black,
                strokeWidth: 3,
              ),
            )
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: ListView.builder(
                itemCount: orders.length,
                itemBuilder: (context, index) =>
                    OrderCard(orders: orders[index]),
              ),
            ),
    );
  }
}
