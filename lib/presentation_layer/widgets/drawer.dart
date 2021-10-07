import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:shop_app2/providers/auth-provider.dart';
import 'package:shop_app2/providers/my-provider.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      // Add a ListView to the drawer. This ensures the user can scroll
      // through the options in the drawer if there isn't enough vertical
      // space to fit everything.
      child:
      ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
          Container(
              color:Colors.white,
              height:24
          ),
          Container(
              padding: EdgeInsets.only(top: 5 , left: 5 ,bottom: 5),
              color: Colors.blue[800],
              child: Row(
                children: [
                  Text("Filter Products" , style: Theme.of(context).textTheme.caption.copyWith(fontSize: 15 , fontWeight: FontWeight.bold ,color:Colors.white),),
                  Spacer(),
                  Icon(Icons.settings_input_composite,color: Colors.white,),
                  SizedBox(width: 20,)
                ],
              )
          ),
          Container(
            color:Provider.of<AppProvider>(context,listen: true).category=="All"? Colors.grey[200]:Colors.white,
            child: ListTile(
              title: Row(
                children: [
                  const Text('All Products',style: TextStyle(fontSize: 13),),
                  Spacer(),
                  Provider.of<AppProvider>(context,listen: true).category=="All"?Icon(Icons.done, color: Colors.blue,):Container(),
                ],
              ),
              onTap: () {
                Provider.of<AppProvider>(context,listen: false).Select_Category("All");
                Navigator.pop(context);
              },
            ),
          ),
          Container(
            color:Provider.of<AppProvider>(context,listen: true).category=="electronics"? Colors.grey[200]:Colors.white,
            child: ListTile(
              title: Row(
                children: [
                  const Text('Electronics',style: TextStyle(fontSize: 13),),
                  Spacer(),
                  Provider.of<AppProvider>(context,listen: true).category=="electronics"?Icon(Icons.done, color: Colors.blue,):Container(),
                ],
              ),
              onTap: () {
                Provider.of<AppProvider>(context,listen: false).Select_Category("electronics");
                Navigator.pop(context);
              },
            ),
          ),
          Container(
            color: Provider.of<AppProvider>(context,listen: true).category=="jewelery"? Colors.grey[200]:Colors.white,
            child: ListTile(
              title: Row(
                children: [
                  const Text('Jewelery',style: TextStyle(fontSize: 13),),
                  Spacer(),
                  Provider.of<AppProvider>(context,listen: true).category=="jewelery"?Icon(Icons.done  , color: Colors.blue,):Container(),
                ],
              ),
              onTap: () {
                Provider.of<AppProvider>(context,listen: false).Select_Category("jewelery");
                Navigator.pop(context);
              },

            ),
          ),
          Container(
            color:Provider.of<AppProvider>(context,listen: true).category=="men's clothing"? Colors.grey[200]:Colors.white,
            child: ListTile(
              title: Row(
                children: [
                  const Text('Men\'s clothing',style: TextStyle(fontSize: 13),),
                  Spacer(),
                  Provider.of<AppProvider>(context,listen: true).category=="men's clothing"?Icon(Icons.done  , color: Colors.blue,):Container(),
                ],
              ),
              onTap: () {
                Provider.of<AppProvider>(context,listen: false).Select_Category("men's clothing");
                Navigator.pop(context);
              },

            ),
          ),
          Container(
            color: Provider.of<AppProvider>(context,listen: true).category== "women's clothing"? Colors.grey[200]:Colors.white,
            child: ListTile(
              title: Row(
                children: [
                  const Text('Women\'s clothing',style: TextStyle(fontSize: 13),),
                  Spacer(),
                  Provider.of<AppProvider>(context,listen: true).category== "women's clothing"?Icon(Icons.done  , color: Colors.blue,):Container(),
                ],
              ),
              onTap: () {
                Provider.of<AppProvider>(context,listen: false).Select_Category( "women's clothing");
                Navigator.pop(context);
              },

            ),
          ),

          ///SETTINGS...
          Container(
              padding: EdgeInsets.only(top: 5 , left: 5 ,bottom: 5),
              color: Colors.blue[800],
              child: Row(
                children: [
                  Text("Settings" , style: Theme.of(context).textTheme.caption.copyWith(fontSize: 15 , fontWeight: FontWeight.bold ,color:Colors.white),),
                  Spacer(),
                  Icon(Icons.settings ,color: Colors.white,),
                  SizedBox(width: 20,)
                ],
              )
          ),
          Container(
            color:Colors.white,
            child: ListTile(
              title: Row(
                children: [
                  const Text('Sign Out',style: TextStyle(fontSize: 13),),
                  Spacer(),
                ],
              ),
              onTap: () {
                Navigator.pop(context);
                Provider.of<AuthProvider>(context,listen: false).signOut();
              },
            ),
          ),
        ],
      ),
    );
  }
}
