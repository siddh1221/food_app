import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_app/constant/color/colors.dart';
import 'package:food_app/constant/images/images.dart';
import 'package:food_app/pages/Categories/herb.dart';
import 'package:food_app/pages/home/drawer.dart';
import 'package:food_app/pages/product/overe.dart';
import 'package:food_app/pages/home/product.dart';
import 'package:food_app/pages/review_cart/review_cart.dart';
import 'package:food_app/pages/search/Search.dart';
import 'package:food_app/provider/product_provider.dart';
import 'package:food_app/provider/user_provider.dart';

import 'package:provider/provider.dart';

class Home_Page1 extends StatefulWidget {
  Home_Page1({Key? key}) : super(key: key);

  @override
  State<Home_Page1> createState() => _Home_Page1State();
}

enum _SelectedTab { home, favorite, search, person }

class _Home_Page1State extends State<Home_Page1> {
  ProductProvider? productProvider;
  @override
  void initState() {
    ProductProvider productProvider = Provider.of(context, listen: false);
    productProvider.fatchHerbsProductData();
    productProvider.fatchFreshProductData();
    productProvider.fatchRootProductData();
    super.initState();
  }

  double xOffset = 0;
  double yOffset = 0;
  double scaleFactor = 1;
  bool isDragging = false;
  bool isDrawerOpen = false;
  var _selectedTab = _SelectedTab.home;

  void _handleIndexChanged(int i) {
    setState(() {
      _selectedTab = _SelectedTab.values[i];
    });
  }

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of(context);
    userProvider.getUserData();
    ProductProvider productProvider = Provider.of(context);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 224, 223, 220),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color.fromARGB(255, 224, 223, 220),
        title: Text(
          "Homepage",
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.w500, color: Colors.black),
        ),
        iconTheme: IconThemeData(color: Colors.black),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => Search(
                          searchlist: productProvider.getAllroductDataList,
                        )));
              },
              icon: Icon(Icons.search, size: 25, color: Colors.black)),
          IconButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ReviewCart(),
                  ),
                );
              },
              icon: Icon(Icons.shopping_cart, color: Colors.black)),
        ],
      ),
      drawer: DrawerPage(userProvider: userProvider),
      body: SingleChildScrollView(
          // physics: NeverScrollableScrollPhysics(),
          child: HomePage(context, productProvider)),
    );
  }

  Column HomePage(BuildContext context, ProductProvider productProvider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 5,
        ),
        // Container(
        //   // color:Color.fromARGB(255, 87, 112, 107),
        //   height: 65,
        //   child: Row(
        //     children: [
        //       Padding(
        //         padding: const EdgeInsets.all(8.0),
        //         child: IconButton(onPressed: () {}, icon: Icon(Icons.menu)),
        //       ),
        //       Text(
        //         "Homepage",
        //         style: TextStyle(
        //           fontSize: 20,
        //           fontWeight: FontWeight.w500,
        //         ),
        //       ),
        //       SizedBox(
        //         width: 110,
        //       ),
        //       IconButton(
        //           onPressed: () {},
        //           icon: Icon(
        //             Icons.search,
        //             size: 25,
        //           )),
        //       IconButton(onPressed: () {}, icon: Icon(Icons.shopping_cart)),
        //     ],
        //   ),
        // ),
        CarouselSlider(
          items: _imageURL.map((imagepath) {
            return Builder(builder: (BuildContext context) {
              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                      image: AssetImage(
                        imagepath,
                      ),
                      fit: BoxFit.cover),
                ),
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.symmetric(horizontal: 1),
                child: GestureDetector(),
              );
            });
          }).toList(),
          options: CarouselOptions(
            height: 200,
            aspectRatio: 16 / 9,
            autoPlay: true,
            enlargeCenterPage: true,
            autoPlayCurve: Curves.fastOutSlowIn,
            enableInfiniteScroll: true,
            autoPlayAnimationDuration: Duration(milliseconds: 800),
            viewportFraction: 0.8,
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * .01,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              "Herbs Seasonings",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * .03,
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => Search(
                      searchlist: productProvider.getHerbsProductDataList,
                    ),
                  ),
                );
              },
              child: Text(
                "View all",
                style: TextStyle(fontSize: 17, color: Colors.blueGrey),
              ),
            ),
          ],
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            // ignore: non_constant_identifier_names
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
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              "Fresh Fruit",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * .23,
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => Search(
                      searchlist: productProvider.getFreshProductDataList,
                    ),
                  ),
                );
              },
              child: Text(
                "View all",
                style: TextStyle(fontSize: 17, color: Colors.blueGrey),
              ),
            ),
          ],
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            // ignore: non_constant_identifier_names
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
        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              "Root Vegetable",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * .11,
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => Search(
                      searchlist: productProvider.RootProductList,
                    ),
                  ),
                );
              },
              child: Text(
                "View all",
                style: TextStyle(fontSize: 17, color: Colors.blueGrey),
              ),
            ),
          ],
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            // ignore: non_constant_identifier_names
            children:
                productProvider.getRootProductDataList.map((RootProductData) {
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
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * .1,
        )
      ],
    );
  }

  final List _source = [Colors.red, Colors.black, Colors.yellow];

  final List _imageURL = [
    'assets/herb.jpg',
    'assets/fruit.jpg',
    'assets/vegi.jpg',
    'assets/fruit.jpg',
    'assets/11.png',
    'assets/22.png',
    'assets/33.png',
    'assets/44.png',
    'assets/55.png',
    // 'assets/66.png',
  ];
  List<BoxShadow> shadowList = [
    BoxShadow(color: Colors.grey, blurRadius: 30, offset: Offset(0, 10))
  ];
}
