import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:plasma_delivery/app/constants.dart';
import 'package:plasma_delivery/services/db/order_db.dart';
import 'package:plasma_delivery/views/widgets/order_card.widget.dart';

class HomePage extends HookWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final isLoading = useState(true);
    final ValueNotifier<OrderResponse> res =
        useState(OrderResponse(picked: [], ordered: []));

    useEffect(() {
      OrderDBFnctions.getOrders().then((value) {
        isLoading.value = false;
        res.value = value;
      });

      return;
    }, []);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'PLASMA DELIVERY',
          style: TextStyle(fontSize: 16),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryColor,
        foregroundColor: Colors.black,
        onPressed: () {
          OrderDBFnctions.getOrders().then((value) {
            isLoading.value = false;
            res.value = value;
          });
        },
        child: const Icon(Icons.repeat),
      ),
      body: isLoading.value
          ? const Center(
              child: CircularProgressIndicator(
                color: Colors.black12,
                strokeWidth: 2,
              ),
            )
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: RefreshIndicator(
                onRefresh: () async {
                  await Future.delayed(const Duration(microseconds: 20000));
                },
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        "Pending Orders",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      res.value.picked.isNotEmpty
                          ? ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: res.value.picked.length,
                              itemBuilder: (context, index) =>
                                  OrderCard(orders: res.value.picked[index]),
                            )
                          : const SizedBox(
                              height: 100,
                              child: Center(
                                child: Text("<< No Data >>"),
                              ),
                            ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        "Orders for pickup",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: res.value.ordered.length,
                        itemBuilder: (context, index) =>
                            OrderCard(orders: res.value.ordered[index]),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
