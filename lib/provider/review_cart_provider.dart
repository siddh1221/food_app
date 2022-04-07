import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:food_app/model/Review_cart.dart';

class ReviewCartProvider with ChangeNotifier {
  void addUReviewCartData({
    String? cartId,
    String? cartName,
    String? cartImage,
    num? cartPrice,
    int? cartQuantity,
    var cartUnit,
  }) async {
    await FirebaseFirestore.instance
        .collection("ReviwCart")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection("YourReviwCart")
        .doc(cartId)
        .set(
      {
        "cartId": cartId,
        "cartName": cartName,
        "cartImage": cartImage,
        "cartPrice": cartPrice,
        "cartQuantity": cartQuantity,
        "cartUnit": cartUnit,
        "isAdd": true
      },
    );
  }

  List<ReviewCartModel> reviewCartDataList = [];
  void getReviewCartData() async {
    List<ReviewCartModel> newList = [];
    QuerySnapshot reviewCartValue = await FirebaseFirestore.instance
        .collection("ReviwCart")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection("YourReviwCart")
        .get();
    reviewCartValue.docs.forEach((element) {
      ReviewCartModel reviewCartModel = ReviewCartModel(
          cartId: element.get('cartId'),
          cartImage: element.get("cartImage"),
          cartName: element.get('cartName'),
          cartPrice: element.get('cartPrice'),
          cartQuantity: element.get('cartQuantity'),
          cartunit: element.get('cartUnit'));
      newList.add(reviewCartModel);
    });
    reviewCartDataList = newList;
    notifyListeners();
  }

  List<ReviewCartModel> get getReviewCartDataList {
    return reviewCartDataList;
  }

//update//
  void updateReviewCartData({
    String? cartId,
    String? cartName,
    String? cartImage,
    num? cartPrice,
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
        "isAdd": true,
      },
    );
  }
  //// TotalPrice  ///

  getTotalPrice() {
    num? total = 0;
    reviewCartDataList.forEach((element) {
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
