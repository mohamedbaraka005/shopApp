import 'dart:convert';

import 'package:http/http.dart' as http;

class FakeStoreAPI{

  Future<List<dynamic>> GetRawProducts () async{
    ///returns http.Response
    http.Response _response = await http.get(Uri.parse('https://fakestoreapi.com/products'));
    /// turn it into json(list<dynamic>)
    var _rawProducts = jsonDecode(_response.body);
    return _rawProducts;
  }

   LoadRawCart () async{
    http.Response _response = await http.get(Uri.parse('https://fakestoreapi.com/carts/5'));
    var _RawCart = jsonDecode(_response.body);
    return _RawCart ;
  }

  // Future<void> Load_Cart() async {
  //   // var response = await http.get(Uri.parse('https://fakestoreapi.com/carts/5'));
  //   // var json = jsonDecode(response.body);
  //   json['products'].map((item) {
  //     /// Get the id and the quantity for each item in cart
  //     int ItemId = item['productId'];
  //     int ItemQuantity = item['quantity'];
  //     double ItemPrice = products.firstWhere((element) => element.id==ItemId).price;
  //     print(ItemId);
  //     print(ItemQuantity);
  //     /// make the item as a map of string and item Cart to fit in the cart list
  //     Map<String,CartItem> CartProduct = {ItemId.toString() : CartItem(id: ItemId, quantity: ItemQuantity) };
  //
  //     /// add it to the cart:
  //     cart.addAll( CartProduct );
  //     /// add the total price of this item to the total price variable:
  //     total+= ItemPrice * ItemQuantity ;
  //     /// add the quantity of this item to the count variable:
  //     ItemsCount+=ItemQuantity;
  //   }).toList();
  //   print(json);
  //   notifyListeners();
  //
  // }




}