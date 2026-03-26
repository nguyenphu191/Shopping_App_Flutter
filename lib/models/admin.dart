import 'package:flutter_shopping_app/models/order.dart';
import 'package:flutter_shopping_app/models/product.dart';
import 'package:flutter_shopping_app/models/user.dart';

class Admin {
  late String adName;
  late String adPass;
  double balance = 0.0;
  late List<User> userList;
  late List<ProductModel> productList;
  late List<OrderModel> orderList;
  Admin({
    required this.adName,
    required this.adPass,
    required this.userList,
    required this.productList,
    required this.orderList,
  });

  Admin.fromJson(Map<String, dynamic> json) {
    adName = json['adName'];
    adPass = json['adPass'];
    balance = (json['balance'] is int)
        ? (json['balance'] as int).toDouble()
        : (json['balance'] as double? ?? 0.0);
    userList = json['userList'];
    productList = json['productList'];
    orderList = json['orderList'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> admin = new Map<String, dynamic>();
    admin['adName'] = this.adName;
    admin['adPass'] = this.adPass;
    admin['userList'] = this.userList;
    admin['productList'] = this.productList;
    admin['orderList'] = this.orderList;
    return admin;
  }
}
