import 'package:accessories_utube/constants.dart';
import 'package:accessories_utube/screens/admin_ManageProduct.dart';
import 'package:accessories_utube/screens/admin_ViewOrders.dart';
import 'package:flutter/material.dart';

import 'admin_addProduct.dart';
class AdminHomePage extends StatelessWidget {
  @override
  static String id= 'AdminHomePage';
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KMainColor,
      appBar: AppBar(backgroundColor: KMainColor,
        centerTitle: true,
        leading: Icon(Icons.arrow_back,color: Colors.purple,),
        title: Text('Lets Do it',
          style:TextStyle(fontFamily: 'Pacifico',
            color: Colors.purple
          ) ,
        ),),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(width: double.infinity,),
          ElevatedButton(
            style: ButtonStyle(
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20))),
                backgroundColor: MaterialStateProperty.all(Colors.purple)),
            onPressed: (){
              Navigator.pushNamed(context, AdminAddProduct.id);
            },
            child: Text(
              'Add Product',
              style: TextStyle(color: Colors.white),
            ),
          ),
          ElevatedButton(
            style: ButtonStyle(
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20))),
                backgroundColor: MaterialStateProperty.all(Colors.purple)),
            onPressed: (){
              Navigator.pushNamed(context, ManageProduct.id);
            },
            child: Text(
              'Edit Product',
              style: TextStyle(color: Colors.white),
            ),
          ),
          ElevatedButton(
            style: ButtonStyle(
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20))),
                backgroundColor: MaterialStateProperty.all(Colors.purple)),
            onPressed: (){
              Navigator.pushNamed(context, AdminViewOrders.id);
            },
            child: Text(
              'View Orders',
              style: TextStyle(color: Colors.white),
            ),
          ),

        ],
      ),
    );
  }
}