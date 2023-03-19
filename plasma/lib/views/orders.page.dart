import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:iconsax/iconsax.dart';
import 'package:plasma/app/constants.dart';
import 'package:plasma/services/models/order.model.dart';
import 'package:plasma/views/widgets/custom_icon_chip.widget.dart';
import 'package:plasma/views/widgets/custom_stepper.widget.dart';
import 'package:plasma/views/widgets/order_card.widget.dart';
import 'package:qr_flutter/qr_flutter.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key, required this.order});

  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              OrderCard(
                orders: order,
              ),
              const SizedBox(
                height: 30,
              ),
              const Text(
                "ORDER DETAILS",
                style: TextStyle(fontSize: 25),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  const Text("Seller"),
                  const Spacer(),
                  Text(order.seller ?? "<< NO DATA >>")
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  const Text("Weightage"),
                  const Spacer(),
                  Text("${order.quantity} gm")
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  const Text("Billing Address"),
                  const Spacer(),
                  Text("${order.address}")
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  const Text(
                    "Price",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  Text(
                    "Rs. ${order.price} only",
                    style: const TextStyle(fontSize: 20),
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const Divider(),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                    child: CustomIconChip(
                      icon: Iconsax.password_check,
                      label: "Order Code",
                      callback: () {
                        showDialog(
                          context: context,
                          builder: (context) => _orderCode(context),
                        );
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: CustomIconChip(
                      icon: Icons.qr_code,
                      label: "QR Code",
                      callback: () {
                        showDialog(
                          context: context,
                          builder: (context) => _orderQrCode(context),
                        );
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 50,
              ),
              const Text(
                "ORDER STATUS",
                style: TextStyle(fontSize: 25),
              ),
              const SizedBox(
                height: 20,
              ),
              CustomStepper(status: order.status!),
              const SizedBox(
                height: 30,
              )
            ],
          ),
        ),
      ),
    );
  }

  Center _orderQrCode(BuildContext context) {
    return Center(
      child: Material(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
          ),
          width: MediaQuery.of(context).size.width * 0.7,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text("Your Order QR Code"),
              const SizedBox(
                height: 10,
              ),
              QrImage(
                data: order.code.toString(),
              )
            ],
          ),
        ),
      ),
    );
  }

  Center _orderCode(BuildContext context) {
    return Center(
      child: Material(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
          ),
          width: MediaQuery.of(context).size.width * 0.7,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text("Your Order Code"),
              const SizedBox(
                height: 10,
              ),
              Text(
                order.code.toString(),
                style:
                    const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
      ),
    );
  }
}
