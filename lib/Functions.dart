import 'package:accessories_utube/constants.dart';
import 'package:flutter/material.dart';
import 'models/product.dart';

List<Product> getProductsByCateg(@required String KProductCateg,@required List<Product> allProducts) {
   List<Product> finalProducts=[];
 try{
   for(var product in allProducts){
     if(product.pCateg==KProductCateg){
       finalProducts.add(product);
       print('final products are ; $finalProducts');
       print('getProducts are: $allProducts');
     }
   }
 }on Error catch(ex){
   print(ex);
 }

  return finalProducts;
}

