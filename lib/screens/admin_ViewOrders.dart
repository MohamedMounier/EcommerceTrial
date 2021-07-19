import 'package:accessories_utube/constants.dart';
import 'package:accessories_utube/models/Orders.dart';
import 'package:accessories_utube/screens/admin_orderDetails.dart';
import 'package:accessories_utube/services/store.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AdminViewOrders extends StatelessWidget {
  static String id = 'Admin View Orders';
  final Store _store = Store();

  @override
  Widget build(BuildContext context) {
    double heightMedia = MediaQuery.of(context).size.height;
    double widthMedia = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: KMainColor,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
          color: Colors.black,
        ),
        backgroundColor: KMainColor,
        title: Text(
          'Orders List',
          style: TextStyle(fontFamily: 'Pacifico', color: Colors.black),
        ),
      ),
      body: StreamBuilder<QuerySnapshot<Map>>(
        stream: _store.LoadOrders(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Orders> orders = [];
            for (var order in snapshot.data.docs) {
              var eachDoc = order.data();
              orders.add(Orders(
                  DocumentId: order.id,
                  OrderAddress: eachDoc[KProductuserAddress],
                  OrderTotalPrice: eachDoc[KTotalPrice]));
              print(orders);
            }
            return ListView.builder(
              itemCount: orders.length,
              itemBuilder: (context, index) => Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: widthMedia * .02, vertical: heightMedia * .01),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, AdminOrderDetails.id,
                        arguments: orders[index].DocumentId);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.purple[300],
                        borderRadius: BorderRadius.circular(50)),
                    height: heightMedia * .15,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'The Total Price is :-   ${orders[index].OrderTotalPrice.toString()} LE ',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: heightMedia * .02,
                        ),
                        Text(
                          ' Address is :-    ${orders[index].OrderAddress}',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
