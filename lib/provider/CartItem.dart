

import 'package:accessories_utube/models/product.dart';
import 'package:flutter/cupertino.dart';

class CartItem extends ChangeNotifier{

  List<Product> product=[];
  addToCart(productCart){
    product.add(productCart);
    notifyListeners();
  }

  deleteFromCart(ProductChoosen){
    product.remove(ProductChoosen);
    notifyListeners();
  }
}
