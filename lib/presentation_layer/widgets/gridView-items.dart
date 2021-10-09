import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:shop_app2/presentation_layer/screens/item-details-screen.dart';
import 'package:shop_app2/providers/my-provider.dart';

class GridViewItems extends StatelessWidget {
  const GridViewItems({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child:
      Provider.of<AppProvider>(context,listen:true).products != null?
      RefreshIndicator(
        ///do not forget to delete the () from the function:
        onRefresh: Provider.of<AppProvider>(context,listen: true).Get_Products,
        child: Container(
          child: GridView.count(
            childAspectRatio: (1 / 1.5),
            crossAxisCount: 2,
            mainAxisSpacing: 1.0,
            crossAxisSpacing: 1.0,

            ///myList.asMap().entries.map((entry).
            children: Provider.of<AppProvider>(context, listen: true).products.where((element){
              var category = Provider.of<AppProvider>(context,listen: true).category;
              return category=="All" ?
              true
                  :
              element.category == category ;
            }).map((entry){///.where((element) => element['inCart'])
              return Container(
                child: InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(
                        builder: (NewContext)=>ItemDetailsScreen(id: entry.id,)
                    ));
                    print("navigate to item details screen");
                  },
                  child: Card(
                    color:Colors.white,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 5),
                      child: Column(
                        children: [
                          Container(
                            width: 190,
                            height: 110,
                            child: Stack(
                                children:[
                                  Center(
                                    child: Hero(
                                      tag:"${entry.id}",
                                      child: Image.network(entry.image,),
                                    ),
                                  ),
                                  /// [DEPRECATED] love
                                  // Align(
                                  //   alignment: Alignment.topRight,
                                  //     child: InkWell(
                                  //         //padding: EdgeInsets.all(0),
                                  //         onTap: (){
                                  //           Provider.of<AppProvider>(context,listen: false).like(entry.id);
                                  //         },
                                  //         child:Provider.of<AppProvider>(context,listen:true).favourites_Items.contains(entry.id)?Icon(Icons.favorite , color: Colors.red,):Icon(Icons.favorite_outline,color: Colors.red,))),
                                ]
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(5,0,0,5),
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text("${entry.name}" , style: TextStyle(color: Colors.black, fontSize: 12 ,fontWeight: FontWeight.bold),maxLines: 1,overflow: TextOverflow.ellipsis)
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text("${entry.description}" , style: Theme.of(context).textTheme.caption.copyWith(fontSize: 10),maxLines: 2,overflow: TextOverflow.ellipsis)
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Expanded(
                                    child: Align(
                                        alignment: Alignment.center,
                                        child: Text("EGP ${entry.price}" , style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold),)),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                ],
                              ),
                            ),
                          ),

                          Provider.of<AppProvider>(context,listen:true).cart.keys.contains(entry.id.toString())?
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
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
                                    Provider.of<AppProvider>(context,listen:false).minceOneItem(entry.id , entry.price);
                                  },
                                ),
                              ),
                              Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  child: Text("${Provider.of<AppProvider>(context,listen:true).cart[entry.id.toString()].quantity} ",style: TextStyle(fontSize:Provider.of<AppProvider>(context,listen:true).cart[entry.id.toString()].quantity>=10?8:13 ),)
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
                                    Provider.of<AppProvider>(context,listen:false).plusOneMoreItem(entry.id , entry.price);
                                  },
                                ),
                              ),
                              InkWell(
                                onTap: (){
                                  ///delete the item form the cart
                                  Provider.of<AppProvider>(context,listen:false).deleteItem(entry.id , entry.price , Provider.of<AppProvider>(context,listen:false).cart[entry.id.toString()].quantity);
                                },
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 5),
                                  child: Center(
                                      child: Icon(Icons.delete , color: Colors.red[900],)),
                                ),
                              )
                            ],
                          )
                              :
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 5),
                                  child: Container(
                                    height: 33,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12)
                                    ),
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    child: FlatButton(
                                      color: Colors.blue[800],
                                      onPressed: (){
                                        ///add item to the cart.
                                        Provider.of<AppProvider>(context, listen:false).addToCart(entry.id , entry.price);
                                        print("add to cart");
                                      },
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text("ADD TO CART" , style: TextStyle(color: Colors.white, fontSize: 12),),
                                          SizedBox(width: 5,),
                                          Icon(Icons.shopping_cart,color: Colors.black,)
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),

                        ],
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      )
          :
      Center(child: CircularProgressIndicator()),
    );
  }
}
