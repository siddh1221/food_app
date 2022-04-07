import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:food_app/model/Review_cart.dart';

class Myorder_Provider with ChangeNotifier {
  void addMyorder_List({
    String? cartId,
    String? cartName,
    String? cartImage,
    num? cartPrice,
    int? cartQuantity,
    var cartUnit,
  }) async {
    await FirebaseFirestore.instance
        .collection("My_Order")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection("YourOrderd")
        .doc(cartId)
        .set(
      {
        "cartId": cartId,
        "cartName": cartName,
        "cartImage": cartImage,
        "cartPrice": cartPrice,
        "cartQuantity": cartQuantity,
        "cartUnit": cartUnit,
      },
    );
  }

  List<ReviewCartModel> MyOrderList = [];
  void getMyOrderData() async {
    List<ReviewCartModel> newList = [];
    QuerySnapshot MyorderValue = await FirebaseFirestore.instance
        .collection("My_Order")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection("YourOrderd")
        .get();
    MyorderValue.docs.forEach((element) {
      ReviewCartModel reviewCartModel = ReviewCartModel(
          cartId: element.get('cartId'),
          cartImage: element.get("cartImage"),
          cartName: element.get('cartName'),
          cartPrice: element.get('cartPrice'),
          cartQuantity: element.get('cartQuantity'),
          cartunit: element.get('cartUnit'));
      newList.add(reviewCartModel);
    });
    MyOrderList = newList;
    notifyListeners();
  }

  List<ReviewCartModel> get MyorderDataList {
    return MyOrderList;
  }

//update//
  void updateMyOrderData({
    String? cartId,
    String? cartName,
    String? cartImage,
    int? cartPrice,
    int? cartQuantity,
    var cartUnit,
  }) async {
    FirebaseFirestore.instance
        .collection("ReviwCart")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("YourReviwCart")
        .doc(cartId)
        .update(
      {
        "cartId": cartId,
        "cartName": cartName,
        "cartImage": cartImage,
        "cartPrice": cartPrice,
        "cartQuantity": cartQuantity,
      },
    );
  }
  //// TotalPrice  ///

  getTotalPrice() {
    double? total = 0;
    MyOrderList.forEach((element) {
      // total += element.cartPrice*element.cartQuantity;
      total = total! + element.cartPrice! * element.cartQuantity!;
      print(total);
    });
    return total;
  }

  //////////////////////ReviewCartDelete//////////////////////
  reviewCartDataDelete(cartId) {
    FirebaseFirestore.instance
        .collection("ReviwCart")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("YourReviwCart")
        .doc(cartId)
        .delete();
    notifyListeners();
  }
}
