import 'package:flutter/material.dart';






import 'package:provider/provider.dart';
import 'package:shop_app2/presentation_layer/screens/Item-list-screen.dart';
import 'package:shop_app2/presentation_layer/screens/auth-screen.dart';
import 'package:shop_app2/presentation_layer/screens/cart-screen.dart';
import 'package:shop_app2/presentation_layer/screens/favourites-screen.dart';
import 'package:shop_app2/presentation_layer/screens/home-screen.dart';
import 'package:shop_app2/presentation_layer/screens/image-viewer-screen.dart';
import 'package:shop_app2/presentation_layer/screens/item-details-screen.dart';
import 'package:shop_app2/presentation_layer/screens/items-screen.dart';
import 'package:shop_app2/providers/auth-provider.dart';
import 'package:shop_app2/providers/my-provider.dart';
import 'package:shop_app2/shared/helper.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  await Helper.init();
  runApp(  MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context)=> AuthProvider(),
      child: ChangeNotifierProvider(
        create: (context)=> AppProvider()..LoadProductsAndCart(),
        child: Builder(
          builder:(context)=> MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: ThemeData(
              primarySwatch: Colors.blue,
              iconTheme: IconThemeData(
                color: Colors.white,
              ),
              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
            home:context.watch<AuthProvider>().loggedIn? HomeScreen() : AuthScreen(),
            routes: {
              //'/':(context)=>HomeScreen(),
              '/ils' :(context)=> ItemsListScreen(),
              '/is' :(context)=>  ItemsScreen(),
              '/cs':(context)=>   CartScreen(),
              '/fs':(context)=>   FavouritesScreen(),
              '/ids':(context)=>  ItemDetailsScreen(),
              '/ivs':(context)=>  ImageViewerScreen(),
              '/as':(context)=>   AuthScreen(),
            },

          ),
        ),
      ),
    );
  }
}


