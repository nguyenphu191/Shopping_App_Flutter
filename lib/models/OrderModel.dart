import 'package:flutter/cupertino.dart';
import 'package:flutter_shopping_app/models/cart_item.dart';

class OrderModel {
  String id ;
  List<CartItem> cartList;
  double total;
  bool isDone;
  OrderModel(
      {required this.id,required this.cartList, required this.total, required this.isDone});
}
