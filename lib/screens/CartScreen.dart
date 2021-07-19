import 'package:accessories_utube/customed_widgets/PopUpMenuItem.dart';
import 'package:accessories_utube/provider/CartItem.dart';
import 'package:accessories_utube/screens/HomePage.dart';
import 'package:accessories_utube/screens/product_info.dart';
import 'package:accessories_utube/services/store.dart';
import 'package:flutter/material.dart';
import 'package:accessories_utube/models/product.dart';
import 'package:accessories_utube/constants.dart';

import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  static String id = 'CartScreen';
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  int _countingItems = 1;

  @override
  Widget build(BuildContext context) {
    List<Product> productProvided = Provider.of<CartItem>(context).product;

    /*
    this works if there is no other place navigating to this screen as
    the (HomePage) screen doesn't have the same arguments am getting from the
     Bracelet Screen (the widget that gets the data ), so we try to use provider instead of
     the next line :-
    Product product1= ModalRoute.of(context).settings.arguments;

     */

    final double appbarHeight = AppBar().preferredSize.height;
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    double heightMedia = MediaQuery.of(context).size.height;
    double widthMedia = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
        backgroundColor: KMainColor,
        appBar: (AppBar(
          title: Text(
            'Your Cart',
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
          backgroundColor: KMainColor,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            color: Colors.black,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.edit,
                color: Colors.black,
              ),
            )
          ],
        )),
        body: LayoutBuilder(builder: (context, constraints) {
          if (productProvided.isNotEmpty) {
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                      itemCount: productProvided.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTapUp: (details) async {
                            await ShowMenu(details,context,productProvided[index]);


                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: widthMedia * .02,
                                vertical: heightMedia * .02),
                            child: Center(
                              child: Row(
                                // mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  /*
                            Container(
                              decoration: BoxDecoration(
                                color:Colors.yellow,
                                shape: BoxShape.circle
                              ),
                                width: widthMedia*.4,
                                height: heightMedia*.3,
                                child: Image(image: AssetImage(productProvided[index].pImageLocation),
                               fit: BoxFit.fill,

                                )
                      ),
                             */
                                  CircleAvatar(
                                    radius: heightMedia * .06,
                                    backgroundImage: AssetImage(
                                        productProvided[index].pImageLocation),
                                  ),
                                  Column(
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            'name : ',
                                            style: TextStyle(fontSize: 18),
                                          ),
                                          Text(
                                            '${productProvided[index].pName}',
                                            style: TextStyle(
                                                color: Colors.purple,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 18),
                                          ),
                                        ],
                                      ),
                                      // Text('Description :- ${productProvided[index].pDescrip}'),
                                      Row(
                                        children: [
                                          Text(
                                            'Quantity : ',
                                            style: TextStyle(fontSize: 18),
                                          ),
                                          Text(
                                            '${productProvided[index].pQuantity}',
                                            style: TextStyle(
                                                color: Colors.purple,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 18),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            'Price : ',
                                            style: TextStyle(fontSize: 18),
                                          ),
                                          Text(
                                            '${productProvided[index].pPrice} LE',
                                            style: TextStyle(
                                                color: Colors.purple,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 18),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            'Total Price : ',
                                            style: TextStyle(fontSize: 18),
                                          ),
                                          Text(
                                            ' ${int.parse(productProvided[index].pPrice) * productProvided[index].pQuantity} LE',
                                            style: TextStyle(
                                                color: Colors.purple,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 18),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: EdgeInsetsDirectional.only(
                                              end: widthMedia * .009),
                                          child: Text(
                                            '${productProvided[index].pQuantity}',
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsetsDirectional.only(
                                              end: widthMedia * .09),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            // mainAxisAlignment: MainAxisAlignment.spaceAround,
                                            children: [
                                              Container(
                                                width: widthMedia * .09,
                                                height: heightMedia * .05,
                                                decoration: BoxDecoration(
                                                    color: Colors.black54,
                                                    shape: BoxShape.circle),
                                                child: Center(
                                                  child: IconButton(
                                                    onPressed: () {},
                                                    icon: Icon(
                                                      Icons.remove,
                                                      size: 25,
                                                      color: Colors.yellow,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                width: widthMedia * .09,
                                                height: heightMedia * .05,
                                                decoration: BoxDecoration(
                                                    color: Colors.black54,
                                                    shape: BoxShape.circle),
                                                child: IconButton(
                                                  onPressed: () {},
                                                  icon: Icon(
                                                    Icons.add,
                                                    size: 25,
                                                    color: Colors.yellow,
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                ),
                ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.black87)),
                    onPressed: () {
                      PriceDialoug(context,productProvided);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        //Icon(Icons.add_shopping_cart,color: Colors.yellow,),
                        Text(
                          'Order Now !',
                          style: TextStyle(color: Colors.yellow, fontSize: 20),
                        )
                      ],
                    )),
              ],
            );
          } else {
            return Column(
              children: [
                Container(
                    color: KMainColor,
                    height: heightMedia -
                        (appbarHeight) -
                        (statusBarHeight) -
                        heightMedia * .07,
                    child: Center(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Your Cart is empty',
                          style:
                              TextStyle(fontSize: 25, color: Colors.blueGrey),
                        ),
                      ],
                    ))),
                Container(
                  height: heightMedia * .07,
                  child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.black87)),
                      onPressed: () {
                        Navigator.pushNamed(context, HomePage.id);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.add_shopping_cart_rounded,
                            color: Colors.yellow,
                          ),
                          //Icon(Icons.add_shopping_cart,color: Colors.yellow,),
                          Text(
                            ' Add Products ',
                            style:
                                TextStyle(color: Colors.yellow, fontSize: 18),
                          )
                        ],
                      )),
                ),
              ],
            );
          }
        })

        /*
        we use this with line number 24 (getting arguments only(not using provider))
        Center(
        child: Row(
          children: [
            Container(
              width: widthMedia*.4,
                height: heightMedia*.3,
                child: Image(image: AssetImage(product1.pImageLocation))),
            Column(
              children: [
                Text('Item name :- ${productProvided.pName}'),
                Text('Description :- ${product1.pDescrip}'),
                Text('Quantity :- ${product1.pQuantity}'),
                Text('price for one item :- ${product1.pPrice}'),
                Text('Total Price :- ${int.parse(product1.pPrice)*product1.pQuantity}'),


              ],
            )
          ],
        ),
      ),
         */
        );
  }


 void ShowMenu(details,context,product)async{
   double dx = details.globalPosition.dx;
   double dy = details.globalPosition.dy;
   double dx2 = MediaQuery.of(context).size.width - dx;
   double dy2 =  MediaQuery.of(context).size.height - dy;
  await showMenu(context: context,
      position:  RelativeRect.fromLTRB(dx, dy, dx, dy),
      items: [

        MyPopUPItem(
          child: Text('Edit'),
          onClickeD: () {
            Navigator.pop(context);
            Provider.of<CartItem>(context,listen: false).deleteFromCart(product);

            Navigator.pushNamed(context, ProductInfo.id,arguments: product);

          },
        ),
        MyPopUPItem(
          child: Text('Delete'),
          onClickeD: () {
            Navigator.pop(context);
            Provider.of<CartItem>(context,listen: false).deleteFromCart(product);


          },
        ),
      ]
  );


  }




  minusPieces() {
    if (_countingItems > 1) {
      setState(() {
        _countingItems--;
      });
    }
  }

  addPieces() {
    setState(() {
      _countingItems++;
    });
  }

  void PriceDialoug(context,List<Product> products)async {
      var totalPrice=getTotalPrice(products);
      var address;
      AlertDialog alertDialog=AlertDialog(
        content: TextFormField(
          onChanged: (value){
            address=value;
          },
          decoration: InputDecoration(
            hintText: 'put your address'
          ),
        ),
        title: Text('TotalPrice = \$ '
            '$totalPrice'),
        actions: [
          MaterialButton(
              child: Text('Confirm'),
              onPressed: (){
            final _store= Store();
            _store.StoreData({
              KTotalPrice:totalPrice,
              KProductuserAddress:address
            }, products);
           ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(
             'Order Successfully !'
           )));
           Navigator.pop(context);
          })
        ],
      );
      await showDialog(context: context,
          builder:(context) {
            return alertDialog ;
          },
      );
  }
  getTotalPrice(List<Product> products){
    int price=0;
    for(var item in products){
      price+=int.parse(item.pPrice)*item.pQuantity;
    }
    return price;
  }


}

