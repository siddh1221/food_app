import 'package:flutter/material.dart';
import 'package:food_app/constant/color/colors.dart';
import 'package:food_app/model/Review_cart.dart';
import 'package:food_app/model/product_model.dart';
import 'package:food_app/provider/review_cart_provider.dart';
import 'package:food_app/provider/wishList_Provider.dart';
import 'package:food_app/widgets/singel_item.dart';
import 'package:food_app/widgets/wishlist_iteam.dart';
import 'package:provider/provider.dart';

class WishList extends StatefulWidget {
  const WishList({Key? key}) : super(key: key);

  // WishListProvider? wishListProvider;
  @override
  State<WishList> createState() => _WishListState();
}

class _WishListState extends State<WishList> {
  WishListProvider? wishListProvider;
  @override
  Widget build(BuildContext context) {
    WishListProvider wishListProvider = Provider.of(context);
    wishListProvider.getWishtListData();
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: App_Colors.ScafoldeColor,
      appBar: AppBar(
        title: const Text("WishList"),
        backgroundColor: App_Colors.Primary_Color,
      ),
      body: ListView.builder(
          itemCount: wishListProvider.wishList.length,
          itemBuilder: (context, index) {
            ProductModel data = wishListProvider.getWishList[index];
            return Column(
              children: [
                SizedBox(
                  height: size.height * .01,
                ),
                Wishlist_Iteam(
                  productImage: data.productImage,
                  productName: data.productName,
                  productPrice: data.productPrice,
                  productUnit: data.unit!,
                  productId: data.productId,
                  productDescription: data.productDescription,
                ),
              ],
            );
          }),
    );
  }
}
