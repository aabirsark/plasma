import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:plasma/app/constants.dart';

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
