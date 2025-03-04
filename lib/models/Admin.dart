import 'package:flutter_shopping_app/models/Order.dart';
import 'package:flutter_shopping_app/models/Product.dart';
import 'package:flutter_shopping_app/models/User.dart';

class Admin {
  late String adName;
  late String adPass;
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
