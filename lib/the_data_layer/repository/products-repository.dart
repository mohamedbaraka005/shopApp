import 'package:shop_app2/the_data_layer/data_providers/fakeStore-api.dart';
import 'package:shop_app2/the_data_layer/models/product-model.dart';

 class ProductsRepository{
   ///do not forget to initialize the object
   FakeStoreAPI _fakeStoreAPI = new FakeStoreAPI();

    Future< List<Product> > GetProducts() async{
     ///return json
     List<dynamic> _json = await _fakeStoreAPI.GetRawProducts();
     ///turn it from json to a list of products
    List<Product> _products = (_json as List<dynamic>)
     .map((item){
       return Product.fromJson(item);
     })
     .toList();
     return _products;
   }

    Future<List<dynamic>> LoadCart() async{
     //  var _json = await _fakeStoreAPI.LoadRawCart();
     //
     //  _json['products'].map((item) {
     //    /// Get the id and the quantity for each item in cart
     //    int ItemId = item['productId'];
     //    int ItemQuantity = item['quantity'];
     //    double ItemPrice = products.firstWhere((element) => element.id==ItemId).price;
     //    print(ItemId);
     //    print(ItemQuantity);
     //    /// make the item as a map of string and item Cart to fit in the cart list
     //    Map< String , CartItem > CartProduct = {ItemId.toString() : CartItem(id: ItemId, quantity: ItemQuantity) };
     //
     //    /// add it to the cart:
     //
     //    cart.addAll( CartProduct );
     //    /// add the total price of this item to the total price variable:
     //    //total+= ItemPrice * ItemQuantity ;
     //    /// add the quantity of this item to the count variable:
     //    //ItemsCount+=ItemQuantity;
     //  }).toList();
     // // return _json;
    }

}