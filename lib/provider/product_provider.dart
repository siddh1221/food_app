import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:food_app/model/product_model.dart';
import 'package:food_app/pages/search/Search.dart';

class ProductProvider with ChangeNotifier {
  ProductModel? productModel;
  List<ProductModel> search = [];
  productModels(QueryDocumentSnapshot element) {
    productModel = ProductModel(
        productImage: element.get("ProductImage"),
        productName: element.get("ProductName"),
        productPrice: element.get("ProductPrice"),
        productId: element.get("ProductId"),
        productUnit: element.get("ProductUnit"),
        productDescription: element.get("ProductDescription"),
        productQuantity: 1);
    search.add(productModel!);
    // search.add(productModel);
  }

  ////////////////////////////////////////////HerbCollection////////////////////////////////
  List<ProductModel> herbsProductList = [];
  fatchHerbsProductData() async {
    List<ProductModel> newList = [];
    QuerySnapshot value = await FirebaseFirestore.instance
        .collection("AllProductCategories")
        .doc("Categories")
        .collection("HerbsProduct")
        .get();

    value.docs.forEach(
      (element) {
        productModels(element);
        newList.add(productModel!);
      },
    );
    herbsProductList = newList;
    notifyListeners();
  }

  List<ProductModel> get getHerbsProductDataList {
    return herbsProductList;
  }

////////////////////////////////////////////FreshCollection////////////////////////////////
  List<ProductModel> FreshProductList = [];

  fatchFreshProductData() async {
    List<ProductModel> newList = [];

    QuerySnapshot value = await FirebaseFirestore.instance
        .collection("AllProductCategories")
        .doc("Categories")
        .collection("FreshProduct")
        .get();

    value.docs.forEach(
      (element) {
        productModels(element);
        newList.add(productModel!);
      },
    );
    FreshProductList = newList;
    notifyListeners();
  }

  List<ProductModel> get getFreshProductDataList {
    return FreshProductList;
  }

  ////////////////////////////////////////////RootCollection////////////////////////////////
  List<ProductModel> RootProductList = [];

  fatchRootProductData() async {
    List<ProductModel> newList = [];

    QuerySnapshot value = await FirebaseFirestore.instance
        .collection("AllProductCategories")
        .doc("Categories")
        .collection("RootProduct")
        .get();

    value.docs.forEach(
      (element) {
        productModels(element);
        newList.add(productModel!);
      },
    );
    RootProductList = newList;
    notifyListeners();
  }

  List<ProductModel> get getRootProductDataList {
    return RootProductList;
  }

////////////////////////////////////////////Search////////////////////////////////
  List<ProductModel> get getAllroductDataList {
    return search;
  }
}
