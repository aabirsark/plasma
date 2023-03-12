import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:iconsax/iconsax.dart';
import 'package:plasma/app/constants.dart';
import 'package:plasma/services/db/order_db.service.dart';
import 'package:plasma/services/db/user_info.service.dart';
import 'package:plasma/services/models/product_model.dart';
import 'package:plasma/services/payement_service/payment.serv.dart';
import 'package:plasma/views/widgets/order_confirmed.widget.dart';
import 'package:plasma/views/widgets/primary_button.widget.dart';
import 'package:plasma/views/widgets/product_card_horz.widget.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class CheckoutPage extends StatefulHookWidget {
  const CheckoutPage({super.key, required this.model, required this.quantity});

  final ProductModel model;
  final int quantity;

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  String? address;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    UserInfoDB.userAddress().then((value) {
      setState(() {
        isLoading = false;

        address = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final isPaymentProcessing = useState(false);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Checkout"),
      ),
      bottomNavigationBar: Visibility(
        visible: !isLoading,
        child: Padding(
          padding: const EdgeInsets.only(
              left: 8.0, right: 8.0, bottom: 16.0, top: 4),
          child: PrimaryButton(
            callback: () async {
              if (address != null) {
                isPaymentProcessing.value = true;

                try {
                  final payment =
                      ((widget.model.price! / 250) * widget.quantity).ceil() +
                          20;
                  await PaymentServ.payment(payment);
                  await Stripe.instance.presentPaymentSheet();

                  OrderDBFnctions.orderProduct(
                          address!, widget.quantity, payment, widget.model)
                      .then((value) {
                    if (value) {
                      Navigator.pushReplacement(
                          context,
                          CupertinoPageRoute(
                            builder: (context) => const OrderConfrimedPage(),
                          ));
                    }
                    isPaymentProcessing.value = false;
                  });
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text("Couldn't process the payment reason = $e"),
                    behavior: SnackBarBehavior.floating,
                  ));
                  isPaymentProcessing.value = false;
                }
              }
            },
            customWidget: isPaymentProcessing.value
                ? const CircularProgressIndicator(
                    color: Colors.black,
                    strokeWidth: 2,
                  )
                : const Text(
                    "Order Now",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
          ),
        ),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: Colors.black,
                strokeWidth: 2,
              ),
            )
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
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
                            onPressed: () {
                              showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                backgroundColor: Colors.white,
                                builder: (context) => AddressBottomSheet(
                                  address: address,
                                ),
                              ).then((value) {
                                if (value != null || value != address) {
                                  address = value;
                                  UserInfoDB.setUsersAddress(address!);
                                  setState(() {});
                                }
                              });
                            },
                            icon: const Icon(Iconsax.edit))
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(address ?? "<< NO DATA >>"),
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
                      height: 12,
                    ),
                    Row(
                      children: [
                        const Text("seller"),
                        const Spacer(),
                        Text("${widget.model.author}")
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        const Text("quantity"),
                        const Spacer(),
                        Text("${widget.quantity} gm")
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        const Text("price"),
                        const Spacer(),
                        Text(
                            "Rs. ${((widget.model.price! / 250) * widget.quantity).ceil()}")
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: const [
                        Text("delivery"),
                        Spacer(),
                        Text("Rs. 20")
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
                          "Rs. ${((widget.model.price! / 250) * widget.quantity).ceil() + 20}",
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
                    ProductCardHorz(model: widget.model),
                  ],
                ),
              ),
            ),
    );
  }
}

class AddressBottomSheet extends HookWidget {
  const AddressBottomSheet({
    this.address,
    Key? key,
  }) : super(key: key);

  final String? address;

  @override
  Widget build(BuildContext context) {
    final controller = useTextEditingController(text: address);

    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 1,
            width: 100,
            color: Colors.grey.shade300,
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: controller,
                  cursorColor: primaryColor,
                  maxLines: null,
                  decoration: const InputDecoration(
                      hintText: "Address",
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: primaryColor)),
                      helperText: "Add your precise address"),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              IconButton(
                  onPressed: () {
                    Navigator.pop(context, controller.text);
                  },
                  icon: const Icon(Icons.done))
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          SizedBox(
            height: MediaQuery.of(context).viewInsets.bottom,
          )
        ],
      ),
    );
  }
}
