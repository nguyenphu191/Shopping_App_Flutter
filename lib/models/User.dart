import 'package:flutter_shopping_app/models/Address.dart';

class User {
  late String id;
  late String username;
  late String email;
  late String phone;
  late String password;
  late Address address;

  late List<String> productList;
  late List<String> cartList;
  late List<String> orderList;
  User({
    required this.username,
    required this.email,
    required this.phone,
    required this.password,
    required this.id,
    required this.address,
  });

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    email = json['email'];
    phone = json['phone'];
    password = json['password'];
    address = Address.fromJson(json['address']);
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> user = new Map<String, dynamic>();
    user['id'] = this.id;
    user['username'] = this.username;
    user['email'] = this.email;
    user['phone'] = this.phone;
    user['password'] = this.password;
    user['address'] = this.address.toJson();
    return user;
  }
}
