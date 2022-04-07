import 'package:flutter/material.dart';
import 'package:food_app/constant/color/colors.dart';
import 'package:food_app/pages/CheckOut/Google_Map/Google_Map.dart';
import 'package:food_app/provider/Checkout_Provider.dart';
import 'package:food_app/provider/prmission.dart';
import 'package:food_app/widgets/Custom_TextFielld.dart';
import 'package:provider/provider.dart';

class Add_Delivery_Address extends StatefulWidget {
  const Add_Delivery_Address({Key? key}) : super(key: key);
  // ignore: non_constant_identifier_names

  @override
  State<Add_Delivery_Address> createState() => _Add_Delivery_AddressState();
}

enum AddressTypes {
  Home,
  Work,
  Other,
}

class _Add_Delivery_AddressState extends State<Add_Delivery_Address> {
  var myType = AddressTypes.Home;
  @override
  Widget build(BuildContext context) {
    CheckoutProvider checkoutProvider = Provider.of(context);

    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: App_Colors.ScafoldeColor,
      appBar: AppBar(
          backgroundColor: App_Colors.Primary_Color,
          title: checkoutProvider.isloadding == false
              ? Text(
                  "Add Delivery Address",
                  style: TextStyle(fontSize: 18),
                )
              : Center(
                  child: CircularProgressIndicator(),
                )),
      bottomNavigationBar: Container(
          margin: EdgeInsets.symmetric(
              vertical: size.height * .0150, horizontal: size.width * .05),
          height: 48,
          child: MaterialButton(
            onPressed: () {
              checkoutProvider.validator(context, myType);
            },
            child: const Text(
              "Add Address",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
            color: App_Colors.Primary_Color,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                30,
              ),
            ),
          )),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width * .05),
        child: ListView(
          children: [
            CostomTextField(
              labText: "First name",
              controller: checkoutProvider.firstName,
              // keyboardType: TextInputType.name,
            ),
            CostomTextField(
              labText: "Last name",
              controller: checkoutProvider.lastName,
            ),
            CostomTextField(
              labText: "Mobile No",
              controller: checkoutProvider.mobileNo,
              keyboardType: TextInputType.number,
            ),
            CostomTextField(
              labText: "Alternate Mobile No",
              controller: checkoutProvider.alternateMobileNo,
              keyboardType: TextInputType.number,
            ),
            CostomTextField(
              labText: "Scoiety",
              controller: checkoutProvider.scoiety,
            ),
            CostomTextField(
              labText: "No",
              controller: checkoutProvider.street,
            ),
            CostomTextField(
              labText: "Landmark",
              controller: checkoutProvider.landmark,
            ),
            CostomTextField(
              labText: "City",
              controller: checkoutProvider.city,
            ),
            CostomTextField(
              labText: "Aera",
              controller: checkoutProvider.aera,
            ),
            CostomTextField(
              labText: "Pincode",
              controller: checkoutProvider.pincode,
              keyboardType: TextInputType.number,
            ),
            InkWell(
              onTap: () async {
                determinePosition().then((value) {
                  setState(() {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => CostomGoogleMap(),
                      ),
                    );
                  });
                });
              },
              child: Container(
                height: size.height * .055,
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    checkoutProvider.setLoaction == null
                        ? Text("Set Loaction")
                        : Text("Done"),
                  ],
                ),
              ),
            ),
            Divider(
              color: Colors.black,
            ),
            ListTile(
              title: Text("Address Type*"),
            ),
            RadioListTile(
              value: AddressTypes.Home,
              groupValue: myType,
              title: Text("Home"),
              onChanged: (AddressTypes? value) {
                setState(() {
                  myType = value!;
                });
              },
              secondary: Icon(
                Icons.home,
                color: App_Colors.Primary_Color,
              ),
            ),
            RadioListTile(
              value: AddressTypes.Work,
              groupValue: myType,
              title: Text("Work"),
              onChanged: (AddressTypes? value) {
                setState(() {
                  myType = value!;
                });
              },
              secondary: Icon(
                Icons.work,
                color: App_Colors.Primary_Color,
              ),
            ),
            RadioListTile(
              value: AddressTypes.Other,
              groupValue: myType,
              title: Text("Other"),
              onChanged: (AddressTypes? value) {
                setState(() {
                  myType = value!;
                });
              },
              secondary: Icon(
                Icons.devices_other,
                color: App_Colors.Primary_Color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
