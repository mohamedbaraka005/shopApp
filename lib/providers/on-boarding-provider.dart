
import 'package:flutter/cupertino.dart';
import 'package:shop_app2/shared/helper.dart';
import 'package:shop_app2/the_data_layer/models/on-boarding-model.dart';

class OnBoardingProvider extends ChangeNotifier{
  var boardingController = PageController();
  bool isLast = false;
  bool FirstTime = Helper.getBoolean("FirstTime")??true;
  List<OnBoarding> boarding = [
    OnBoarding(
        image: "assets/images/onBoarding1.jpg",
        title: "EXPLORE MANY PRODUCTS",
        description: "There are more than 1.000 brands for the men and women in the catalog."),
    OnBoarding(
        image: "assets/images/onBoarding2.jpg",
        title: "ORDER ONLINE",
        description:
        "Make an order sitting on a sofa. Pay and choose online."),
    OnBoarding(
        image: "assets/images/onBoarding3.jpg",
        title: "DELIVERY SERVICE",
        description: "Modern delivery technologies. Shipping to the porch of your apartments."),
  ];

  void IsLastValue(bool value){
    isLast = value;
    notifyListeners();
  }

  void FirstTimeValue(bool value){
    FirstTime = value ;
    notifyListeners();
  }
}