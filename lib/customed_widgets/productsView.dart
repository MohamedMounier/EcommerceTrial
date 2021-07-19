import 'package:accessories_utube/models/product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../Functions.dart';
import '../constants.dart';
import 'package:accessories_utube/services/store.dart';


Widget ProductCategScreen(  context,String KProductCateg,List<Product> product) {
  double heightMedia= MediaQuery.of(context).size.height;
  double widthMedia= MediaQuery.of(context).size.width;

          List<Product> finalProducts=[];
          finalProducts=getProductsByCateg(KProductCateg,product);

          if(finalProducts!=null){
          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            itemCount:finalProducts.length ,
            itemBuilder: (context, index) => Padding(
              padding:  EdgeInsets.symmetric(horizontal: widthMedia*.02,vertical: heightMedia*.02),
              child: GestureDetector(
                onTapUp:(details){
                  double dx=details.globalPosition.dx;
                  double dy=details.globalPosition.dy;
                  double dx2=widthMedia-dx;
                  double dy2=widthMedia-dy;
                  showMenu(context: context,
                      position: RelativeRect.fromLTRB(dx, dy, dx, dy),
                      items: [


                      ]
                  );
                } ,
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
          );}else{
            getProductsByCateg(KProductCateg, product);
            return Center(child: CircularProgressIndicator());
          }
        // ignore: missing_return

      }

