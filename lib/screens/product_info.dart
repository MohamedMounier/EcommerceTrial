import 'package:accessories_utube/constants.dart';
import 'package:accessories_utube/models/product.dart';
import 'package:accessories_utube/provider/CartItem.dart';
import 'package:accessories_utube/screens/CartScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:accessories_utube/constants.dart';
class ProductInfo extends StatefulWidget {
  static String id = 'ProductInfo';

  @override
  _ProductInfoState createState() => _ProductInfoState();
}

class _ProductInfoState extends State<ProductInfo> {
  int _countingItems=1;
  @override
  Widget build(BuildContext context) {
    double heightMedia= MediaQuery.of(context).size.height;
    double widthMedia= MediaQuery.of(context).size.width;
    Product product=ModalRoute.of(context).settings.arguments;
    return Scaffold(
      backgroundColor: KMainColor,
      appBar: (AppBar(title: Text(product.pName,
        style: TextStyle(fontFamily: 'Pacifico',color: Colors.black),),
        centerTitle: true,backgroundColor: KMainColor,
      elevation: 0,
      leading: IconButton(icon: Icon(Icons.arrow_back),
        color: Colors.black
        ,onPressed: (){
        Navigator.pop(context);
      }
      ,),
        actions: [
          IconButton(
            onPressed: (){
              Navigator.pushNamed(context, CartScreen.id,arguments: product);
            },
            icon: Icon(Icons.shopping_cart,color: Colors.black,),
          )
        ],
      )),
      body: ListView(
        children: [
          Container(
            child: Image(image: AssetImage(product.pImageLocation),),
          ),
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: widthMedia*.02,vertical: heightMedia*.02),
            child: Container(
              color: Colors.transparent,
              width: widthMedia*.8,
              height: heightMedia*.2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.pName,style: TextStyle(
                        fontSize: 23,
                        color: Colors.purple,
                        fontWeight: FontWeight.bold,
                      ),

                      ),
                      Row(
                        children: [

                          Text(
                            'Price : ',style: TextStyle(
                            fontSize: 23,
                            color: Colors.purple,
                            fontWeight: FontWeight.bold,
                          ),

                          ),
                          Text(
                            '  ${product.pPrice} LE',style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.normal
                          ),),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            'Available : ',style: TextStyle(
                            fontSize: 23,
                            color: Colors.purple,
                            fontWeight: FontWeight.bold,
                          ),

                          ),
                          Text(
                            ' YES',style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.normal
                          ),),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        'Reviews',style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                      ),
                      Icon(Icons.star_border,color: Colors.white,),
                      Icon(Icons.star_border,color: Colors.white,),
                      Icon(Icons.star_border,color: Colors.white,),
                      Icon(Icons.star_border,color: Colors.white,),
                      Icon(Icons.star_border,color: Colors.white,),
                    ],
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: widthMedia*.02,vertical: heightMedia*.02),
            child: Container(

              color: Colors.transparent,
              width: widthMedia*.8,
              height: heightMedia*.14,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        ' Description:-',style: TextStyle(
                          fontSize: 20,
                          color: Colors.purple,
                          fontWeight: FontWeight.bold
                      ),),

                      Text(
                        ' ${product.pDescrip}',style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.bold
                      ),),
                      TextButton(
                        onPressed: (){},
                      child:Text(
                        ' Readmore',style: TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                      ),
                      ),
                      ),
                    ],
                  ),
                  Icon(Icons.favorite_border,color: Colors.white,)
                ],
              ),
            ),
          ),
          Padding(
            padding:  EdgeInsets.symmetric(vertical: heightMedia*.02),
            child: Container(

              color: Colors.transparent,
              width: widthMedia*.8,
              height: heightMedia*.14,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: widthMedia*.1,
                        height: heightMedia*.06,
                        decoration: BoxDecoration(
                            color: Colors.black45,
                          shape: BoxShape.circle
                        ),
                          child:IconButton(icon:Icon(Icons.add),color: Colors.yellow,
                            onPressed: (){
                              addPieces();
                            },
                          )
                      ),
                      Padding(
                        padding:  EdgeInsets.symmetric(horizontal: widthMedia*.06),
                        child: Text('$_countingItems',style: TextStyle(
                          fontSize: 35
                        ),),
                      ),
                      Container(
                          width: widthMedia*.1,
                          height: heightMedia*.06,
                          decoration: BoxDecoration(
                              color: Colors.black45,
                              shape: BoxShape.circle
                          ),
                          child:IconButton(icon:Icon(Icons.remove),color: Colors.yellow,
                          onPressed: (){
                            minusPieces();
                          },
                          )
                      ),
                    ],
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.black45)
                    ),
                      onPressed: (){
                        addToCartfinal(product);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.add_shopping_cart,color: Colors.yellow,),
                          Text('ADD TO CART',style: TextStyle(
                            color: Colors.yellow
                          ),)
                        ],
                      ))
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
  minusPieces(){
   if(_countingItems>1){
     setState(() {
       _countingItems--;
     });
   }
  }
  addPieces(){

      setState(() {
        _countingItems++;
      });

  }

  addToCartfinal(Product product){
    CartItem cartItem=Provider.of<CartItem>(context,listen: false);
    product.pQuantity=_countingItems;
    bool exist=false;

    var productsinCart=cartItem.product;
    for(var productItem in productsinCart) {
      if (productItem.pName == product.pName) {
        exist = true;
      }}
      if (exist==true) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
                'You have added this item before,kindly check your cart'
            )));
      } else {
        cartItem.addToCart(product);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Items are added to cart')));
        print(
            ' the product added to cart is$product, and quantity is ${product
                .pQuantity}');

    }
  }
}
