import 'package:flutter/material.dart';

class MyPopUPItem<T> extends PopupMenuItem<T>{
  final Widget child;
  final Function onClickeD;
  MyPopUPItem({@required this.child,@required this.onClickeD});

  @override
  PopupMenuItemState<T, PopupMenuItem<T>> createState() {
    return MyPopupItemState();
  }
}
class MyPopupItemState<T,PopupMenuItem> extends PopupMenuItemState<T,MyPopUPItem<T>>{


  @override
  void handleTap() {
    widget.onClickeD();

  }
}

