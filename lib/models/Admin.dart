import 'package:flutter_shopping_app/models/OrderModel.dart';
import 'package:flutter_shopping_app/models/User.dart';
import 'package:flutter_shopping_app/models/product.dart';

class Admin {
  String? adName;
  String? adPass;
  late List<User> userList;
  late List<ProductModel> productList;
  late List<OrderModel> orderList;
  Admin({
    this.adName,
    this.adPass,
    required this.userList,
    required this.productList,
    required this.orderList,
  });
}
