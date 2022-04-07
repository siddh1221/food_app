import 'package:flutter/material.dart';
import 'package:food_app/constant/color/colors.dart';
import 'package:food_app/model/Review_cart.dart';
import 'package:food_app/provider/my_oreder_provider.dart';
import 'package:provider/provider.dart';

class MyOrder extends StatefulWidget {
  MyOrder({Key? key}) : super(key: key);

  @override
  State<MyOrder> createState() => _MyOrderState();
}

class _MyOrderState extends State<MyOrder> {
  @override
  @override
  void initState() {
    Myorder_Provider myorder_provider = Provider.of(context, listen: false);
    myorder_provider.getMyOrderData();
    super.initState();
  }

  Widget build(BuildContext context) {
    Myorder_Provider myorder_provider = Provider.of(context);

    return Scaffold(
        backgroundColor: App_Colors.ScafoldeColor,
        appBar: AppBar(
          backgroundColor: App_Colors.Primary_Color,
          title: const Text(
            "Your Order",
            style: TextStyle(fontSize: 18),
          ),
        ),
        body: ListView.builder(
          itemCount: myorder_provider.MyOrderList.length,
          itemBuilder: (context, index) {
            ReviewCartModel data = myorder_provider.MyOrderList[index];
            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: ListTile(
                leading: Image.network(
                  data.cartImage!,
                  width: 60,
                ),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      data.cartName!,
                      style: TextStyle(
                        color: Colors.grey[600],
                      ),
                    ),
                    Text(
                      data.cartunit,
                      style: TextStyle(
                        color: Colors.grey[600],
                      ),
                    ),
                    Text(
                      "\$${data.cartPrice! * data.cartQuantity!}",
                    ),
                  ],
                ),
                subtitle: Text(data.cartQuantity.toString()),
              ),
            );
          },
        ));
  }
}
