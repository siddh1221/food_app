import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:food_app/main.dart';
import 'package:food_app/model/Delivery_Address_model.dart';
import 'package:location/location.dart';

class CheckoutProvider with ChangeNotifier {
  bool isloadding = false;
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController mobileNo = TextEditingController();
  TextEditingController alternateMobileNo = TextEditingController();
  TextEditingController scoiety = TextEditingController();
  TextEditingController street = TextEditingController();
  TextEditingController landmark = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController aera = TextEditingController();
  TextEditingController pincode = TextEditingController();
  LocationData? setLoaction;
  void validator(context, myType) async {
    print(setLoaction);
    if (firstName.text.isEmpty) {
      Fluttertoast.showToast(msg: "firstname is empty");
    } else if (lastName.text.isEmpty) {
      Fluttertoast.showToast(msg: "lastname is empty");
    } else if (mobileNo.text.isEmpty) {
      Fluttertoast.showToast(msg: "mobileNo is empty");
    } else if (alternateMobileNo.text.isEmpty) {
      Fluttertoast.showToast(msg: "alternateMobileNo is empty");
    } else if (scoiety.text.isEmpty) {
      Fluttertoast.showToast(msg: "scoiety is empty");
    } else if (street.text.isEmpty) {
      Fluttertoast.showToast(msg: "street is empty");
    } else if (landmark.text.isEmpty) {
      Fluttertoast.showToast(msg: "landmark is empty");
    } else if (city.text.isEmpty) {
      Fluttertoast.showToast(msg: "city is empty");
    } else if (aera.text.isEmpty) {
      Fluttertoast.showToast(msg: "aera is empty");
    } else if (pincode.text.isEmpty) {
      Fluttertoast.showToast(msg: "pincode is empty");
    } else if (setLoaction == null) {
      Fluttertoast.showToast(msg: "setLoaction is empty");
    } else {
      isloadding = true;
      notifyListeners();
      await FirebaseFirestore.instance
          .collection("AddDeliverAddress")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection("YourAdresses")
          .doc()
          .set({
        "firstname": firstName.text,
        "lastname": lastName.text,
        "mobileNo": mobileNo.text,
        "alternateMobileNo": alternateMobileNo.text,
        "scoiety": scoiety.text,
        "street": street.text,
        "landmark": landmark.text,
        "city": city.text,
        "aera": aera.text,
        "pincode": pincode.text,
        "addressType": myType.toString(),
        "longitude": setLoaction!.longitude,
        "latitude": setLoaction!.latitude,
      }).then((value) async {
        isloadding = false;
        notifyListeners();
        await Fluttertoast.showToast(msg: "Add your deliver address");
        Navigator.of(context).pop();
        notifyListeners();
      });
      notifyListeners();
    }
  }

  List<DeliveryAddressModel> deliveryAdressList = [];
  getDeliveryAddressData() async {
    List<DeliveryAddressModel> newList = [];

    DeliveryAddressModel deliveryAddressModel;
    QuerySnapshot db = await FirebaseFirestore.instance
        .collection("AddDeliverAddress")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection("YourAdresses")
        .get();
    if (db.docs.isNotEmpty) {
      db.docs.firstWhere((element) {
        deliveryAddressModel = DeliveryAddressModel(
          firstName: element.get("firstname"),
          lastName: element.get("lastname"),
          addressType: element.get("addressType"),
          aera: element.get("aera"),
          alternateMobileNo: element.get("alternateMobileNo"),
          city: element.get("city"),
          landMark: element.get("landmark"),
          mobileNo: element.get("mobileNo"),
          pinCode: element.get("pincode"),
          scoirty: element.get("scoiety"),
          street: element.get("street"),
        );
        newList.add(deliveryAddressModel);
        return true;
      });

      notifyListeners();
    }

    deliveryAdressList = newList;
    notifyListeners();
  }

  List<DeliveryAddressModel> get getDeliveryAddressList {
    return deliveryAdressList;
  }

  List<DeliveryAddressModel> AlldeliveryAdressList = [];
  getAllDeliveryAddressData() async {
    List<DeliveryAddressModel> newList1 = [];

    DeliveryAddressModel deliveryAddressModel;
    QuerySnapshot _db = await FirebaseFirestore.instance
        .collection("AddDeliverAddress")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("YourAdresses")
        .get();

    _db.docs.forEach((element) {
      deliveryAddressModel = DeliveryAddressModel(
        firstName: element.get("firstname"),
        lastName: element.get("lastname"),
        addressType: element.get("addressType"),
        aera: element.get("aera"),
        alternateMobileNo: element.get("alternateMobileNo"),
        city: element.get("city"),
        landMark: element.get("landmark"),
        mobileNo: element.get("mobileNo"),
        pinCode: element.get("pincode"),
        scoirty: element.get("scoiety"),
        street: element.get("street"),
      );
      newList1.add(deliveryAddressModel);
    });

    AlldeliveryAdressList = newList1;
    notifyListeners();
  }

  List<DeliveryAddressModel> get getAllDeliveryAddressList {
    return AlldeliveryAdressList;
  }
}
