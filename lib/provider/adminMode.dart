import 'package:flutter/cupertino.dart';

class AdminMode extends ChangeNotifier{
  bool isadmin=false;
  ChangeisAdmin(bool value){
    isadmin=value;
    notifyListeners();
  }
}