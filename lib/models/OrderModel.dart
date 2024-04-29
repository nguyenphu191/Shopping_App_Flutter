// import 'package:flutter/cupertino.dart';
import 'package:flutter_shopping_app/models/cart_item.dart';

class OrderModel {
  String id;
  List<CartItem> cartList;
  double total;
  bool isDone;
  String reciever;
  String userName;
  String address;
  String phone;
  String date;
  String dateComplete;
  OrderModel(
      {required this.id,
      required this.cartList,
      required this.total,
      required this.isDone,
      required this.reciever,
      required this.userName,
      required this.address,
      required this.phone,
      required this.date,
      required this.dateComplete});
  set setUName(String value) {
    userName = value;
  }

  set setReciever(String value) {
    reciever = value;
  }

  set setAddress(String value) {
    address = value;
  }

  set setDate(String value) {
    date = value;
  }

  set setIsDone(bool value) {
    isDone = value;
  }

  set setTotal(double value) {
    total = value;
  }

  set setCartList(List<CartItem> value) {
    cartList = value;
  }

  set setDateComplete(String value) {
    dateComplete = value;
  }
}
