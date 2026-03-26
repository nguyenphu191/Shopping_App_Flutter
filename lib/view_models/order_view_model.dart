import 'package:flutter/material.dart';
import 'package:flutter_shopping_app/models/cart_item.dart';
import 'package:flutter_shopping_app/models/order.dart';
import 'package:flutter_shopping_app/repositories/order_repository.dart';

class OrderViewModel with ChangeNotifier {
  final OrderRepository _orderRepository;
  OrderViewModel(this._orderRepository);

  List<OrderModel> _orders = [];
  bool _isLoading = false;
  List<CartItem> _cartItems = [];
  double _total = 0;

  List<OrderModel> get orderItems => _orders;
  bool get isLoading => _isLoading;
  List<CartItem> get cartItems => _cartItems;
  double get total => _total;

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<void> getInfor(List<String> cartItemList) async {
    setLoading(true);
    try {
      final result = await _orderRepository.getInfor(cartItemList);
      if (result['status'] == 'success') {
        _cartItems = result['cartList'] as List<CartItem>;
        _total = result['total'] as double;
        setLoading(false);
        notifyListeners();
      }
    } catch (e) {
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
    try {
      final result = await _orderRepository.createOrder(
          cartItemList,
          userID,
          methodPayment,
          isPaymented,
          reciever,
          phone,
          total,
          address);
      if (result['status'] == 'success') {
        notifyListeners();
      }
      return result;
    } catch (e) {
      return {'status': 'failed'};
    }
  }

  Future<List<OrderModel>> getUserOrder(String userID) async {
    setLoading(true);
    try {
      final orderList = await _orderRepository.getUserOrder(userID);
      _orders = orderList;
      setLoading(false);
      notifyListeners();
      return orderList;
    } catch (e) {
      return [];
    } finally {
      setLoading(false);
    }
  }

  Future<Map<String, dynamic>> updateOrder(String id, String status) async {
    setLoading(true);
    try {
      final result = await _orderRepository.updateOrder(id, status);
      if (result['status'] == 'success') {
        setLoading(false);
        notifyListeners();
      }
      return result;
    } catch (e) {
      return {'status': 'failed'};
    }
  }

  List<OrderModel> _sellerOrders = [];
  List<OrderModel> get sellerOrders => _sellerOrders;

  Future<void> getSellerOrders(String sellerId) async {
    setLoading(true);
    try {
      _sellerOrders = await _orderRepository.getSellerOrders(sellerId);
      notifyListeners();
    } catch (e) {
      _sellerOrders = [];
    } finally {
      setLoading(false);
    }
  }

  Future<Map<String, dynamic>> updateOrderBySeller(String id, String status) async {
    try {
      final result = await _orderRepository.updateOrderBySeller(id, status);
      if (result['status'] == 'success') {
        final idx = _sellerOrders.indexWhere((o) => o.id == id);
        if (idx != -1) {
          _sellerOrders[idx].status = status;
        }
        notifyListeners();
      }
      return result;
    } catch (e) {
      return {'status': 'failed'};
    }
  }
}
