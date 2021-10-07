import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:shop_app2/presentation_layer/widgets/drawer.dart';
import 'package:shop_app2/providers/my-provider.dart';

import 'Item-list-screen.dart';
import 'items-screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Builder(
      builder:(context){
        return DefaultTabController(
          length: 2,
          child: Scaffold(
            drawer:MyDrawer(),
            appBar: AppBar(
              ///to change the color of the drawer icon
              iconTheme: IconThemeData(color: Colors.black),
              backgroundColor:Color(0xffeaf1f8),
              ///to remove automatic leading:
              //automaticallyImplyLeading: false,
              centerTitle: true,
              title: Text("Shop App", style: TextStyle(color: Colors.black),),
              //leading:Icon(Icons.menu , color:Colors.black),
              actions: [
                InkWell(
                    onTap: (){
                      Navigator.of(context).pushNamed('/fs');
                    },
                    child: Icon(Icons.favorite ,color: Colors.red[300], )),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: IconButton(
                    onPressed: (){
                      Navigator.of(context).pushNamed('/cs');
                    },
                    icon: Stack(
                      alignment: Alignment.center,
                      children: [
                        Icon(Icons.shopping_cart , color: Colors.black, ),
                        Align(
                          alignment: Alignment.topRight,
                          child: Container(
                            width: 15,
                            height: 15,
                            decoration: BoxDecoration(
                              color: Colors.blue[700],
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(child: Text('${Provider.of<AppProvider>(context,listen:true).ItemsCount}' , style: TextStyle(fontSize: 10),)),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
              bottom: TabBar(
                ///the color of the under line tabs
                indicatorColor: Colors.blue,
                tabs: [
                  Container(
                    height: 40,
                    child: Center(child: const Text("GridView" , style: TextStyle(color: Colors.blue),)),
                  ),
                  Container(
                    height: 40,
                    child: Center(child: const Text("List" , style: TextStyle(color: Colors.blue))),
                  ),
                ],
              ),
            ),
            body:
            TabBarView(
              ///some notes so as to the sliver works.
              /// do not use a controller in listView.builder.
              /// do not put scaffold before the pages in tabBarView.
              children: [
                ItemsScreen(),
                ItemsListScreen(),
                //FavouritesScreen(),
              ],
            ),
          ),
        );
      }

    );
  }
}
