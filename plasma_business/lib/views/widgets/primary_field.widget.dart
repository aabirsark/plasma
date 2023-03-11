import 'package:flutter/material.dart';
import 'package:plasma_business/app/constants.dart';

class PrimaryField extends StatelessWidget {
  const PrimaryField({
    Key? key,
    required this.label,
    required this.icon,
    this.preffix,
    required this.input,
    this.helpertext,
    this.maxlines,
    this.controller,
  }) : super(key: key);

  final String label;
  final IconData icon;
  final String? preffix;
  final TextInputType input;
  final String? helpertext;
  final int? maxlines;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: primaryColor,
      keyboardType: input,
      controller: controller,
      maxLines: maxlines,
      decoration: InputDecoration(
          isDense: true,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20.0, vertical: 18),
          enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Colors.transparent,
              ),
              borderRadius: BorderRadius.circular(20)),
          border: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Colors.transparent,
              ),
              borderRadius: BorderRadius.circular(20)),
          focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Colors.transparent,
              ),
              borderRadius: BorderRadius.circular(20)),
          label: Text(
            label,
            style: const TextStyle(color: Colors.black, fontSize: 14),
          ),
          prefixIcon: Icon(
            icon,
            color: Colors.black,
          ),
          helperText: helpertext,
          filled: true,
          prefix: preffix != null ? Text(preffix!) : null,
          prefixIconColor: Colors.black,
          fillColor: Colors.grey.shade200),
    );
  }
}
