import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:plasma/app/constants.dart';
import 'package:plasma/services/db/products.service.db.dart';
import 'package:plasma/views/widgets/coming_soon.widget.dart';
import 'package:plasma/views/widgets/home_banner.widget.dart';
import 'package:plasma/views/widgets/product_card.widget.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  bool isLoading = true;
  late HomeRespose homeRespose;

  @override
  void initState() {
    super.initState();
    ProductsAndStoreFunctions.getHomeData().then((value) {
      setState(() {
        isLoading = false;
        homeRespose = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: Colors.black,
                strokeWidth: 2,
              ),
            )
          : homeRespose.isError
              ? const Center(
                  child:
                      Text("Something bad happend while contatcing servers !"),
                )
              : CustomScrollView(
                  slivers: [
                    SliverAppBar(
                      pinned: true,
                      toolbarHeight: 80,
                      automaticallyImplyLeading: false,
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            appname,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "Online",
                            style: TextStyle(
                                fontSize: 10,
                                color: Colors.blueGrey,
                                fontFamily: primaryFont),
                          )
                        ],
                      ),
                      actions: [
                        IconButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const ComingSoon(),
                                  ));
                            },
                            icon: const Icon(CupertinoIcons.search))
                      ],
                    ),
                    SliverPersistentHeader(
                        delegate:
                            SliverBannerHeader(shops: homeRespose.shops ?? [])),
                    SliverGrid(
                      delegate: SliverChildBuilderDelegate((context, index) {
                        final product = homeRespose.products?.elementAt(index);
                        return ProductCard(product: product!);
                      }, childCount: homeRespose.products?.length),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              childAspectRatio: .73, crossAxisCount: 2),
                    )
                  ],
                ),
    );
  }
}
