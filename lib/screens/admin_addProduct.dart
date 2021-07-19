import 'package:accessories_utube/constants.dart';
import 'package:accessories_utube/customed_widgets/custom_textFields.dart';
import 'package:accessories_utube/models/product.dart';
import 'package:flutter/material.dart';
import 'package:accessories_utube/services/store.dart';
class AdminAddProduct extends StatelessWidget {
  @override
  static String id= 'AdminAddPoduct';
  String _name,_price_,_description,_category,_imageLocation;
 final GlobalKey<FormState> formAdminKey=GlobalKey<FormState>();
 final _store=Store();

  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: KMainColor,
      appBar: AppBar(
        leading: IconButton(icon:Icon(Icons.arrow_back),
          onPressed: (){Navigator.pop(context);},
          color: Colors.purple,),
        backgroundColor: KMainColor,
        title: Text('Start adding your product',
          style:TextStyle(fontFamily: 'Pacifico',
              color: Colors.purple
          ) ,
        ),),
      body: SingleChildScrollView(
        child: Form(
          key: formAdminKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(width: double.infinity,),
              Padding(
                padding:  EdgeInsets.symmetric(horizontal: width*.07,vertical: height*.01),
                child: CustomTextField(
                  OnClicked: (value) {
                    _name=value;
                  },
                  hintText: ' Product Name',
                ),
              ),
              Padding(
                padding:  EdgeInsets.symmetric(horizontal: width*.07,vertical: height*.01),
                child: CustomTextField(
                  OnClicked: (value) {
                    _price_=value;
                  },
                  hintText: ' Product Price',
                ),
              ),
              Padding(
                padding:  EdgeInsets.symmetric(horizontal: width*.07,vertical: height*.01),
                child: CustomTextField(
                  OnClicked: (value) {
                    _description=value;
                  },
                  hintText: ' Product Description',
                ),
              ),
              Padding(
                padding:  EdgeInsets.symmetric(horizontal: width*.07,vertical: height*.01),
                child: CustomTextField(
                  OnClicked: (value) {
                    _category=value;
                  },
                  hintText: ' Product Category',
                ),
              ),
              Padding(
                padding:  EdgeInsets.symmetric(horizontal: width*.07,vertical: height*.01),
                child: CustomTextField(
                  OnClicked: (value) {
                    _imageLocation=value;
                  },
                  hintText: ' Product Location',
                ),
              ),
              ElevatedButton(
                style: ButtonStyle(
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20))),
                    backgroundColor: MaterialStateProperty.all(Colors.purple)),
                onPressed: (){
                  if(formAdminKey.currentState.validate()){
                    formAdminKey.currentState.save();
                    _store.addProduct(Product(
                      pName: _name,
                      pPrice: _price_,
                      pDescrip: _description,
                      pCateg: _category,
                      pImageLocation: _imageLocation
                    ));
                  }
                },
                child: Text(
                  'Add Product',
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