

import 'package:flutter/cupertino.dart';


import 'package:shop_app2/the_data_layer/data_providers/fakeStore-api.dart';
import 'package:shop_app2/the_data_layer/models/cart-model.dart';
import 'package:shop_app2/the_data_layer/models/product-model.dart';
import 'package:shop_app2/the_data_layer/repository/products-repository.dart';




class AppProvider with ChangeNotifier{

  double total = 0.0 ;
  int ItemsCount = 0;
  String category = "All";
  List<Product> products ;
  ///do not forget to initialize the object:
  ProductsRepository _pruductsRepository = new ProductsRepository();
  FakeStoreAPI _fakestoreapi = new FakeStoreAPI();
  




  Future<void> Get_Products() async{
    ///to show the loading again:
    //  products=[] ;
    //  notifyListeners();
    print("Get Products");
       try{
         products = await _pruductsRepository.GetProducts();
       }
       catch(error){
         print("++++++++++++++++++++++++++++++++++++${error.toString()}");
       }
    notifyListeners();
  }


  Future<void> Load_Cart() async{
    var json = await _fakestoreapi.LoadRawCart();
    json['products'].map((item) {
      /// Get the id and the quantity for each item in cart
      int ItemId = item['productId'];
      int ItemQuantity = item['quantity'];
      double ItemPrice = products.firstWhere((element) => element.id==ItemId).price;
      /// make the item as a map of string and item Cart to fit in the cart list
      Map<String,CartItem> CartProduct = {ItemId.toString() : CartItem(id: ItemId, quantity: ItemQuantity) };
      /// add it to the cart:
      cart.addAll( CartProduct ) ;
      /// add the total price of this item to the total price variable:
      total += ItemPrice * ItemQuantity ;
      /// add the quantity of this item to the count variable:
      ItemsCount += ItemQuantity;
    }).toList();
    notifyListeners();
  }

  Future<void> LoadProductsAndCart ()
  {
   /// Sequentially ,Get the products then Load the Cart .
    Get_Products()
        .then((value)=>Load_Cart())
        .catchError((onError){print(onError.toString());});

    /// you can not put [AppProvider()..Get_Products..Load_Cart] in main.dart
    /// because the loop [map function] which put the data on its list [products]
    /// after getting the products from the link ,  will make an [null error]
    /// because products list [products] still not have the products when calling [Load-Cart()].
  }

  void Select_Category(String cate)
  {
    category = cate;
    notifyListeners();
  }

  ///[DEPRECATED]data:
   // List<Map<String, dynamic>> items = [
   //   {
   //     'id':0,
   //     'name':"Head Phone 5J",
   //     'image':"https://www.compliancegate.com/wp-content/uploads/2020/07/electronic-products-regulations-singapore.jpg",
   //     'description':"Head Phone 5J Head Phone 5J Head Phone 5J Head Phone 5J Head Phone 5J",
   //     'price':44.5,
   //     'number':0,
   //     'inCart':false,
   //     'love':false,
   //   },
   //   {
   //     'id':1,
   //     'name':"Speaker non 312G",
   //     'image':"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTGHvZ1lp8NfUoHr3qo5u1HcZE2ssVgrkIsJev6SaPA2D2CnUb3eE75WCryS2n5NkqYLTI&usqp=CAU",
   //     'description':"Speaker non 312G Speaker non 312G Speaker non 312G Speaker non 312G Speaker non 312G",
   //     'price':31,
   //     'number':0,
   //     'inCart':false,
   //     'love':false,
   //   },
   //   {
   //     'id':2,
   //     'name':"Samsaung Phone GH2",
   //     'image':"https://thumbs.dreamstime.com/b/smart-phone-isolated-background-using-wallpaper-electronic-product-object-digital-communication-sand-message-call-to-131723050.jpg",
   //     'description':"Samsaung Phone GH2 Samsaung Phone GH2 Samsaung Phone GH2 Samsaung Phone GH2 Samsaung Phone GH2 Samsaung Phone GH2",
   //     'price':153.2,
   //     'number':0,
   //     'inCart':false,
   //     'love':false,
   //   },
   //   {
   //     'id':3,
   //     'name':"Play Station 5 hand",
   //     'image':"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRGrjTC69M008jEZFJC16rfnQLNWDJdUeU1lDyywZG9ZYqIiHbsNM8l1-Gujn624ROWTFU&usqp=CAU",
   //     'description':"Play Station 5 hand Play Station 5 hand Play Station 5 hand Play Station 5 hand Play Station 5 hand",
   //     'price':100.7,
   //     'number':0,
   //     'inCart':false,
   //     'love':false,
   //   },
   //   {
   //     'id':4,
   //     'name':"Head Phone for Kids",
   //     'image':"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRo-2wGKZukqUH5EHwKXzZCBh9UsWczMB2q2YUacPeajKFCschot7GU7FYAcip6nWrLs-M&usqp=CAU",
   //     'description':"Head Phone for Kids Head Phone for Kids Head Phone for Kids",
   //     'price':70.4,
   //     'number':0,
   //     'inCart':false,
   //     'love':false,
   //   },
   //   {
   //     'id':5,
   //     'name':"Flash Reader for phones",
   //     'image':"https://elements-cover-images-0.imgix.net/ea394706-1a38-4542-92ef-168932d879ff?auto=compress%2Cformat&fit=max&w=433&s=30ab730f24652ba0542134e257677425",
   //     'description':"Flash Reader for phones Flash Reader for phones Flash Reader for phones Flash Reader for phones",
   //     'price':22,
   //     'number':0,
   //      'inCart':false,
   //     'love':false,
   //   },
   //   {
   //     'id':6,
   //     'name':"Flash Reader for phones",
   //     'image':"https://elements-cover-images-0.imgix.net/ea394706-1a38-4542-92ef-168932d879ff?auto=compress%2Cformat&fit=max&w=433&s=30ab730f24652ba0542134e257677425" ,
   //     'description':"still under programming still under programming still under programming still under programming",
   //     'price':121,
   //     'number':0,
   //     'inCart':false,
   //     'love':false,
   //   },
   //   {
   //     'id':7,
   //     'name':"Head Phone for Kids",
   //     'image':"https://elements-cover-images-0.imgix.net/ea394706-1a38-4542-92ef-168932d879ff?auto=compress%2Cformat&fit=max&w=433&s=30ab730f24652ba0542134e257677425" ,
   //     'description':"still under programming still under programming still under programming still under programming",
   //     'price':30,
   //     'number':0,
   //     'inCart':false,
   //     'love':false,
   //   }
   // ];

