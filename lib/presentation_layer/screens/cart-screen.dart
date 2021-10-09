import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app2/providers/my-provider.dart';
import 'item-details-screen.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:Colors.white,
        automaticallyImplyLeading: false,
        centerTitle: true,
        leading:InkWell(
             onTap: (){
               Navigator.pop(context);
             },
            child: Icon(Icons.arrow_back_ios_outlined, color: Colors.black54,)),
        title: Text("Cart", style: TextStyle(color: Colors.black),),
        actions: [
          InkWell(
            onTap: (){
              ///clear cart
              showDialog(context: context, child: AlertDialog(
                title: Text("Delete"),
                // titlePadding: EdgeInsets.fromLTRB(10,10,0,0),
                contentPadding:EdgeInsets.fromLTRB(25, 10, 5, 5),
                content:Container(
                  child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("you will delete all items on the cart " , style: Theme.of(context).textTheme.caption,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: (){
                              Navigator.pop(context);
                            },
                                child: Text("Cancel" , style: TextStyle(fontSize:13,color:Colors.blue[800]),)),
                            TextButton(
                              onPressed: (){
                              Provider.of<AppProvider>(context, listen: false).clearCart();
                              Navigator.pop(context);
                              },
                                child: Text("OK" , style: TextStyle(fontSize:13,color:Colors.blue[800]),)),
                          ],)
                      ]
                  ),
                ),
              ));

            },
            child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Icon(Icons.delete ,color: Colors.black,)
            ),
          ),
        ],
      ),
      body:
      Column(
        children:
       [
        Expanded(
          child: ListView(
            ///you must delete the [] for the children:
            children:
            Provider.of<AppProvider>(context, listen: true).cart.length==0?
            [
              Container(
               height:400,
               width: 100,
               child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      //width:250,
                      height:250,
                        child: Image.asset("assets/images/EmptyCart.png")),
                    Text("there are no Items in the cart..." , style: TextStyle(color: Colors.grey[500]),),
                  ],
                ),
                ),
              )
            ]
            :
            Provider.of<AppProvider>(context, listen: true).cart.values.map((product) {
              var item = Provider.of<AppProvider>(context, listen: true).products.firstWhere((element) => element.id == product.id);
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
                          Container(
                            width: 100,
                            height: 100,
                            // decoration: BoxDecoration(
                            //     borderRadius: BorderRadius.circular(10),
                            //     image:DecorationImage(
                            //       image:  NetworkImage(item.image),
                            //       fit:BoxFit.cover,
                            //     )
                            // ),
                            child:Hero(
                               tag:"${item.id}",
                                child: Image.network(item.image)),
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
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          child: Align(
                                              alignment: Alignment.bottomLeft,
                                              child: Text("${item.price} \$" , style: TextStyle(fontSize:item.price>100.01?13:15,fontWeight: FontWeight.bold),)),
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
                                              Provider.of<AppProvider>(context,listen:false).minceOneItem(product.id , item.price);
                                            },
                                          ),
                                        ),
                                        Padding(
                                            padding: EdgeInsets.symmetric(horizontal: 10),
                                            child: Text("${product.quantity}")
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
                                              Provider.of<AppProvider>(context,listen:false).plusOneMoreItem(product.id , item.price) ;
                                            },
                                          ),
                                        ),
                                        InkWell(
                                          onTap: (){
                                            ///delete the item form the cart
                                            Provider.of<AppProvider>(context,listen:false).deleteItem(product.id , item.price , product.quantity);
                                          },
                                          child: Padding(
                                            padding: EdgeInsets.only(left: 5),
                                            child: Center(
                                                child: Icon(Icons.delete , color: Colors.red,)),
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
          ),
        ),
       //Spacer(),
      Align(
          alignment:Alignment.bottomCenter,
        child: Column(
          children: [
            Container(
                color:Colors.grey[200],
                padding:EdgeInsets.fromLTRB(10,5,10,10),
                width:double.infinity,
                height:160,
               // color:Colors.white,
                child: Column(
                  children: [

                    Expanded(
                      child: Row(
                        children:[
                          Text("Total" , style: TextStyle(fontWeight: FontWeight.bold),),
                          Spacer(),
                          Text(Provider.of<AppProvider>(context,listen:true).total==0.0?"EGP 0":"EGP ${Provider.of<AppProvider>(context,listen:true).total.toStringAsFixed(2)} " , style: TextStyle(color: Colors.blue[800] , fontWeight:FontWeight.bold),),
                          //Text("EGP 182" , style: TextStyle(color:Colors.blue[800] , fontWeight:FontWeight.bold ),),
                        ],),
                    ),
                    Expanded(
                      child: Align(
                          alignment:Alignment.centerRight,
                          child: Text("delivery fee not included yet." , style: Theme.of(context).textTheme.caption,)),
                    ),
                    Expanded(
                      child: Center(
                          child: Container(
                          decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          ),
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                            child: MaterialButton(
                              minWidth:double.infinity,
                              color:Provider.of<AppProvider>(context,listen:true).ItemsCount>0?Colors.blue[800]:Colors.grey,
                              onPressed:(){},
                              child:Text("CHECKOUT (${Provider.of<AppProvider>(context,listen:true).ItemsCount})",style: TextStyle(color: Colors.white)),
                            ),
                          )),
                    ),
                    SizedBox(height:5),
                    Expanded(
                      child: Container(
                       decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        ),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: MaterialButton(
                            minWidth:double.infinity,
                            color:Color(0xffeaf1f8),
                            onPressed:(){
                              Navigator.pop(context);
                            },
                            child:Text("CONTINUE SHOPPING" , style: TextStyle(color: Colors.blue[800]),)
                        ),
                      ),
                    )
                  ],
                )
            ),
          ],
        ),
      ),
     ]
      )
    );
  }
}
