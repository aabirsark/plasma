import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:plasma_business/app/constants.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    Key? key,
    this.label,
    this.customWidget,
    this.color,
    this.isDark = true,
    required this.callback,
  })  : assert(label != null || customWidget != null),
        super(key: key);

  final String? label;
  final Widget? customWidget;

  /// background coloe of the object
  final Color? color;

  /// text will be dark or not
  final bool isDark;
  final VoidCallback callback;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: callback,
      child: Container(
        height: 60,
        decoration: BoxDecoration(
            color: color ?? primaryColor,
            borderRadius: BorderRadius.circular(20)),
        child: Center(
          child: customWidget ??
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    label ?? "",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: isDark ? Colors.black : Colors.white),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Icon(
                    CupertinoIcons.arrow_right,
                    color: isDark ? Colors.black : Colors.white,
                  )
                ],
              ),
        ),
      ),
    );
  }
}
