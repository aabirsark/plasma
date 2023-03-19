import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:plasma_business/app/constants.dart';
import 'package:plasma_business/services/db/product_functions.db.dart';
import 'package:plasma_business/services/db/setup_commands.db.dart';
import 'package:plasma_business/views/create_product.page.dart';
import 'package:plasma_business/views/widgets/product_card.widget.dart';

import '../../services/models/product_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoading = true;
  List<ProductModel> products = [];
  bool isError = false;

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  getData() {
    ProductFuctions.getProducts().then((value) {
      if (value != null) {
        setState(() {
          isLoading = false;
          products = value;
        });
      } else {
        setState(() {
          isError = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        automaticallyImplyLeading: false,
        title: RichText(
            text: TextSpan(
                style: TextStyle(
                    fontSize: 18, color: Colors.black, fontFamily: headerFont),
                children: [
              const TextSpan(
                  text: "PLASMA ",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              TextSpan(
                  text: "Store",
                  style: TextStyle(fontSize: 16, fontFamily: primaryFont))
            ])),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const CreateProduct(),
              ));
        },
        backgroundColor: primaryColor,
        child: const Icon(
          CupertinoIcons.add,
          color: Colors.black,
        ),
      ),
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Your Products",
                style: TextStyle(fontSize: 20),
              ),
              Container(
                height: 1,
                width: 80,
                color: Colors.black54,
              ),
              Expanded(
                  child: isLoading
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: Colors.black,
                            strokeWidth: 2,
                          ),
                        )
                      : products.isEmpty
                          ? const Center(
                              child: Text("No Data yet !"),
                            )
                          : RefreshIndicator(
                              color: Colors.black,
                              strokeWidth: 2,
                              onRefresh: () async {
                                final value =
                                    await ProductFuctions.getProducts();

                                if (value != null) {
                                  setState(() {
                                    isLoading = false;
                                    products = value;
                                  });
                                } else {
                                  setState(() {
                                    isError = true;
                                  });
                                }

                                return;
                              },
                              child: ListView.builder(
                                itemBuilder: (context, index) => ProductCard(
                                  model: products[index],
                                ),
                                itemCount: products.length,
                              ),
                            ))
            ],
          )),
    );
  }
}
