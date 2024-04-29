import 'package:flutter_shopping_app/models/OrderModel.dart';
import 'package:flutter_shopping_app/models/cart_item.dart';
import 'package:flutter_shopping_app/models/product.dart';
import 'package:flutter_shopping_app/data/app_data.dart' as app_data;

class User {
  String? username;
  String? email;
  String? phone;
  String? password;
  String? city;
  String? id;
  late List<ProductModel> productList;
  late List<CartItem> cartList;
  late List<OrderModel> orderList;
  User(
      {this.username,
      this.email,
      this.phone,
      this.password,
      this.city,
      this.id,
      required this.productList,
      required this.cartList,
      required this.orderList});

  void addCart(CartItem x) {
    cartList.add(x);
  }

  set addOrder(OrderModel x) {
    orderList.add(x);
  }

  void reCart() {
    cartList = [app_data.it0];
  }

  set setName(String x) {
    username = x;
  }

  set setEmail(String x) {
    email = x;
  }

  set setPhone(String x) {
    phone = x;
  }

  set setPass(String x) {
    password = x;
  }

  set setCity(String x) {
    city = x;
  }
  // User.fromJson(Map<String, dynamic> json) {
  //   username = json['username'];
  //   email = json['email'];
  //   phone = json['phone'];
  //   password = json['password'];
  //   city = json['city'];
  //   id = json['id'];
  // }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['username'] = this.username;
  //   data['email'] = this.email;
  //   data['phone'] = this.phone;
  //   data['password'] = this.password;
  //   data['city'] = this.city;
  //   data['id'] = this.id;
  //   return data;
  // }
}
