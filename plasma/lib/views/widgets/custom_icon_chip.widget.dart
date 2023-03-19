import 'package:flutter/material.dart';



class CustomIconChip extends StatelessWidget {
  const CustomIconChip({
    super.key,
    required this.icon,
    required this.label,
    this.callback,
  });

  final IconData icon;
  final String label;
  final VoidCallback? callback;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: callback,
      child: Container(
        width: double.maxFinite,
        decoration: ShapeDecoration(
            shape: const StadiumBorder(), color: Colors.grey.shade100),
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon),
              const SizedBox(
                width: 10,
              ),
              Text(
                label,
                style: const TextStyle(fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
      ),
    );
  }
}
