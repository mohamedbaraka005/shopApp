import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:shop_app2/presentation_layer/widgets/divider.dart';
import 'package:shop_app2/providers/my-provider.dart';
import 'image-viewer-screen.dart';

class ItemDetailsScreen extends StatelessWidget {
  final int id;
  const ItemDetailsScreen({Key key ,  this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        toolbarHeight: 50,
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xffeaf1f8),
        title:Text("Details" , style: TextStyle(color: Colors.black),),
        leading:IconButton(
            onPressed: (){Navigator.pop(context);},
            icon: Icon(Icons.arrow_back_ios_rounded),
            color: Colors.black54,
          ),
        actions:[ Padding(
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
        ),]
      ),
      body: Builder(
        builder: (context)
        {
          var item = Provider.of<AppProvider>(context,listen:true).products.firstWhere((element) => element.id==id);
          return Column(
            children: [
              Expanded(
                child: ListView(
                  children: [
                    ///image of the product
                    InkWell(
                      onTap: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ImageViewerScreen(image: item.image, id: item.id,)));
                      },
                      child: Container(
                        color: Colors.white,
                        width: 150,
                        height: 300,
                        child: Hero (
                            tag: "${item.id}",
                            child: Image.network(item.image)
                        ),
                      ),
                    ),
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.all(10),
                            color: Colors.white,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ///works as a divider
                                AppDivider(color: Colors.grey[300],),
                                SizedBox(height: 5,),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                                  color: Colors.red,
                                  child: Text(item.category ,style: TextStyle(color: Colors.white ,fontSize: 10), ),
                                ),
                                SizedBox(height: 6,),
                                Text(item.name ,style: TextStyle(color: Colors.black ,fontSize: 20),),
                                SizedBox(height: 13,),
                                Text("EGP ${item.price}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15 , color: Colors.black),),
                                SizedBox(height: 5,),
                                Row(
                                  children: [
                                    Text("EGP ${item.price+45}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 13 , color: Colors.grey ,decoration: TextDecoration.lineThrough ),),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                      color: Color(0xffeaf1f8),
                                      child: Text("-65%" , style: TextStyle(color:Colors.blue[800] , fontSize: 13),),
                                    )
                                  ],
                                ),
                                SizedBox(height: 5,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Expanded(
                                      flex:5,
                                      child: SizedBox(
                                        width: 5,
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: InkWell(
                                          onTap: (){
                                            ///Share ...
                                            print("share still under programming");
                                          },
                                          child:Icon(Icons.share , color: Colors.blue,)),
                                    ),
                                    Expanded(
                                      flex:1,
                                      child: InkWell(
                                          onTap: (){
                                            Provider.of<AppProvider>(context,listen: false).like(item.id);
                                          },
                                          child:Provider.of<AppProvider>(context,listen:true).favourites_Items.contains(item.id)?Icon(Icons.favorite , color: Colors.red,):Icon(Icons.favorite_outline,color: Colors.red,)),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 5,),
                              ],
                            ),
                          ),
                          SizedBox(height: 10,),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 5 ,horizontal: 10),
                              child: Text("DESCRIPTION" ,style: TextStyle(color: Colors.black45 ,fontSize: 13 , fontWeight: FontWeight.bold), )),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 5),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color:Colors.white,
                              ),
                              padding: EdgeInsets.all(3),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                      padding: EdgeInsets.all(3),
                                      child: Text(item.description ,style: Theme.of(context).textTheme.caption, )),
                                  SizedBox(
                                    height: 15,
                                  )
                                ],
                              ),
                            ),
                          ),

                          ///Related items still under programming:
                          // SizedBox(height: 10,),
                          // Padding(
                          //     padding: EdgeInsets.symmetric(vertical: 5 ,horizontal: 10),
                          //     child: Text("RELATED ITEMS" ,style: TextStyle(color: Colors.black45 ,fontSize: 13 , fontWeight: FontWeight.bold), )),

                        ],
                      ),
                    )
                  ],
                ),
              ),

              AppDivider(color: Colors.grey[500],),
              ///Add To Cart & Call
              Container(
                color: Colors.white,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(10,5,5,5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Container(
                            height: 39,
                            child: MaterialButton(
                              color: Color(0xffeaf9f9),
                              onPressed: (){
                                ///call ...
                                print("Call still under programming");
                              },
                              child:Container(
                                child: Align(
                                  alignment: Alignment.center,
                                    child: Icon(Icons.call  ,color: Colors.blue[800],)),
                              )
                            ),
                          ),
                        ),
                        Provider.of<AppProvider>(context,listen:true).cart.keys.contains(item.id.toString())?
                        Expanded(
                          flex: 5,
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(10,0,0,0),
                            child: Row(
                              children: [
                                Expanded(
                                  flex:1,
                                  child: Container(
                                    width: 40,
                                    height: 39,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),

                                    ),
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    child: RaisedButton(
                                      color: Colors.blue[800],
                                      child:Text("-", style: TextStyle(color: Colors.white),),
                                      onPressed: (){
                                        ///delete one item from cart:
                                        Provider.of<AppProvider>(context,listen:false).minceOneItem(item.id , item.price);
                                      },
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 10),
                                      child: Center(child: Text("${Provider.of<AppProvider>(context,listen:true).cart[item.id.toString()].quantity} ",style: TextStyle(fontSize:Provider.of<AppProvider>(context,listen:true).cart[item.id.toString()].quantity>=10?8:13 ),))
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    width: 40,
                                    height: 39,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    child: RaisedButton(
                                      color: Colors.blue[800],
                                      child:Text("+" , style: TextStyle(color: Colors.white),),
                                      onPressed: (){
                                        ///add one more item
                                        Provider.of<AppProvider>(context,listen:false).plusOneMoreItem(item.id , item.price);
                                      },
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: (){
                                    ///delete the item form the cart
                                    Provider.of<AppProvider>(context,listen:false).deleteItem(item.id , item.price , Provider.of<AppProvider>(context,listen:false).cart[item.id.toString()].quantity);
                                  },
                                  child: Container(
                                      width: 50,
                                      height: 39,
                                      child: Icon(Icons.delete , color: Colors.red[900],)),
                                ),
                              ],
                            ),
                          ),
                        )
                            :
                        Expanded(
                          flex: 5,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 9),
                            child: Container(
                              height: 39,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(3)
                              ),
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              child: FlatButton(
                                color: Colors.blue[800],
                                onPressed: (){
                                  ///add item to the cart.
                                  Provider.of<AppProvider>(context, listen:false).addToCart(item.id , item.price);
                                  print("add to cart");
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                        flex:1,
                                        child: Icon(Icons.shopping_cart,color: Colors.white,)),
                                    Expanded(
                                        flex: 1,
                                        child: SizedBox(width: 5,)),
                                    Expanded(
                                         flex: 3,
                                        child: Text("ADD TO CART" , style: TextStyle(color: Colors.white, fontSize: 12),)),
                                    Expanded(
                                        flex: 1,
                                        child: SizedBox(width: 5,)),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
              ),
            ],
          );
        }
      ),
    );
  }
}
