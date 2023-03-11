import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:iconsax/iconsax.dart';
import 'package:plasma_business/app/constants.dart';

class MainPage extends HookWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    final currentIndex = useState(0);

    return Scaffold(
      bottomNavigationBar: Container(
        color: Colors.white,
        margin: const EdgeInsets.all(8.0),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: tabs
                .map((e) => _bottomNavBarItem(e.icon, e.label,
                        selected: currentIndex.value == e.id, callback: () {
                      currentIndex.value = e.id;
                    }))
                .toList()),
      ),
      body: tabs[currentIndex.value].page,
    );
  }

  Widget _bottomNavBarItem(IconData icon, String label,
      {bool selected = false, VoidCallback? callback}) {
    return GestureDetector(
      onTap: callback,
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: selected ? Colors.orange : Colors.blueGrey,
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              label,
              style: TextStyle(
                  fontSize: 12,
                  color: selected ? Colors.orange : Colors.blueGrey,
                  fontWeight: selected ? FontWeight.bold : FontWeight.normal),
            )
          ],
        ),
      ),
    );
  }
}
