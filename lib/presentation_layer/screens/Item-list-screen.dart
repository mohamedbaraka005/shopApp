import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:shop_app2/providers/my-provider.dart';
import 'package:shop_app2/the_data_layer/models/product-model.dart';

import 'item-details-screen.dart';

class ItemsListScreen extends StatelessWidget {
  
  //const ItemsListScreen({Key key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
     // backgroundColor: Colors.grey[200],
      body: RefreshIndicator(
        onRefresh: Provider.of<AppProvider>(context,listen: true).Get_Products,
        child: Builder(
          builder:(context) {
            ///list of items which used in listView.builder
            List<Product> items = Provider.of<AppProvider>(context,listen:true).products.where((element){
              var category = Provider.of<AppProvider>(context,listen: true).category;
              return category=="All" ?
              true
                  :
              element.category == category ;
            })
            .map((item) => item).toList();

            ///listView.builder
            return ListView.builder(
                itemCount: items.length,
                itemBuilder:(context,index){
                  var item = items[index];
                  var provider = Provider.of<AppProvider>(context,listen:true);
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 3, vertical: 1),
                    child: InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(
                            builder: (NewContext)=>ItemDetailsScreen(id: item.id,)
                        ));
                        print("navigate to item details screen");
                      },
                      child: InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(
                              builder: (NewContext)=>ItemDetailsScreen(id: item.id,)
                          ));
                          print("navigate to item details screen");
                        },
                        child: Card(
                          color:Colors.white,
                          //color: Colors.blueGrey[100],
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(0,5,0,0),
                            child: Row(
                              children: [
                                Stack(
                                    children:[
                                      Container(
                                        width: 100 ,
                                        height: 100 ,
                                        child: Hero(
                                            tag: "${item.id}",
                                            child: Image.network(item.image)),
                                      ),
                                      /// [DEPRECATED]Love ....
                                      // Align(
                                      //     alignment: Alignment.topRight,
                                      //     child: InkWell(
                                      //         onTap: (){
                                      //           Provider.of<AppProvider>(context,listen: false).like(item.id);
                                      //         },
                                      //         child:provider.favourites_Items.contains(item.id)?Icon(Icons.favorite , color: Colors.red,):Icon(Icons.favorite_outline,color: Colors.red,))
                                      // )
                                    ]
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Container(
                                      height: 90,
                                      child:Column(
                                        children: [
                                          Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text("${item.name}" , style: TextStyle(color: Colors.black, fontSize: 15),maxLines: 1,overflow: TextOverflow.ellipsis)
                                          ),
                                          Expanded(child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text("${item.description}" , style:Theme.of(context).textTheme.caption ,maxLines: 1,overflow: TextOverflow.ellipsis)
                                          )),
                                          provider.cart.keys.contains(item.id.toString())?
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Expanded(
                                                child: Align(
                                                    alignment: Alignment.bottomLeft,
                                                    child: Row(
                                                      children: [
                                                        Text("EGP ${item.price} " , style: TextStyle(fontSize:item.price.toString().length>5?11:13,fontWeight: FontWeight.bold),),
                                                        //Text("EGP" , style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold),)
                                                      ],
                                                    )),
                                              ),
                                              Container(
                                                width: 40,
                                                height: 25,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(5),
                                                ),
                                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                                child: RaisedButton(
                                                  child:Text("-"),
                                                  onPressed: (){
                                                    ///delete one item from cart:
                                                    Provider.of<AppProvider>(context,listen:false).minceOneItem(item.id , item.price);
                                                  },
                                                ),
                                              ),
                                              Padding(
                                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                                  child: Text("${provider.cart[item.id.toString()].quantity}")
                                              ),
                                              Container(
                                                width: 40,
                                                height: 25,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(5),
                                                ),
                                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                                child: RaisedButton(
                                                  child:Text("+"),
                                                  onPressed: (){
                                                    ///add one more item
                                                    Provider.of<AppProvider>(context,listen:false).plusOneMoreItem(item.id ,item.price);
                                                  },
                                                ),
                                              ),
                                              InkWell(
                                                onTap: (){
                                                  ///delete the item form the cart
                                                  Provider.of<AppProvider>(context,listen:false).deleteItem(item.id , item.price , Provider.of<AppProvider>(context,listen:false).cart[ item.id.toString()].quantity );
                                                },
                                                child: Padding(
                                                  padding: EdgeInsets.only(left: 5),
                                                  child: Center(
                                                      child: Icon(Icons.delete , color: Colors.red[900],)),
                                                ),
                                              )
                                            ],
                                          ):
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Expanded(
                                                child: Align(
                                                    alignment: Alignment.bottomLeft,
                                                    child: Text("EGP ${item.price}" , style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold),)),
                                              ),
                                              Container(
                                                height: 33,
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(12)
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
                                                      Text("ADD TO CART" , style: TextStyle(color: Colors.white , fontSize: 10),),
                                                      SizedBox(width: 5,),
                                                      Icon(Icons.shopping_cart,color: Colors.black,)
                                                    ],
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ],
                                      )
                                  ),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                });
          }
        ),
      ),
    );
  }
}

