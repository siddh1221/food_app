import 'package:flutter/material.dart';
import 'package:food_app/constant/color/colors.dart';
import 'package:food_app/pages/home/product.dart';
import 'package:food_app/provider/product_provider.dart';
import 'package:provider/provider.dart';

class freshPage extends StatefulWidget {
  freshPage({Key? key}) : super(key: key);

  @override
  State<freshPage> createState() => _freshPageState();
}

class _freshPageState extends State<freshPage> {
  @override
  void initState() {
    ProductProvider productProvider = Provider.of(context, listen: false);
    productProvider.fatchHerbsProductData();
    productProvider.fatchFreshProductData();
    productProvider.fatchRootProductData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ProductProvider productProvider = Provider.of(context);
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children:
            productProvider.getFreshProductDataList.map((FreshProductData) {
          return Product(
            bgcolor: App_Colors.Primary_Color,
            productImage: FreshProductData.productImage,
            productName: FreshProductData.productName,
            productPrice: FreshProductData.productPrice,
            productId: FreshProductData.productId,
            productUnit: FreshProductData,
            productDescription: FreshProductData.productDescription,
          );
        }).toList(),
      ),
    );
  }
}