  Map <String , CartItem> cart = {};
  List<int> favourites_Items = [];

   void addToCart(int id , double price){
     // items[index][ 'inCart' ] = true;
     // total+=items[index][ 'price' ];
     // items[index][ 'number' ] = 1 ;
     // notifyListeners();

     Map<String,CartItem> item = {id.toString(): CartItem(id: id, quantity: 1)};
     cart.addAll( item );
     total+= price;
     ItemsCount++;
     notifyListeners();
   }

  void deleteItem( int id , double price  , int quantity){
    // items[index][ 'inCart' ] = false;
    // ///to delete the price
    // total-=( items[index][ 'price' ] * items[index][ 'number' ] );
    // items[index][ 'number' ] = 0 ;
    // notifyListeners();

    cart.remove(id.toString());
    total-=(price * quantity);
    ItemsCount-=quantity;
    notifyListeners();
  }
  ///[DEPRECATED]love:
  // void addToCart_love(int id){
  //   items.firstWhere((element) => element['id']==id).update('inCart', (value) => true);
  //   notifyListeners();
  // }

  void like( int id ){
    // items[index][ 'love' ] = !items[index][ 'love' ];
    // notifyListeners();
   favourites_Items.contains(id)?
   favourites_Items.remove(id):
   favourites_Items.add(id);
    notifyListeners();
  }


   ///[DEPRECATED]love:
  // void love_love(int id){
  //   items.firstWhere((element) => element['id']==id).update('love', (value) => false);
  //   notifyListeners();
  // }

   void plusOneMoreItem(int id , double price ){
    /* items[index][ 'number' ] ++;
     total+=items[index][ 'price' ];
     notifyListeners();*/
     cart[id.toString()].quantity++;
     total+= price;
     ItemsCount++;
     notifyListeners();
   }

  ///[DEPRECATED]cart:
  // void plusOneMoreItem_cart(int id, dynamic price){
  //    items.firstWhere((element) => element['id']==id).update('number', (value) => ++value);
  //    total+=price;
  //   notifyListeners();
  // }

   void minceOneItem(int id , double price){
    // if(items[index][ 'number' ] > 0){
    //   if(items[index][ 'number' ] == 1 )
    //   {
    //     items[index][ 'inCart' ] = false;
    //   }
    //   items[index][ 'number' ] --;
    //   total-=items[index][ 'price' ];
    //   notifyListeners();
    // }
     if(cart[id.toString()].quantity == 1 )
       cart.remove(id.toString());
     else
       cart[id.toString()].quantity--;

     total-=price;
     ItemsCount--;
     notifyListeners();
   }

  ///[DEPRECATED]cart:
  // void minceOneItem_cart(int id, dynamic price , int number){
  //
  //    if(number == 1)
  //      {
  //
  //        items.firstWhere((element) => element['id'] == id ).update( 'number', (value) {
  //            total -= price ;
  //            return --value ;
  //        });
  //        ///to delete it from the cart:
  //        items.firstWhere((element) => element['id'] == id ).update( 'inCart', (value) {
  //          return false ;
  //        });
  //
  //      }
  //     else{
  //
  //      items.firstWhere((element) => element['id'] == id ).update( 'number', (value) {
  //        total -= price ;
  //        return --value ;
  //      });
  //
  //    }
  //
  //   notifyListeners();
  //
  // }


  ///[DEPRECATED]cart:
  // void deleteItem_cart(int id , dynamic price , int number){
  //   items.firstWhere((element) => element['id'] == id ).update( 'inCart', (value) {
  //     total -= (price * number);
  //     return false ;
  //   });
  //   notifyListeners();
  // }

  void clearCart(){
    cart.clear();
    total=0.0;
    ItemsCount=0;
    notifyListeners() ;
  }








}