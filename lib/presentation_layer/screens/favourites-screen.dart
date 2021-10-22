import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app2/providers/my-provider.dart';
import 'item-details-screen.dart';
import 'package:shop_app2/providers/animated-container-provider.dart';
class FavouritesScreen extends StatelessWidget {
  const FavouritesScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xffeaf1f8),
        centerTitle: true,
        title:Text(
          "WishList",
          style: TextStyle(color: Colors.black , fontSize: 18),
        ),
        leading:IconButton(
          onPressed: (){Navigator.pop(context);},
          icon: Icon(Icons.arrow_back_ios_rounded),
          color: Colors.black54,
        ),
      ),
      body:
      Provider.of<AppProvider>(context, listen: true).favourites_Items.length==0?
      Stack(
        children:[
          Container(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding:EdgeInsets.only(bottom: 80),
                  child: SizedBox(
                      height:200,
                      child: Image.asset("assets/images/sad (1).png")),
                ),
                Text("there are no Items in the favourites..." , style: TextStyle(color: Colors.grey[500]),),
              ],
            ),
          ),
        ),
          Provider.of<AnimatedContainerProvider>(context,listen: true).AddToCart ?
          AnimatedPositioned(
               duration: Duration(milliseconds: 400),
               top:Provider.of<AnimatedContainerProvider>(context,listen: true).top,
               left: Provider.of<AnimatedContainerProvider>(context,listen: true).left,
               child: AnimatedContainer(
                duration: Duration(milliseconds:400),
                color: Colors.blue,
                width: Provider.of<AnimatedContainerProvider>(context,listen: true).containerWidth,
                height: Provider.of<AnimatedContainerProvider>(context,listen: true).containerHeight,
                 child:Image.asset("assets/images/trolley.png"),
            ),
             )
              :
          Container(),
          Align(
            alignment: Alignment.bottomCenter,
            child:TextButton(
              child: Text("Click to animate"),
              onPressed:()async{
                Provider.of<AnimatedContainerProvider>(context,listen: false).AddToCartAnimation();
                },
            )
          )

        ]
      )
          :
      ListView(
        ///you must delete the [] for the children:
        children:
        Provider.of<AppProvider>(context, listen: true).favourites_Items.map((id) {

          var item = Provider.of<AppProvider>(context,listen:true).products.firstWhere((element) => element.id == id);
          ///to make the code more readable:
          var providerListenFalse = Provider.of<AppProvider>(context,listen:false);
          var providerListenTrue = Provider.of<AppProvider>(context,listen:true);

          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 3, vertical: 1),
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
                  padding: EdgeInsets.all(5),
                  child: Row(
                    children: [
                      Stack(
                        children:[
                          Container(
                          width: 100,
                          height: 100,
                            child: Hero(
                              tag: "${item.id}",
                                child: Image.network(item.image)),
                        ),
                          Align(
                              alignment: Alignment.topRight,
                              child: InkWell(
                                  onTap: (){
                                    providerListenFalse.like(item.id);
                                  },
                                  child: providerListenTrue.favourites_Items.contains(item.id)?Icon(Icons.favorite , color: Colors.red,):Icon(Icons.favorite_outline,color: Colors.red,))
                          )
                      ]
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Container(
                            height: 90,
                            child:Column(
                              children:[
                                Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text("${item.name}" , style: TextStyle(color: Colors.black, fontSize: 15),maxLines: 1,overflow: TextOverflow.ellipsis)
                                ),
                                Expanded(child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text("${item.description}" , style:Theme.of(context).textTheme.caption ,maxLines: 1,overflow: TextOverflow.ellipsis)
                                )),
                                providerListenTrue.cart.containsKey(item.id.toString())?
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: Align(
                                          alignment: Alignment.bottomLeft,
                                          child: Text("${item.price} \$" , style: TextStyle(fontSize:13,fontWeight: FontWeight.bold),)),
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
                                          providerListenFalse.minceOneItem(item.id, item.price);
                                        },
                                      ),
                                    ),
                                    Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 10),
                                        child: Text("${providerListenTrue.cart[item.id.toString()].quantity}")
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
                                          providerListenFalse.plusOneMoreItem(item.id,item.price);
                                        },
                                      ),
                                    ),
                                    InkWell(
                                      onTap: (){
                                        ///delete the item form the cart
                                        providerListenFalse.deleteItem(item.id,item.price,providerListenFalse.cart[item.id.toString()].quantity);
                                      },
                                      child: Padding(
                                        padding: EdgeInsets.only(left: 5),
                                        child: Center(
                                            child: Icon(Icons.delete , color: Colors.red,)),
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
                                          child: Text("${item.price} \$" , style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold),)),
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
                                          providerListenFalse.addToCart(item.id, item.price);
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
          );
        } ).toList(),
      )
    );
  }
}
