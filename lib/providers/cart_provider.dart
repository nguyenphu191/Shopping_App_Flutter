import 'package:flutter/foundation.dart';
import 'package:flutter_shopping_app/data/app_data.dart';
import 'package:flutter_shopping_app/models/cart_item.dart';
import 'package:flutter_shopping_app/models/product.dart';

class CartProvider extends ChangeNotifier {
  final List<CartItem> _shoppingCart = [];

  void addToCart(ProductModel product) {
    var isExist =
        _shoppingCart.where((element) => element.product.id == product.id);
    if (isExist.isEmpty) {
      _shoppingCart.add(CartItem(
        product: product,
        quantity: 1,
      ));
    } else {
      isExist.first.quantity += 1;
    }
    notifyListeners();
  }

  void removeItem(String productId) {
    _shoppingCart.removeWhere((element) => element.id == productId);
    notifyListeners();
  }

  void incrementQty(String productId) {
    CartItem item =
        _shoppingCart.where((element) => element.id == productId).first;
    item.quantity++;
    notifyListeners();
  }

  void decrimentQty(String productId) {
    CartItem item =
        _shoppingCart.where((element) => element.id == productId).first;

    if (item.quantity > 1) {
      item.quantity--;
    } else {
      _shoppingCart.remove(item);
    }
    notifyListeners();
  }

  double getCartTotal() {
    double total = 0;
    for (var cartItem in _shoppingCart) {
      total += (cartItem.product.price * cartItem.quantity);
    }
    return total;
  }

  List<CartItem> get shoppingCart => _shoppingCart;
  double get cartSubTotal => getCartTotal();
  double get shippingCharge => 120;
  double get cartTotal => cartSubTotal + shippingCharge;
}
