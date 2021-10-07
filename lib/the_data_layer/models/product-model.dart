import 'package:flutter/cupertino.dart';

class Product {
  int id ;
  String name;
  String category;
  String image ;
  String description;
  double price;

  Product({
    @required this.id ,
    @required this.name ,
    @required this.category ,
    @required this.image ,
    @required this.description ,
    @required this.price ,
  });


   Product.fromJson( Map<String , dynamic> json )
  {
    //   return Product(
    //      id : (json['id'] as int )   ,
    //      name: json['title'] as String,
    //      category: json['category'] as String,
    //      image : json['image'] as String,
    //      description: json['description'] as String,
    //      price:(json['price']).toDouble(),
    // );
          id = (json['id'] as int )   ;
          name= json['title'] as String;
          category= json['category'] as String;
          image = json['image'] as String;
          description= json['description'] as String;
          price=(json['price']).toDouble();
  }

  Map<String , dynamic> toMap(){
    return {
    'id' : id,
    'name': name,
    'category':category,
    'image' :  image,
    'description': description ,
    'price': price,
    };
  }
}