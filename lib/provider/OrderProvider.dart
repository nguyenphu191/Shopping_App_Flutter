import 'dart:convert';
import 'package:flutter_shopping_app/models/CartItem.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_shopping_app/models/Order.dart';
import 'package:flutter_shopping_app/utils/url.dart' as url;

class OrderProvider with ChangeNotifier {
  final String baseUrl = url.baseUrl;
  List<OrderModel> _orders = [];
  bool _isLoading = false;
  List<CartItem> _cartItems = [];
  double _total = 0;

  List<OrderModel> get orderItems => _orders;
  bool get isLoading => _isLoading;
  List<CartItem> get cartItems => _cartItems;
  double get total => _total;

  setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<void> getInfor(List<String> cartItemList) async {
    setLoading(true);
    final url = Uri.parse('$baseUrl/orders/getInfor');
    List<CartItem> cartItems = [];
    try {
      final response = await http.post(
        url,
        body: jsonEncode({'cartItemList': cartItemList}),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        final List<dynamic> data = responseData['cartList'];
        data.forEach((element) {
          cartItems.add(CartItem.fromJson(element));
        });
        _cartItems = cartItems;
        _total = (responseData['total'] ?? 0).toDouble();
        setLoading(false);
        notifyListeners();
      } else {
        print('Failed to load cart items');
      }
    } catch (e) {
      print('Failed to load cart items');
    } finally {
      setLoading(false);
    }
  }

  Future<Map<String, dynamic>> createOrder(
      List<String> cartItemList,
      String userID,
      String methodPayment,
      bool isPaymented,
      String reciever,
      String phone,
      double total,
      String address) async {
    final url = Uri.parse('$baseUrl/orders/create');
    try {
      final response = await http.post(
        url,
        body: jsonEncode({
          'cartItemList': cartItemList,
          'userID': userID,
          'methodPayment': methodPayment,
          'isPaymented': isPaymented,
          'reciever': reciever,
          'total': total,
          'phone': phone,
          'address': address,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      if (response.statusCode == 200) {
        notifyListeners();
        return {'status': 'success'};
      } else {
        return {'status': 'failed'};
      }
    } catch (e) {
      return {'status': 'failed'};
    }
  }

  Future<List<OrderModel>> getUserOrder(String userID) async {
    setLoading(true);
    final url = Uri.parse('$baseUrl/orders/get/$userID');
    List<OrderModel> orderList = [];
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body); // Lấy đối tượng chứa 'orders'
        final List<dynamic> ordersData = data['orders'];

        ordersData.forEach((element) {
          orderList.add(OrderModel.fromJson(element));
        });
        _orders = orderList;
        setLoading(false);
        notifyListeners();
        return orderList;
      } else {
        return [];
      }
    } catch (e) {
      return [];
    } finally {
      setLoading(false);
    }
  }

  Future<Map<String, dynamic>> updateOrder(String id, String status) async {
    final url = Uri.parse('$baseUrl/orders/update/$id');
    setLoading(true);
    try {
      final response = await http.patch(
        url,
        body: jsonEncode({'status': status}),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      if (response.statusCode == 200) {
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
