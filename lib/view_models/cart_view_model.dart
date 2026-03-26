import 'package:flutter/material.dart';
import 'package:flutter_shopping_app/models/cart_item.dart';
import 'package:flutter_shopping_app/repositories/cart_repository.dart';

class CartViewModel with ChangeNotifier {
  final CartRepository _cartRepository;
  CartViewModel(this._cartRepository);

  List<CartItem> _cartItems = [];
  bool _isLoading = false;

  List<CartItem> get cartItems => _cartItems;
  bool get isLoading => _isLoading;

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<Map<String, dynamic>> addToCart(
      String userId,
      String productID,
      String sellID,
      String color,
      String size,
      double price,
      int quantity) async {
    try {
      final result = await _cartRepository.addToCart(
          userId, productID, sellID, color, size, price, quantity);
      if (result['status'] == 'success') {
        _cartItems = result['cartItems'] as List<CartItem>;
        notifyListeners();
        return {'status': 'success'};
      } else {
        return {'status': 'failed'};
      }
    } catch (e) {
      return {'status': 'failed'};
    }
  }

  Future<void> getCartItems(String userId) async {
    setLoading(true);
    try {
      final cartList = await _cartRepository.getCartItems(userId);
      _cartItems = cartList;
      setLoading(false);
      notifyListeners();
    } catch (e) {
    }
  }

  Future<Map<String, dynamic>> updateCartItems(
      String cartItemID, bool isAdd) async {
    setLoading(true);
    try {
      final result =
          await _cartRepository.updateCartItems(cartItemID, isAdd);
      if (result['status'] == 'success') {
        _cartItems = result['cartItems'] as List<CartItem>;
        setLoading(false);
        notifyListeners();
        return {'status': 'success'};
      } else {
        return {'status': 'failed'};
      }
    } catch (e) {
      return {'status': 'failed'};
    }
  }

  Future<Map<String, dynamic>> deleteCartItem(String cartItemID) async {
    setLoading(true);
    try {
      final result = await _cartRepository.deleteCartItem(cartItemID);
      if (result['status'] == 'success') {
        _cartItems = result['cartItems'] as List<CartItem>;
        setLoading(false);
        notifyListeners();
        return {'status': 'success'};
      } else {
        return {'status': 'failed'};
      }
    } catch (e) {
      return {'status': 'failed'};
    }
  }
}
