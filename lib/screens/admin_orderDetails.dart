import 'package:accessories_utube/constants.dart';
import 'package:accessories_utube/models/product.dart';
import 'package:accessories_utube/services/store.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdminOrderDetails extends StatelessWidget {
  final store = Store();
  static String id = 'AdminOrderDetails';
  @override
  Widget build(BuildContext context) {
    String prodDoc = ModalRoute.of(context).settings.arguments;
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
            'Order Details',
            style: TextStyle(fontFamily: 'Pacifico', color: Colors.black),
          ),
        ),
        body: StreamBuilder<QuerySnapshot<Map>>(
          stream: store.LoadOrdersDetails(prodDoc),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Product> products = [];
              for (var product in snapshot.data.docs) {
                var data=product.data();
                products.add(Product(
                  pName: data[KProductName],
                  pPrice: data[KProductPrice],
                  pCateg: data[KProductCategory],
                  pQuantity:data[KProductQuantity],
                  pImageLocation: data[KProductImage]
                ));
              }

              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                        itemCount: products.length,
                        itemBuilder: (context, index) {
                          return Padding(
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
                                        products[index].pImageLocation),
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
                                            '${products[index].pName}',
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
                                            '${products[index].pQuantity}',
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
                                            'Category : ',
                                            style: TextStyle(fontSize: 18),
                                          ),
                                          Text(
                                            '${products[index].pCateg}',
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
                                            '${products[index].pPrice} LE',
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
                                            ' ${int.parse(products[index].pPrice) * products[index].pQuantity} LE',
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
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: EdgeInsetsDirectional.only(
                                              end: widthMedia * .009),
                                          child: Text(
                                            '${products[index].pQuantity}',
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsetsDirectional.only(
                                              end: widthMedia * .09),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
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
                          );
                        }),
                  ),
                  Padding(
                    padding:  EdgeInsets.symmetric(vertical: heightMedia*.01,horizontal: widthMedia*.06),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton(
                          style: ButtonStyle(
                              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20))),
                              backgroundColor: MaterialStateProperty.all(Colors.purple)),
                          onPressed: (){

                          },
                          child: Text(
                            'Confirm Orders',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        ElevatedButton(
                          style: ButtonStyle(
                              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20))),
                              backgroundColor: MaterialStateProperty.all(Colors.purple)),
                          onPressed: (){

                          },
                          child: Text(
                            'Delete Orders',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              );
            } else if (snapshot.hasError) {
              print(snapshot.error);
              return Text('Kindly contact us,as there is an error');
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ));
  }
}
