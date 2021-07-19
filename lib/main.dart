import 'package:accessories_utube/constants.dart';
import 'package:accessories_utube/provider/CartItem.dart';
import 'package:accessories_utube/provider/adminMode.dart';
import 'package:accessories_utube/provider/modelHud.dart';
import 'package:accessories_utube/screens/AdminHomePage.dart';
import 'package:accessories_utube/screens/CartScreen.dart';
import 'package:accessories_utube/screens/HomePage.dart';
import 'package:accessories_utube/screens/admin_ViewOrders.dart';
import 'package:accessories_utube/screens/admin_addProduct.dart';
import 'package:accessories_utube/screens/admin_ManageProduct.dart';
import 'package:accessories_utube/screens/admin_orderDetails.dart';
import 'package:accessories_utube/screens/adming_EditProduct.dart';
import 'package:accessories_utube/screens/login_screen.dart';
import 'package:accessories_utube/screens/product_info.dart';
import 'package:accessories_utube/screens/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/HomePage.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  bool isUserLogedIn=false;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<SharedPreferences>(
      future: SharedPreferences.getInstance(),
      builder: (context, snapshot) {
        if(!snapshot.hasData){
          return MaterialApp(
            home: Scaffold(
              backgroundColor: KMainColor,
                body: Center(child: CircularProgressIndicator())),
          );
        }else if(snapshot.hasError){
          print(snapshot.error.toString());
          return Center(child: CircularProgressIndicator());
        }else{
          isUserLogedIn=snapshot.data.getBool(KeepMeLoggedIn)??false;
          return MultiProvider(
            providers: [
              ChangeNotifierProvider<ModelHud>(
                  create: (context)=>ModelHud()),
              ChangeNotifierProvider<CartItem>(
                  create: (context)=>CartItem()),
              ChangeNotifierProvider<AdminMode>(
                  create: (context)=>AdminMode()),
            ],
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              initialRoute:isUserLogedIn?HomePage.id: LoginScreen.id,
              routes: {
                LoginScreen.id:(context)=>LoginScreen(),
                SignUpScreen.id:(context)=>SignUpScreen(),
                HomePage.id:(context)=>HomePage(),
                AdminHomePage.id:(context)=>AdminHomePage(),
                AdminAddProduct.id:(context)=>AdminAddProduct(),
                ManageProduct.id:(context)=>ManageProduct(),
                EditProduct.id:(context)=>EditProduct(),
                ProductInfo.id:(context)=>ProductInfo(),
                CartScreen.id:(context)=>CartScreen(),
                AdminViewOrders.id:(context)=>AdminViewOrders(),
                AdminOrderDetails.id:(context)=>AdminOrderDetails(),





              },

            ),
          );
        }
      },
    );
  }
}

