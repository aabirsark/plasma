import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plasma_business/app/constants.dart';
import 'package:plasma_business/services/db/order_db.service.dart';
import 'package:plasma_business/views/widgets/order_info_card.widget.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  bool isLoading = true;
  OrderInfo? order;

  @override
  void initState() {
    super.initState();
    OrderDBFnctions.getOrders().then((value) {
      setState(() {
        isLoading = false;
        order = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          toolbarHeight: 80,
          scrolledUnderElevation: 0.0,
          automaticallyImplyLeading: false,
          title: const Text("Orders")),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: Colors.black,
                strokeWidth: 2,
              ),
            )
          : order != null
              ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Column(
                    children: [
                      SizedBox(
                        child: Row(
                          children: [
                            _orderInfo(
                                number: order?.pendingOrder ?? 0,
                                label: "Pending Orders"),
                            _orderInfo(
                                number: order?.deliverdOrder ?? 0,
                                label: "Orders deliverd"),
                            _orderInfo(
                                number: order?.orders.length ?? 0,
                                label: "Total Orders"),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Expanded(
                          child: ListView.builder(
                        itemCount: order?.orders.length ?? 0,
                        itemBuilder: (context, index) => OrderInfoCard(
                          order: order!.orders[index],
                        ),
                      ))
                    ],
                  ),
                )
              : const Center(
                  child: Text("Can't contact the servers"),
                ),
    );
  }

  Expanded _orderInfo({required int number, required String label}) {
    return Expanded(
        child: Column(
      children: [
        Text(
          number.toString(),
          style: TextStyle(
              fontSize: 50,
              fontWeight: FontWeight.bold,
              fontFamily: GoogleFonts.montserrat().fontFamily),
        ),
        Text(
          label,
          style: const TextStyle(fontSize: 12),
        )
      ],
    ));
  }
}