/*
 Expanded(
            child: ListView.builder(
              itemCount: productProvided.length,
                itemBuilder: (context,index){
                return Padding(
                  padding:  EdgeInsets.symmetric(horizontal: widthMedia*.02,vertical: heightMedia*.02),
                  child: Center(
                    child: Row(
                     // mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        /*
                        Container(
                          decoration: BoxDecoration(
                            color:Colors.yellow,
                            shape: BoxShape.circle
                          ),
                            width: widthMedia*.4,
                            height: heightMedia*.3,
                            child: Image(image: AssetImage(productProvided[index].pImageLocation),
                           fit: BoxFit.fill,

                            )
                    ),
                         */
                        CircleAvatar(
                          radius: heightMedia*.06,
                          backgroundImage: AssetImage(productProvided[index].pImageLocation),


                        ),

                        Column(
                          children: [
                            Row(
                              children: [
                                Text('name : ',
                                style: TextStyle(
                                  fontSize: 18
                                ),
                                ),
                                Text('${productProvided[index].pName}',
                                  style: TextStyle(
                                    color: Colors.purple,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 18
                                  ),
                                ),
                              ],
                            ),
                           // Text('Description :- ${productProvided[index].pDescrip}'),
                            Row(
                              children: [

                                Text('Quantity : ',style: TextStyle(
                                    fontSize: 18
                                ),),
                                Text('${productProvided[index].pQuantity}',
                                  style: TextStyle(
                                      color: Colors.purple,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 18
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text('Price : ',
                                  style: TextStyle(
                                      fontSize: 18
                                  ),
                                ),
                                Text('${productProvided[index].pPrice} LE',style: TextStyle(
                                    color: Colors.purple,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 18
                                ),

                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text('Total Price : ',
                                  style: TextStyle(
                                      fontSize: 18
                                  ),
                                ),
                                Text(' ${int.parse(productProvided[index].pPrice)*productProvided[index].pQuantity} LE',
                                  style: TextStyle(
                                      color: Colors.purple,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 18
                                  ),
                                ),
                              ],
                            ),


                          ],
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.only(end: widthMedia*.009),
                                child: Text('${productProvided[index].pQuantity}',style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold
                                ),),
                              ),
                                Padding(
                                  padding:  EdgeInsetsDirectional.only(end: widthMedia*.09),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                   // mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      Container(
                                        width: widthMedia*.09,
                                        height: heightMedia*.05,
                                        decoration: BoxDecoration(
                                          color: Colors.black54,
                                          shape: BoxShape.circle
                                        ),
                                        child: Center(child: IconButton(
                                            onPressed: (){},
                                      icon: Icon(Icons.remove,size: 25,color: Colors.yellow,),),
                                      ),),
                                      Container(
                                        width: widthMedia*.09,
                                        height: heightMedia*.05,
                                        decoration: BoxDecoration(
                                            color: Colors.black54,
                                            shape: BoxShape.circle
                                        ),
                                        child: IconButton(
                                          onPressed: (){},
                                          icon: Icon(Icons.add,size: 25,color: Colors.yellow,),
                                        ),
                                      )
                                    ],
                                  ),
                                )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
                }
            ),
          ),
 */
