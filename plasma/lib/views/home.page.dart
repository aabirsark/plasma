import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:plasma/app/constants.dart';

class HomePage extends HookWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedIndex = useState(0);

    return Scaffold(
      bottomNavigationBar: Container(
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: tabs
              .map((e) => _bottomNavBarItem(e.icon, e.label,
                      selected: e.id == selectedIndex.value, callback: () {
                    if (e.id != selectedIndex.value) {
                      selectedIndex.value = e.id;
                    }
                  }))
              .toList(),
        ),
      ),
      body: tabs[selectedIndex.value].page,
    );
  }

  Widget _bottomNavBarItem(IconData icon, String label,
      {bool selected = false, VoidCallback? callback}) {
    return GestureDetector(
      onTap: callback,
      child: Container(
        padding: const EdgeInsets.all(16.0),
        color: Colors.white,
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
                  fontWeight: selected ? FontWeight.bold : FontWeight.normal,
                  color: selected ? Colors.orange : Colors.blueGrey),
            )
          ],
        ),
      ),
    );
  }
}
