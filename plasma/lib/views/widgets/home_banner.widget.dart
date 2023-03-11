import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:plasma/services/models/shop_info.model.dart';
import 'package:plasma/views/widgets/shop_info_card.widget.dart';

class SliverBannerHeader extends SliverPersistentHeaderDelegate {
  final List<ShopInfoModel> shops;

  SliverBannerHeader({required this.shops});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: shops.isEmpty
          ? const Center(
              child: Text("No Data !"),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Stores near you",
                  style: TextStyle(fontSize: 18),
                ),
                Container(
                  height: 1,
                  width: 80,
                  color: Colors.black,
                ),
                const SizedBox(
                  height: 15,
                ),
                SizedBox(
                  height: 200,
                  child: PageView.builder(
                      itemCount: shops.length,
                      itemBuilder: (context, index) {
                        final shop = shops.elementAt(index);
                        return ShopInfoCard(shop: shop);
                      }),
                ),
                const SizedBox(height: 2,),
                Align(
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [

                      Text(
                        "Swipe for more",
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Icon(
                        CupertinoIcons.forward,
                        size: 12,
                        color: Colors.grey,
                      ),
                      Icon(
                        CupertinoIcons.forward,
                        size: 12,
                        color: Colors.grey,
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Products from nearby",
                  style: TextStyle(fontSize: 18),
                ),
                Container(
                  height: 1,
                  width: 80,
                  color: Colors.black,
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
    );
  }

  @override
  double get maxExtent => 340;

  @override
  double get minExtent => 340;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
