import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:food_app/constant/color/colors.dart';
import 'package:food_app/model/Delivery_Address_model.dart';
import 'package:food_app/pages/CheckOut/Delivery%20Detail/singel_delivery_iteam.dart';
import 'package:food_app/pages/CheckOut/invoice/invoice.dart';
import 'package:food_app/pages/CheckOut/payment_summary/my_google_pay.dart';
import 'package:food_app/pages/CheckOut/payment_summary/order_iteam.dart';
import 'package:food_app/pages/my_profile/My_order.dart';
import 'package:food_app/provider/All_order_provider.dart';
import 'package:food_app/provider/my_oreder_provider.dart';
import 'package:food_app/provider/review_cart_provider.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:notification_permissions/notification_permissions.dart';

class payment_summary extends StatefulWidget {
  payment_summary({Key? key, required this.deliverAddressList})
      : super(key: key);
  final DeliveryAddressModel deliverAddressList;
  @override
  State<payment_summary> createState() => _payment_summaryState();
}

enum AddressTypes {
  COD,
  Onlinepayment,
}

class _payment_summaryState extends State<payment_summary> {
  var myType = AddressTypes.Onlinepayment;
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  @override
  @override
  void initState() {
    super.initState();
    // AwesomeNotifications().requestPermissionToSendNotifications();
    // getpermition() async {
    //   FirebaseMessaging messaging = FirebaseMessaging.instance;

    //   NotificationSettings settings = await messaging.requestPermission(
    //     alert: true,
    //     announcement: false,
    //     badge: true,
    //     carPlay: false,
    //     criticalAlert: false,
    //     provisional: false,
    //     sound: true,
    //   );

    //   if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    //     print('User granted permission');
    //   } else if (settings.authorizationStatus ==
    //       AuthorizationStatus.provisional) {
    //     print('User granted provisional permission');
    //   } else {
    //     print('User declined or has not accepted permission');
    //   }
    // }
  }

  Widget build(BuildContext context) {
    Myorder_Provider myorder_provider = Provider.of(context);
    My_All_order_Provider my_all_order_provider = Provider.of(context);
    ReviewCartProvider reviewCartProvider = Provider.of(context);
    reviewCartProvider.getReviewCartData();
    Size size = MediaQuery.of(context).size;
    num totalPrice = reviewCartProvider.getTotalPrice();
    num discount = 10;
    num? discountValue = 0;
    num shippingChanrge = 3.7;
    final KeySignaturePad = GlobalKey<SfSignaturePadState>();
    num? total;
    if (totalPrice > 300) {
      discountValue = (totalPrice * discount) / 100;
      total = totalPrice - discountValue + shippingChanrge;
    } else {
      total = totalPrice;
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: App_Colors.Primary_Color,
        title: const Text(
          "Payment Summary",
          style: TextStyle(fontSize: 18),
        ),
      ),
      bottomNavigationBar: ListTile(
        title: Text("Total Amount"),
        subtitle: Text(
          "₹${total}",
          style: TextStyle(
            color: Colors.green[900],
            fontWeight: FontWeight.bold,
            fontSize: 17,
          ),
        ),
        // ignore: sized_box_for_whitespace
        trailing: Container(
          width: 160,
          child: MaterialButton(
            onPressed: () {
              myType == AddressTypes.Onlinepayment
                  ? Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => MyOrder()),
                    )
                  : Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => MyOrder()),
                    );
              reviewCartProvider.getReviewCartDataList.map((e) {
                return myorder_provider.addMyorder_List(
                  cartId: e.cartId,
                  cartImage: e.cartImage,
                  cartName: e.cartName,
                  cartPrice: e.cartPrice,
                  cartQuantity: e.cartQuantity,
                  cartUnit: e.cartunit,
                );
              }).toList();
              reviewCartProvider.getReviewCartDataList.map((e) {
                return my_all_order_provider.addAllMyorder_List(
                    cartId: e.cartId,
                    cartImage: e.cartImage,
                    cartName: e.cartName,
                    cartPrice: e.cartPrice,
                    cartQuantity: e.cartQuantity,
                    cartUnit: e.cartunit,
                    aera: widget.deliverAddressList.aera,
                    city: widget.deliverAddressList.city,
                    firstName: widget.deliverAddressList.firstName,
                    landmark: widget.deliverAddressList.landMark,
                    lastName: widget.deliverAddressList.lastName,
                    mobileNo: widget.deliverAddressList.mobileNo,
                    pincode: widget.deliverAddressList.pinCode,
                    scoiety: widget.deliverAddressList.scoirty,
                    street: widget.deliverAddressList.street);
              }).toList();
            },
            child: Text(
              "Pleace Order",
              style: TextStyle(
                color: App_Colors.white,
              ),
            ),
            color: App_Colors.Primary_Color,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
        ),
      ),
      body: Padding(
          padding: EdgeInsets.only(top: size.height * .01),
          child: ListView.builder(
              itemCount: 1,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    SingleDeliveryItem(
                      address:
                          "aera, ${widget.deliverAddressList.aera}, street, ${widget.deliverAddressList.street}, society ${widget.deliverAddressList.scoirty}, pincode ${widget.deliverAddressList.pinCode}",
                      title:
                          "${widget.deliverAddressList.firstName} ${widget.deliverAddressList.lastName}",
                      number: widget.deliverAddressList.mobileNo!,
                      addressType: widget.deliverAddressList.addressType ==
                              "AddressTypes.Home"
                          ? "Home"
                          : widget.deliverAddressList.addressType ==
                                  "AddressTypes.Other"
                              ? "Other"
                              : "Work",
                    ),
                    Divider(),
                    ExpansionTile(
                      children:
                          reviewCartProvider.getReviewCartDataList.map((e) {
                        return OrderItem(
                          e: e,
                        );
                      }).toList(),
                      title: Text(
                          "Order Items ${reviewCartProvider.getReviewCartDataList.length}"),
                    ),
                    Divider(),
                    ListTile(
                      minVerticalPadding: size.height * .01,
                      leading: const Text(
                        "Sub Total",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      trailing: Text(
                        "₹${totalPrice}",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    ListTile(
                      minVerticalPadding: size.height * .01,
                      leading: Text(
                        "Shipping Charge",
                        style: TextStyle(
                            // fontWeight: FontWeight.bold,
                            color: Colors.grey[600]),
                      ),
                      trailing: Text(
                        "₹$shippingChanrge",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    ListTile(
                      minVerticalPadding: size.height * .01,
                      leading: Text(
                        "Compen Discount",
                        style: TextStyle(
                            // fontWeight: FontWeight.bold,
                            color: Colors.grey[600]),
                      ),
                      trailing: Text(
                        "₹$discountValue",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Divider(),
                    ListTile(
                      leading: Text("Payment Option"),
                    ),
                    RadioListTile(
                      value: AddressTypes.COD,
                      groupValue: myType,
                      title: Text("COD(Cash On Dilivery)"),
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
                      value: AddressTypes.Onlinepayment,
                      groupValue: myType,
                      title: Text("Online Payment"),
                      onChanged: (AddressTypes? value) {
                        setState(() {
                          myType = value!;
                        });
                      },
                      secondary: Icon(
                        Icons.payment_rounded,
                        color: App_Colors.Primary_Color,
                      ),
                    ),
                  ],
                );
              })),
    );
  }
}
