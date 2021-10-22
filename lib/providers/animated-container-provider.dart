import 'package:flutter/cupertino.dart';
class AnimatedContainerProvider with ChangeNotifier{
  bool AddToCart=false;
  double containerWidth = 200;
  double containerHeight = 200;
  double top = 150;
  double left = 70;


  ///the type must be VoidCallBack
  VoidCallback  ShowContainer(){
    AddToCart = true ;
    containerWidth = 200;
    containerHeight = 200;
    top = 150;
    left = 70;
    notifyListeners();
  }

  Future AnimateContainer() async{
    await Future.delayed(Duration(milliseconds: 2));
    containerWidth = 0;
    containerHeight = 0;
    top = 50;
    left = 320;
    notifyListeners();
  }

  Future HideContainer () async{
    await Future.delayed(Duration(milliseconds: 401));
    AddToCart = false;
    notifyListeners();
  }

  Future AddToCartAnimation () async{
    ShowContainer();
    await AnimateContainer();
    await HideContainer();
    notifyListeners();
  }

}