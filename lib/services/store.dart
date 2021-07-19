import 'package:accessories_utube/models/product.dart';
import 'package:accessories_utube/screens/adming_EditProduct.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../constants.dart';
class Store {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;


  addProduct(Product product) async {
    await _firestore.collection(KProductCollection).add({
      KProductName: product.pName,
      KProductPrice: product.pPrice,
      KProductDescription: product.pDescrip,
      KProductCategory: product.pCateg,
      KProductImage: product.pImageLocation
    });
  }

  Future<List<Product>> LoadProducts() async {
    var response = await _firestore.collection(KProductCollection).get();
    List<Product> products = [];
    for (var item in response.docs) {
      var data = item.data();
      products.add(Product(
          pImageLocation: data[KProductImage],
          pCateg: data[KProductCategory],
          pDescrip: data[KProductDescription],
          pPrice: data[KProductPrice],
          pName: data[KProductName]


      ));
    }
    return products;
  }

  Stream<QuerySnapshot> LoadProductsStream() {
    return _firestore.collection(KProductCollection).snapshots();
  }

  DeleteProduct(documentId){
    _firestore.collection(KProductCollection).doc(documentId).delete();
  }

  EditProduct(data,documentIdEdit){
    _firestore.collection(KProductCollection).doc(documentIdEdit).update(data);
  }
  
  StoreData(data,List<Product> products){
   var documentRef= _firestore.collection(KOrders).doc();
   documentRef.set(data);
   for(var product in products){
     documentRef.collection(KOrdersDetails).doc().set(
       {
           KProductPrice: product.pPrice,
         KProductName:product.pName,
         KProductQuantity:product.pQuantity,
         KProductImage:product.pImageLocation,
         KProductCategory:product.pCateg
       }
     );
   }
  }

  Stream<QuerySnapshot> LoadOrders(){
   return _firestore.collection(KOrders).snapshots();
  }

  Stream<QuerySnapshot> LoadOrdersDetails(documentId){
    return _firestore.collection(KOrders).doc(documentId).collection(KOrdersDetails).snapshots();
  }



}
/*
for (var item in response.docs){
      var data= item.data();
      products.add(Product(
          pImageLocation: data[KProductImage],
          pCateg: data[KProductCategory],
          pDescrip: data[KProductDescription],
          pPrice: data[KProductPrice],
          pName: data[KProductName]


      ));
    }
 */