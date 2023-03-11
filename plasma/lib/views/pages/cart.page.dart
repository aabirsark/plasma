import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:plasma/services/db/products.service.db.dart';
import 'package:plasma/services/models/product_model.dart';
import 'package:plasma/views/widgets/product_card_horz.widget.dart';

class WishPage extends StatelessWidget {
  const WishPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        title: const Text("WISHLIST"),
      ),
      body: FutureBuilder<List<ProductModel>?>(
        future: ProductsAndStoreFunctions.getCartItems(),
        initialData: null,
        builder: (BuildContext context,
            AsyncSnapshot<List<ProductModel>?> snapshot) {
          if (snapshot.data == null) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.black,
                strokeWidth: 3,
              ),
            );
          }
          if (snapshot.data != null) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        final value = snapshot.data!.elementAt(index);
                        return Dismissible(
                            confirmDismiss: (direction) async {
                              ProductsAndStoreFunctions.delCartItem(value.id!);
                              return true;
                            },
                            background: Row(
                              children: const [
                                SizedBox(
                                  width: 10,
                                ),
                                Icon(
                                  Iconsax.trash,
                                  color: Colors.red,
                                ),
                                Spacer(),
                                Icon(
                                  Iconsax.trash,
                                  color: Colors.red,
                                ),
                                SizedBox(
                                  width: 10,
                                )
                              ],
                            ),
                            key: Key(value.images![0]),
                            child: ProductCardHorz(model: value));
                      },
                      itemCount: snapshot.data!.length,
                    ),
                  ),
                ],
              ),
            );
          }
          return const Center(
            child: Text("Couldn't get the data"),
          );
        },
      ),
    );
  }
}
