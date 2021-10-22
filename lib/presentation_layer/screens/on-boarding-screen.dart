import 'package:flutter/material.dart';
import 'package:shop_app2/providers/on-boarding-provider.dart';
import 'package:shop_app2/shared/helper.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:provider/provider.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<OnBoardingProvider>(context,listen:true);
    var ProviderListenFalse = Provider.of<OnBoardingProvider>(context,listen:false);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
            children: [
          Expanded(
            child: PageView.builder(
              controller:provider.boardingController,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(provider.boarding[index].image),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        provider.boarding[index].title,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        provider.boarding[index].description,
                        style: TextStyle(fontSize: 15, color: Colors.grey),
                      ),
                    ],
                  ),
                );
              },
              itemCount:provider.boarding.length,
              onPageChanged: (index) {
                if (index ==  ProviderListenFalse.boarding.length - 1) {
                  ProviderListenFalse.IsLastValue(true);
                } else {
                  ProviderListenFalse.IsLastValue(false);
                }
              },
              //nice animation rather than the shadow:
              physics: BouncingScrollPhysics(),
            ),
          ),
          SmoothPageIndicator(
            controller: provider.boardingController,
            count: provider.boarding.length,
            effect: ExpandingDotsEffect(
              dotColor: Colors.grey,
              activeDotColor: Colors.blue[800],
              dotHeight: 10,
              dotWidth: 10,
              expansionFactor: 4,
            ),
          )
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if(ProviderListenFalse.isLast==true)
          {
              Helper.putBoolean('FirstTime', false);
              ProviderListenFalse.FirstTimeValue(false);
          }
          else{
            context.read<OnBoardingProvider>().boardingController.nextPage(
                duration: Duration(milliseconds: 750),
                curve: Curves.fastLinearToSlowEaseIn);
          }
        },
        child: Icon(Icons.forward),
      ),
    );
  }


}


