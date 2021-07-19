import 'package:accessories_utube/constants.dart';
import 'package:accessories_utube/customed_widgets/productsView.dart';
import 'package:accessories_utube/models/product.dart';
import 'package:accessories_utube/screens/CartScreen.dart';
import 'package:accessories_utube/screens/login_screen.dart';
import 'package:accessories_utube/screens/product_info.dart';
import 'package:accessories_utube/services/auth.dart';
import 'package:accessories_utube/services/store.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Functions.dart';
import 'admin_ManageProduct.dart';
import 'adming_EditProduct.dart';
class HomePage extends StatefulWidget {
  @override
  static String id= 'HomePage';


  @override
  _HomePageState createState() => _HomePageState();

}

class _HomePageState extends State<HomePage> {

  int tabBarIndex=0;
  int bottomNavIndex=0;
  final _store=Store();
  List<Product> products;


  Widget build(BuildContext context) {

    double heightMedia= MediaQuery.of(context).size.height;
    double widthMedia= MediaQuery.of(context).size.width;
    return Container(
      child: DefaultTabController(
        initialIndex: tabBarIndex,
        length: 4,
        child: Scaffold(
          bottomNavigationBar: Theme(
            data: Theme.of(context).copyWith(
              canvasColor: KMainColor
            ),
            child: BottomNavigationBar(
              currentIndex: bottomNavIndex,
              onTap: (value)async{
                if(value==2){
                await  showDialog(context: context, builder: (context)=>  AlertDialog(title: Text('Are you sure you want to log out?'),actions: [
                MaterialButton(onPressed: ()async{
                SharedPreferences pref=await SharedPreferences.getInstance();
                pref.remove(KeepMeLoggedIn);
                Auth auth=Auth();
                auth.SignOut();
                Navigator.popAndPushNamed(context, LoginScreen.id);
                },child: Text('Yes'),),
                MaterialButton(onPressed: (){
                Navigator.pop(context);
                },child: Text('No'),)
                ],) );


                }
                setState(() {
                  bottomNavIndex=value;
                });
              },
              selectedItemColor: Colors.black,
              elevation: 15,
              unselectedItemColor: Colors.purple,
              items: [
                BottomNavigationBarItem(
                  icon: Icon(Icons.perm_identity_sharp),
                label: 'Profile',

                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.perm_identity_sharp),
                  label: 'Offers',

                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.close),
                  label: 'SignOut',

                ),
              ],
            ),
          ),
          backgroundColor: KMainColor,
          appBar: AppBar(
            actions: [
              IconButton(
                onPressed: (){
                  Navigator.pushNamed(context, CartScreen.id);
                },
                icon: Icon(Icons.shopping_cart,color: Colors.black,),
              )
            ],
            //leading:
            title: Text('DISCOVER',style: TextStyle(
              color: Colors.black,
            ),),
            backgroundColor: KMainColor,
            elevation: 0,
            bottom:TabBar(
              labelPadding: EdgeInsets.only(bottom:heightMedia*.01 ),
              onTap: (value){
                setState(() {
                  tabBarIndex=value;
                });
              },
              //indicatorPadding: EdgeInsets.only(bottom:heightMedia*.02 ),
              indicatorColor: Colors.black,
              tabs: [
                Text('Bracelet',
                  style: TextStyle(
                    color:tabBarIndex==0?Colors.black:Colors.purple,
                    fontSize: tabBarIndex==0?16: null,
                    fontWeight: tabBarIndex==0?FontWeight.bold:null
                  ),),
                Text('Ring',
                  style: TextStyle(
                      color:tabBarIndex==1?Colors.black:Colors.purple,
                      fontSize: tabBarIndex==1?16: null,
                      fontWeight: tabBarIndex==1?FontWeight.bold:null
                  ),),
                Text('Necklace',
                  style: TextStyle(
                      color:tabBarIndex==2?Colors.black:Colors.purple,
                      fontSize: tabBarIndex==2?16: null,
                      fontWeight: tabBarIndex==2?FontWeight.bold:null
                  ),),
                Text('Bag',
                  style: TextStyle(
                      color:tabBarIndex==3?Colors.black:Colors.purple,
                      fontSize: tabBarIndex==3?16: null,
                      fontWeight: tabBarIndex==3?FontWeight.bold:null
                  ),),


              ],
            ),
          ),
          body: TabBarView(
            children: [
              BraceletScreen(context,KBraceletsCateg,products),
             // RingTryScreen(context),
              BraceletScreen(context,KRingCateg,products),
              BraceletScreen(context,KRingCateg,products),
             // BraceletScreen(context,KRingCateg,products),
              BraceletScreen(context,KRingCateg,products),


              //ProductCategScreen(context,KBraceletsCateg,products),
            ],
          ),
        ),

      ),
    );

  }

 Widget BraceletScreen(context,String KCatg,List<Product> Pr) {
   double heightMedia= MediaQuery.of(context).size.height;
   double widthMedia= MediaQuery.of(context).size.width;
    return StreamBuilder<QuerySnapshot<Map>>(
        stream: _store.LoadProductsStream(),
        builder:(context,snapshot){
          if(snapshot.hasData){
            List<Product> finalProducts=[];

            //  List<Product> snlist=snapshot.data.docs;
            for (var item in snapshot.data.docs){
              var data= item.data();
              // print(item.id); // this is the item document id.
              finalProducts.add(Product(
                  pProductId: item.id,
                  pImageLocation: data[KProductImage],
                  pCateg: data[KProductCategory],
                  pDescrip: data[KProductDescription],
                  pPrice: data[KProductPrice],
                  pName: data[KProductName]

              ));
              Pr=[...finalProducts];
              finalProducts.clear();
              finalProducts=getProductsByCateg( KCatg,Pr);

            }
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              itemCount:finalProducts.length ,
              itemBuilder: (context, index) => Padding(
                padding:  EdgeInsets.symmetric(horizontal: widthMedia*.02,vertical: heightMedia*.02),
                child: GestureDetector(
                   onTap: (){
                     Navigator.pushNamed(context, ProductInfo.id,arguments: finalProducts[index]);
                   },
                  child: Stack(
                    children: [
                      Positioned.fill(
                          child: Image(image:AssetImage(finalProducts[index].pImageLocation),
                            fit: BoxFit.fill,
                          )),
                      Positioned(
                        bottom: 0,
                        child: Opacity(
                          opacity: .9,
                          child: Container(
                            height: heightMedia*.08,
                            color: Colors.transparent,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  finalProducts[index].pName,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold
                                  ),),
                                Text(
                                  finalProducts[index].pCateg,
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      fontSize: 12
                                  ),
                                ),
                                Text('Price:${finalProducts[index].pPrice} LE',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );}
          // ignore: missing_return
          else if(snapshot.hasError){
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('${snapshot.error.toString()}')));
            return null;
          }else if(snapshot.connectionState!=ConnectionState.done){
            return Center(child: CircularProgressIndicator());
          }else{
            return CircularProgressIndicator();
          }
        }
    );
 }






Widget  RingTryScreen(context,String kProductCateg,List<Product> product) {
  double heightMedia= MediaQuery.of(context).size.height;
  double widthMedia= MediaQuery.of(context).size.width;
  List<Product> finalProducts=[];


  finalProducts=getProductsByCateg( kProductCateg,product);

    //  finalProducts=[...getProducts];



  return GridView.builder(
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
    itemCount:finalProducts.length,
    itemBuilder: (context, index) => Padding(
      padding:  EdgeInsets.symmetric(horizontal: widthMedia*.02,vertical: heightMedia*.02),
      child: GestureDetector(

        child: Stack(
          children: [
            Positioned.fill(
                child: Image(image:AssetImage(finalProducts[index].pImageLocation),
                  fit: BoxFit.fill,
                )),
            Positioned(
              bottom: 0,
              child: Opacity(
                opacity: .9,
                child: Container(
                  height: heightMedia*.08,
                  color: Colors.transparent,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        finalProducts[index].pName,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold
                        ),),
                      Text(
                        finalProducts[index].pCateg,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontSize: 12
                        ),
                      ),
                      Text('Price:${finalProducts[index].pPrice} LE',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    ),
  );
}

/*
List<Product> getProductsByCateg({@required String KProductCateg}) {
    List<Product> finalProducts=[];
    for(var product in _products){
      if(product.pCateg==KProductCateg){
        finalProducts.add(product);
        print('final products are ; $finalProducts');
        print('getProducts are: $_products');
      }
    }

    return finalProducts;
  }
 */

  AlertDialog LoggingOutDialouge ()=> AlertDialog(title: Text('Are you sure you want to log out?'),actions: [
   MaterialButton(onPressed: ()async{
  SharedPreferences pref=await SharedPreferences.getInstance();
  pref.remove(KeepMeLoggedIn);
  Auth auth=Auth();
  auth.SignOut();
  Navigator.popAndPushNamed(context, LoginScreen.id);
},child: Text('Yes'),),
MaterialButton(onPressed: (){
Navigator.pop(context);
},child: Text('No'),)
],);


}
