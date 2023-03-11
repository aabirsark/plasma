import 'package:flutter/material.dart';
import 'package:plasma_business/app/constants.dart';

class AuthInput extends StatelessWidget {
  const AuthInput({
    Key? key,
    required this.label,
    required this.icon,
    this.preffix,
    required this.input,
    this.controller,
  }) : super(key: key);

  final String label;
  final IconData icon;
  final String? preffix;
  final TextInputType input;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: primaryColor,
      keyboardType: input,
      controller: controller,
      decoration: InputDecoration(
          border: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Colors.black,
              ),
              borderRadius: BorderRadius.circular(20)),
          focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Colors.black,
              ),
              borderRadius: BorderRadius.circular(20)),
          label: Text(
            label,
            style: const TextStyle(color: Colors.black),
          ),
          prefixIcon: Icon(
            icon,
            color: Colors.black,
          ),
          prefix: preffix != null ? Text(preffix!) : null,
          prefixIconColor: Colors.black,
          fillColor: Colors.grey.shade50),
    );
  }
}
