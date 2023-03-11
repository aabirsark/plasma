import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:plasma_business/services/db/order_db.service.dart';
import 'package:plasma_business/services/models/order.model.dart';

class OrderCodeBottomSheet extends StatefulHookWidget {
  const OrderCodeBottomSheet({
    required this.order,
    Key? key,
  }) : super(key: key);

  final OrderModel order;

  @override
  State<OrderCodeBottomSheet> createState() => _OrderCodeBottomSheetState();
}

class _OrderCodeBottomSheetState extends State<OrderCodeBottomSheet> {
  final _key = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = useTextEditingController();

    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text(
                "Enter the code",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              const Spacer(),
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(CupertinoIcons.multiply)),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Form(
            key: _key,
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    validator: (value) {
                      if (int.parse(value ?? "0000") == widget.order.code!) {
                        return null;
                      } else {
                        print(widget.order.code);
                        return "Wrong code";
                      }
                    },
                    controller: controller,
                    maxLength: 4,
                    keyboardType: TextInputType.number,
                    cursorColor: Colors.amber,
                    decoration: const InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black)),
                        helperMaxLines: 2,
                        helperText: "The code is in the customer device"),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                OutlinedButton(
                    onPressed: () {
                      if (_key.currentState!.validate()) {
                        OrderDBFnctions.deliverOrder(widget.order.id!)
                            .then((value) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              backgroundColor: Colors.blueGrey.shade900,
                              behavior: SnackBarBehavior.floating,
                              content: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: const [
                                  Icon(
                                    Icons.done,
                                    color: Colors.green,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text("Order updated")
                                ],
                              )));
                          Navigator.pop(context);
                        });
                      }
                    },
                    child: const Text(
                      "Done",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black),
                    )),
              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).viewInsets.bottom + 20,
          )
        ],
      ),
    );
  }
}
