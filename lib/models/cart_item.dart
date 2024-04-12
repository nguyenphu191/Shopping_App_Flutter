import 'package:flutter/foundation.dart';
import 'package:flutter_shopping_app/models/product.dart';

class CartItem {
  final String id = UniqueKey().toString();
  ProductModel product;
  int quantity;
  CartItem({
    required this.product,
    required this.quantity,
  });
  double totalPrice() => product.price * quantity;
}
