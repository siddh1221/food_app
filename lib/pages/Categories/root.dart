import 'package:flutter/material.dart';
import 'package:food_app/constant/color/colors.dart';
import 'package:food_app/pages/home/product.dart';
import 'package:food_app/provider/product_provider.dart';
import 'package:provider/provider.dart';

class rootPage extends StatefulWidget {
  rootPage({Key? key}) : super(key: key);

  @override
  State<rootPage> createState() => _rootPageState();
}

class _rootPageState extends State<rootPage> {
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
        children: productProvider.getRootProductDataList.map((RootProductData) {
          return Product(
            bgcolor: App_Colors.Primary_Color,
            productImage: RootProductData.productImage,
            productName: RootProductData.productName,
            productPrice: RootProductData.productPrice,
            productId: RootProductData.productId,
            productUnit: RootProductData,
            productDescription: RootProductData.productDescription,
          );
        }).toList(),
      ),
    );
  }
}
