import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:iconsax/iconsax.dart';
import 'package:plasma/app/constants.dart';
import 'package:plasma/services/db/order_db.service.dart';
import 'package:plasma/services/db/user_info.service.dart';
import 'package:plasma/services/models/product_model.dart';
import 'package:plasma/services/payement_service/payment.serv.dart';
import 'package:plasma/views/check_out.single.page.dart';
import 'package:plasma/views/widgets/order_confirmed.widget.dart';
import 'package:plasma/views/widgets/primary_button.widget.dart';
import 'package:plasma/views/widgets/product_card_horz.widget.dart';

class CheckOutCart extends StatefulHookWidget {
  const CheckOutCart({super.key, required this.products});

  final List<ProductModel> products;

  @override
  State<CheckOutCart> createState() => _CheckOutCartState();
}

class _CheckOutCartState extends State<CheckOutCart> {
  @override
  Widget build(BuildContext context) {
    final totalPrice = useState(0);
    final ValueNotifier<String?> address = useState("");
    final isChopped = useState(true);
    final isPaymentProcessing = useState(false);
    final isCardPayment = useState(false);

    useEffect(() {
      for (var element in widget.products) {
        totalPrice.value += element.orderAmount!.ceil();
      }

      UserInfoDB.userAddress().then((value) {
        setState(() {
          address.value = value;
        });
      });

      return null;
    }, []);

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        scrolledUnderElevation: 0.0,
        title: const Text("Checkout"),
      ),
      bottomNavigationBar: _orderNow(address, isPaymentProcessing, totalPrice,
          isCardPayment, isChopped, context),
      body: widget.products.isEmpty
          ? const Center(
              child: Text("No Data"),
            )
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
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
                                  address: address.value,
                                ),
                              ).then((value) {
                                if (value != null && value != address) {
                                  address.value = value;
                                  UserInfoDB.setUsersAddress(address.value!);
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
                    Text(address.value ?? "<< NO DATA >>"),
                    const SizedBox(
                      height: 15,
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
                      height: 10,
                    ),
                    Row(
                      children: [
                        const Text("products"),
                        const Spacer(),
                        Text("${widget.products.length} qt.")
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        const Text("price"),
                        const Spacer(),
                        Text("Rs. ${totalPrice.value}")
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
                          "Rs. ${totalPrice.value + 20}",
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 35,
                    ),
                    const Text(
                      "FISH TYPE",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                            child: _buttonShip("assets/icons/chop.png",
                                isChopped.value, "Chopped", () {
                          isChopped.value = true;
                        })),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: _buttonShip("assets/icons/fish.png",
                              !isChopped.value, "Whole", () {
                            isChopped.value = false;
                          }),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 35,
                    ),
                    const Text(
                      "PAYMENT TYPE",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                            child: _buttonShip("assets/icons/credit.png",
                                isCardPayment.value, "Card", () {
                          isCardPayment.value = true;
                        })),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: _buttonShip("assets/icons/cash.png",
                              !isCardPayment.value, "Cash", () {
                            isCardPayment.value = false;
                          }),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const Text(
                      "PRODUCTS",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: widget.products.length,
                      itemBuilder: (context, index) =>
                          ProductCardHorz(model: widget.products[index]),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  Padding _orderNow(
      ValueNotifier<String?> address,
      ValueNotifier<bool> isPaymentProcessing,
      ValueNotifier<int> totalPrice,
      ValueNotifier<bool> isCardPayment,
      ValueNotifier<bool> isChopped,
      BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: PrimaryButton(
        callback: () async {
          if (address.value != null) {
            isPaymentProcessing.value = true;

            try {
              final payment = totalPrice.value + 20;

              if (!isCardPayment.value) {
                OrderDBFnctions.orderProduct(address.value!, payment,
                        widget.products, isChopped.value, isCardPayment.value)
                    .then((value) {
                  if (value) {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const OrderConfrimedPage(),
                        ));
                  }
                  isPaymentProcessing.value = false;
                });
                return;
              }

              await PaymentServ.payment(payment);
              await Stripe.instance.presentPaymentSheet();

              OrderDBFnctions.orderProduct(address.value!, payment,
                      widget.products, isChopped.value, isCardPayment.value)
                  .then((value) {
                if (value) {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const OrderConfrimedPage(),
                      ));
                }
                isPaymentProcessing.value = false;
              });
            } catch (e) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("Couldn't process the order"),
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
                "Order now",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
      ),
    );
  }

  Widget _buttonShip(
      String icon, bool isSelected, String label, VoidCallback callback) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: callback,
          child: Container(
            height: 55,
            width: double.maxFinite,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: isSelected ? primaryColor : Colors.black12,
                )),
            child: Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ImageIcon(
                    AssetImage(
                      icon,
                    ),
                    size: 30,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    label,
                    style: TextStyle(
                        fontSize: 12,
                        color: isSelected ? Colors.orange : Colors.grey,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 3,
        ),
      ],
    );
  }
}
