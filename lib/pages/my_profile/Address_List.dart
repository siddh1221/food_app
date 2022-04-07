import 'package:flutter/material.dart';
import 'package:food_app/constant/color/colors.dart';
import 'package:food_app/model/Delivery_Address_model.dart';
import 'package:food_app/pages/CheckOut/Add_Delivery_Address/Add_Delivery_Adsress.dart';
import 'package:food_app/pages/CheckOut/Delivery%20Detail/singel_delivery_iteam.dart';
import 'package:food_app/provider/Checkout_Provider.dart';
import 'package:provider/provider.dart';

class AddressList extends StatefulWidget {
  AddressList({Key? key}) : super(key: key);

  @override
  State<AddressList> createState() => _AddressListState();
}

class _AddressListState extends State<AddressList> {
  @override
  @override
  void initState() {
    CheckoutProvider checkoutProvider = Provider.of(context, listen: false);
    checkoutProvider.getAllDeliveryAddressData();
    super.initState();
  }

  Widget build(BuildContext context) {
    DeliveryAddressModel? value;
    CheckoutProvider deliveryAddressProvider = Provider.of(context);
    deliveryAddressProvider.AlldeliveryAdressList;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: App_Colors.Primary_Color,
        title: const Text(
          "Your Address",
          style: TextStyle(fontSize: 18),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: App_Colors.Primary_Color,
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => Add_Delivery_Address(),
            ),
          );
        },
      ),
      body: ListView.builder(
        itemCount: deliveryAddressProvider.AlldeliveryAdressList.length,
        itemBuilder: (context, index) {
          return Column(
            children:
                deliveryAddressProvider.AlldeliveryAdressList.map<Widget>((e) {
              return SingleDeliveryItem(
                address:
                    "aera, ${e.aera}, street, ${e.street}, society ${e.scoirty}, pincode ${e.pinCode}",
                title: "${e.firstName} ${e.lastName}",
                number: e.mobileNo!,
                addressType: e.addressType == "AddressTypes.Home"
                    ? "Home"
                    : e.addressType == "AddressTypes.Other"
                        ? "Other"
                        : "Work",
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
