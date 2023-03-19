import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:plasma/app/constants.dart';


class CustomStepper extends HookWidget {
  const CustomStepper({
    super.key,
    required this.status,
  });

  final String status;

  @override
  Widget build(BuildContext context) {
    final step = useState(0);
    final isCancelled = useState(false);

    useEffect(() {
      if (status == "Ordered") {
        step.value = 1;
        return;
      } else if (status == "Picked") {
        step.value = 2;
        return;
      } else if (status == "Delivered") {
        step.value = 3;
        return;
      } else if (status == "Cancelled") {
        isCancelled.value = true;
        return;
      }
      return;
    }, []);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: isCancelled.value
            ? [
                _setpperInfo(isSelected: true, label: "Ordered"),
                Container(
                  height: 75,
                  width: 2,
                  margin: const EdgeInsets.symmetric(horizontal: 12),
                  color: Colors.red,
                ),
                _setpperInfo(
                    isSelected: true, label: "Cancelled", color: Colors.red)
              ]
            : [
                _setpperInfo(isSelected: step.value >= 1, label: "Ordered"),
                Container(
                  height: 75,
                  width: 2,
                  margin: const EdgeInsets.symmetric(horizontal: 12),
                  color: step.value >= 2 ? primaryColor : Colors.grey,
                ),
                _setpperInfo(isSelected: step.value >= 2, label: "Picked up"),
                Container(
                  height: 75,
                  width: 2,
                  margin: const EdgeInsets.symmetric(horizontal: 12),
                  color: step.value >= 3 ? primaryColor : Colors.grey,
                ),
                _setpperInfo(isSelected: step.value >= 3, label: "Delivered"),
              ],
      ),
    );
  }

  Row _setpperInfo(
      {required bool isSelected, required String label, Color? color}) {
    return Row(
      children: [
        Container(
          height: 25,
          width: 25,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isSelected ? color ?? primaryColor : Colors.transparent,
              border: Border.all(color: Colors.black)),
          child: isSelected
              ? const Center(
                  child: Icon(
                    Icons.done,
                    size: 18,
                  ),
                )
              : const SizedBox.shrink(),
        ),
        const SizedBox(
          width: 20,
        ),
        Text(
          label,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}