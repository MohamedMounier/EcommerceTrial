
import 'package:accessories_utube/customed_widgets/custom_textFields.dart';
import 'package:accessories_utube/models/product.dart';
import 'package:accessories_utube/services/store.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:accessories_utube/constants.dart';
import 'package:accessories_utube/services/store.dart';
import 'admin_ManageProduct.dart';

class EditProduct extends StatefulWidget {
  static String id = 'EditProduct';

  @override
  _EditProductState createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  String _name, _price_, _description, _category, _imageLocation;

  final GlobalKey<FormState> formAdminKey = GlobalKey<FormState>();



  final _store = Store();

  Widget build(BuildContext context) {
    Product productEdits = ModalRoute.of(context).settings.arguments;


    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: KMainColor,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
          color: Colors.purple,
        ),
        backgroundColor: KMainColor,
        title: Text(
          'Start adding your product',
          style: TextStyle(fontFamily: 'Pacifico', color: Colors.purple),
        ),
      ),
      body: SingleChildScrollView(

        child: Form(
          key: formAdminKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              SizedBox(
                width: double.infinity,
              ),

              Container(
                width: width*.6,
                height: height*.35,
                child: GridView.builder(
                  //shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1),
                  itemCount: 1,
                  itemBuilder: (context, index) => Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: width * .02,
                        vertical: height * .02),
                    child: Stack(
                      children: [
                        Positioned.fill(
                            child: Image(
                              image:
                              AssetImage(productEdits.pImageLocation),
                              fit: BoxFit.fill,
                            )),
                        Positioned(
                          bottom: 0,
                          child: Opacity(
                            opacity: .9,
                            child: Container(
                              height: height * .08,
                              color: Colors.transparent,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    productEdits.pName,
                                    textAlign: TextAlign.center,
                                    style:
                                    TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    productEdits.pCateg,
                                    textAlign: TextAlign.start,
                                    style: TextStyle(fontSize: 12),
                                  ),
                                  Text(
                                    'Price:${productEdits.pPrice} LE',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
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
              ),
              //Text('Product id is ${productEdits.pProductId}',style: TextStyle(fontSize: 22),),

              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: width * .07, vertical: height * .01),
                child: CustomTextField(
                  OnClicked: (value) {
                    _name = value;
                  },
                  hintText: ' Product Name',
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: width * .07, vertical: height * .01),
                child: CustomTextField(
                  OnClicked: (value) {
                    _price_ = value;
                  },
                  hintText: ' Product Price',
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: width * .07, vertical: height * .01),
                child: CustomTextField(
                  OnClicked: (value) {
                    _description = value;
                  },
                  hintText: ' Product Description',
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: width * .07, vertical: height * .01),
                child: CustomTextField(
                  OnClicked: (value) {
                    _category = value;
                  },
                  hintText: ' Product Category',
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: width * .07, vertical: height * .01),
                child: CustomTextField(
                  OnClicked: (value) {
                    _imageLocation = value;
                  },
                  hintText: ' Product Location',
                ),
              ),
              ElevatedButton(
                style: ButtonStyle(
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20))),
                    backgroundColor: MaterialStateProperty.all(Colors.purple)),
                onPressed: () {
                  if (formAdminKey.currentState.validate()) {
                  formAdminKey.currentState.save();
                    _store.EditProduct({
                      KProductName: _name,
                      KProductPrice: _price_,
                      KProductDescription: _description,
                      KProductCategory: _category,
                      KProductImage: _imageLocation
                    }, productEdits.pProductId);


                  }



                },
                child: Text(
                  'Update Product',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );

  }
}

/*
StreamBuilder<QuerySnapshot<Map>>(
                  stream: _store.LoadProductsStream(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<Product> listOne= [];
                      for (var item in snapshot.data.docs){
                        var data= item.data();

                        // print(item.id); // this is the item document id.
                        listOne.add(Product(
                            pProductId: item.id,
                            pImageLocation: data[KProductImage],
                            pCateg: data[KProductCategory],
                            pDescrip: data[KProductDescription],
                            pPrice: data[KProductPrice],
                            pName: data[KProductName]


                        ));



                      }


                      return Container(
                        width: width * .6,
                        height: height * .35,
                        child: GridView.builder(
                          //shrinkWrap: true,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 1),
                          itemCount: 1,
                          itemBuilder: (context, index) => Padding(

                            padding: EdgeInsets.symmetric(
                                horizontal: width * .02,
                                vertical: height * .02),
                            child: Stack(
                              children: [
                                Positioned.fill(
                                    child: Image(
                                  image:
                            AssetImage(listOne[index].pImageLocation),
                                  fit: BoxFit.fill,
                                )),
                                Positioned(
                                  bottom: 0,
                                  child: Opacity(
                                    opacity: .9,
                                    child: Container(
                                      height: height * .08,
                                      color: Colors.transparent,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            listOne[index].pName,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            productEdits.pCateg,
                                            textAlign: TextAlign.start,
                                            style: TextStyle(fontSize: 12),
                                          ),
                                          Text(
                                            'Price:${productEdits.pPrice} LE',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black),
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
                    }else{return Text('Loading.....');}
                  }),
 */
/*
Container(
        width: width * .6,
        height: height * .35,
        child: GridView.builder(
            //shrinkWrap: true,
            gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1),
        itemCount: 1,
        itemBuilder: (context, index) => Padding(

          padding: EdgeInsets.symmetric(
              horizontal: width * .02,
              vertical: height * .02),
          child: Stack(
            children: [
              Positioned.fill(
                  child: Image(
                    image:
                    AssetImage(productEdits.pImageLocation),
                    fit: BoxFit.fill,
                  )),
              Positioned(
                bottom: 0,
                child: Opacity(
                  opacity: .9,
                  child: Container(
                    height: height * .08,
                    color: Colors.transparent,
                    child: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.center,
                      children: [
                        Text(
                          productEdits.pName,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          productEdits.pCateg,
                          textAlign: TextAlign.start,
                          style: TextStyle(fontSize: 12),
                        ),
                        Text(
                          'Price:${productEdits.pPrice} LE',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
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
    ),
 */