import 'package:flutter_shopping_app/models/Product.dart';

class CartItem {
  late String id;
  late String cusID;
  late String sellID;
  late String sellName;
  late ProductModel product;
  late String color;
  late String size;
  late double price;
  late int quantity;
  late String time;
  CartItem({
    required this.id,
    required this.cusID,
    required this.sellID,
    required this.sellName,
    required this.product,
    required this.color,
    required this.size,
    required this.price,
    required this.quantity,
    required this.time,
  });
  CartItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    cusID = json['cusID'];
    sellID = json['sellID'];
    sellName = json['sellName'];
    product = ProductModel.fromJson(json['product']);
    color = json['color'];
    size = json['size'];
    price = (json['price'] is int)
        ? (json['price'] as int).toDouble()
        : (json['price'] as double);
    quantity = json['quantity'];
    time = json['time'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> cartItem = new Map<String, dynamic>();
    cartItem['id'] = this.id;
    cartItem['cusID'] = this.cusID;
    cartItem['sellName'] = this.sellName;
    cartItem['product'] = this.product.toJson();
    cartItem['color'] = this.color;
    cartItem['size'] = this.size;
    cartItem['price'] = this.price;
    cartItem['quantity'] = this.quantity;
    cartItem['time'] = this.time;
    return cartItem;
  }
}
