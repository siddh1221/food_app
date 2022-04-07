import 'package:flutter/material.dart';
import 'package:food_app/constant/color/colors.dart';
import 'package:food_app/pages/home/product.dart';
import 'package:food_app/provider/product_provider.dart';
import 'package:provider/provider.dart';

class herbPage extends StatefulWidget {
  herbPage({Key? key}) : super(key: key);

  @override
  State<herbPage> createState() => _herbPageState();
}

class _herbPageState extends State<herbPage> {
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
            productProvider.getHerbsProductDataList.map((HerbProductData) {
          return Product(
            bgcolor: App_Colors.Primary_Color,
            productImage: HerbProductData.productImage,
            productName: HerbProductData.productName,
            productPrice: HerbProductData.productPrice,
            productId: HerbProductData.productId,
            productUnit: HerbProductData,
            productDescription: HerbProductData.productDescription,
          );
        }).toList(),
      ),
    );
  }
}
