import 'package:flutter/material.dart';
import 'package:plasma_delivery/app/constants.dart';

class CustomChip extends StatelessWidget {
  const CustomChip({
    Key? key,
    this.color,
    required this.label,
    this.callback,
  }) : super(key: key);

  final String label;
  final Color? color;
  final VoidCallback? callback;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: callback,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        decoration: ShapeDecoration(
            shape: const StadiumBorder(),
            color: color ?? primaryColor.withOpacity(0.3)),
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
        child: Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
