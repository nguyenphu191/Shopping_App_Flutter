import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_shopping_app/models/CartItem.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_shopping_app/utils/url.dart' as url;

class CartProvider with ChangeNotifier {
  final String baseUrl = url.baseUrl;
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
    final url = Uri.parse('$baseUrl/carts/addtocart/$userId');
    List<CartItem> cartList = [];
    try {
      final response = await http.post(
        url,
        body: jsonEncode({
          'productID': productID,
          'sellID': sellID,
          'quantity': quantity,
          'color': color,
          'size': size,
          'price': price
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        data.forEach((element) {
          cartList.add(CartItem.fromJson(element));
        });
        _cartItems = cartList;
        notifyListeners();
        return {'status': 'success'};
      } else {
        return {'status': 'failed'};
      }
    } catch (e) {
      print("Lỗi khi gọi API: $e");
      return {'status': 'failed'};
    }
  }

  Future<void> getCartItems(String userId) async {
    final url = Uri.parse('$baseUrl/carts/getcart/$userId');
    List<CartItem> cartList = [];
    setLoading(true);
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        data.forEach((element) {
          cartList.add(CartItem.fromJson(element));
        });
        _cartItems = cartList;
        setLoading(false);
        notifyListeners();
      } else {
        print("Lấy danh sách sản phẩm thất bại: ${response.reasonPhrase}");
      }
    } catch (e) {
      print("Lỗi khi gọi API: $e");
    }
  }

  Future<Map<String, dynamic>> updateCartItems(
      String cartiteamID, bool isAdd) async {
    final url = Uri.parse('$baseUrl/carts/updatecart/$cartiteamID');
    setLoading(true);
    List<CartItem> cartList = [];
    try {
      final response = await http.patch(
        url,
        body: jsonEncode({'isAdd': isAdd}),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        data.forEach((element) {
          cartList.add(CartItem.fromJson(element));
        });
        _cartItems = cartList;
        setLoading(false);
        notifyListeners();
        return {'status': 'success'};
      } else {
        return {'status': 'failed'};
      }
    } catch (e) {
      print("Lỗi khi gọi API: $e");
      return {'status': 'failed'};
    }
  }

  Future<Map<String, dynamic>> deleteCartItem(String cartiteamID) async {
    final url = Uri.parse('$baseUrl/carts/deletecart/$cartiteamID');
    setLoading(true);
    List<CartItem> cartList = [];
    try {
      final response = await http.delete(url);
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        data.forEach((element) {
          cartList.add(CartItem.fromJson(element));
        });
        _cartItems = cartList;
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
