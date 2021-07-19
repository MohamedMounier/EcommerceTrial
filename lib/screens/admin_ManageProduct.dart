import 'package:accessories_utube/customed_widgets/PopUpMenuItem.dart';
import 'package:accessories_utube/models/product.dart';
import 'package:accessories_utube/screens/adming_EditProduct.dart';
import 'package:accessories_utube/services/store.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:accessories_utube/constants.dart';
import 'package:accessories_utube/constants.dart';

import '../Functions.dart';
import '../constants.dart';

class ManageProduct extends StatefulWidget {
  static String id='ManageProduct';

  @override
  _ManageProductState createState() => _ManageProductState();
}

class _ManageProductState extends State<ManageProduct> {
  final _store=Store();


  @override
  Widget build(BuildContext context) {
    double heightMedia= MediaQuery.of(context).size.height;
    double widthMedia= MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: KMainColor,
      appBar: AppBar(
        leading: IconButton(icon:Icon(Icons.arrow_back),
          onPressed: (){Navigator.pop(context);},
          color: Colors.purple,),
        backgroundColor: KMainColor,
        title: Text('Start Editing your products',
          style:TextStyle(fontFamily: 'Pacifico',
              color: Colors.purple
          ) ,
        ),),
      body: StreamBuilder<QuerySnapshot<Map>>(
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
            }
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          itemCount:finalProducts.length ,
            itemBuilder: (context, index) => Padding(
              padding:  EdgeInsets.symmetric(horizontal: widthMedia*.02,vertical: heightMedia*.02),
              child: GestureDetector(
                onTapUp:(details)async{
                  double dx=details.globalPosition.dx;
                  double dy=details.globalPosition.dy;
                  double dx2=widthMedia-dx;
                  double dy2=widthMedia-dy;
                  await showMenu(context: context,
                      position: RelativeRect.fromLTRB(dx, dy, dx, dy),
                      items: [

                  MyPopUPItem(child: Text('Edit'),onClickeD: (){
                    Navigator.pushNamed(context, EditProduct.id,arguments:finalProducts[index]);

                  },),
                        // enhance here by showing an alert dialouge asking if he is sure to delete
                        MyPopUPItem(child: Text('Delete'),onClickeD: (){

                          _store.DeleteProduct(finalProducts[index].pProductId);
                          Navigator.pop(context);
                        },),
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
      ),
    );
  }
}

/*
FutureBuilder<List<Product>>(
        future: _store.LoadProducts(),
        builder:(context,snapshot){
          if(snapshot.hasData){
           List<Product> finalProducts=snapshot.data;
            return ListView.builder(


          itemCount:finalProducts.length ,
            itemBuilder: (context, index) => Text('${finalProducts[index].pName}'),
        );}
        // ignore: missing_return
        else if(snapshot.hasError){
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('${snapshot.error.toString()}')));
          }else if(snapshot.connectionState!=ConnectionState.done){
          return Center(child: CircularProgressIndicator());
          }else{
          return CircularProgressIndicator();
          }
        }
      ),
 */
/*
ListView.builder(


          itemCount:finalProducts.length ,
            itemBuilder: (context, index) => Text('${finalProducts[index].pName}'),
        );}
 */

