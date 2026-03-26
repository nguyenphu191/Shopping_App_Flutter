import 'package:flutter/material.dart';
import 'package:flutter_shopping_app/models/order.dart';
import 'package:flutter_shopping_app/models/product.dart';
import 'package:flutter_shopping_app/models/user.dart';
import 'package:flutter_shopping_app/repositories/admin_repository.dart';

class AdminViewModel with ChangeNotifier {
  final AdminRepository _repo;
  AdminViewModel(this._repo);

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Map<String, dynamic> _stats = {};
  Map<String, dynamic> get stats => _stats;

  List<OrderModel> _pendingOrders = [];
  List<OrderModel> get pendingOrders => _pendingOrders;

  List<User> _users = [];
  List<User> get users => _users;

  List<ProductModel> _products = [];
  List<ProductModel> get products => _products;

  void _setLoading(bool v) {
    _isLoading = v;
    notifyListeners();
  }

  Future<void> loadStats() async {
    _setLoading(true);
    _stats = await _repo.getStats();
    _setLoading(false);
  }

  Future<void> loadPendingOrders() async {
    _setLoading(true);
    _pendingOrders = await _repo.getPendingOrders();
    _setLoading(false);
  }

  Future<bool> approveOrder(String id) async {
    final ok = await _repo.approveOrder(id);
    if (ok) {
      _pendingOrders.removeWhere((o) => o.id == id);
      notifyListeners();
    }
    return ok;
  }

  Future<bool> rejectOrder(String id) async {
    final ok = await _repo.rejectOrder(id);
    if (ok) {
      _pendingOrders.removeWhere((o) => o.id == id);
      notifyListeners();
    }
    return ok;
  }

  Future<void> loadUsers() async {
    _setLoading(true);
    _users = await _repo.getAllUsers();
    _setLoading(false);
  }

  Future<bool> deleteUser(String userId) async {
    final ok = await _repo.deleteUser(userId);
    if (ok) {
      _users.removeWhere((u) => u.id == userId);
      notifyListeners();
    }
    return ok;
  }

  Future<bool> blockUser(String userId) async {
    final ok = await _repo.blockUser(userId);
    if (ok) {
      final idx = _users.indexWhere((u) => u.id == userId);
      if (idx != -1) {
        _users[idx].isBlocked = true;
        notifyListeners();
      }
    }
    return ok;
  }

  Future<bool> unblockUser(String userId) async {
    final ok = await _repo.unblockUser(userId);
    if (ok) {
      final idx = _users.indexWhere((u) => u.id == userId);
      if (idx != -1) {
        _users[idx].isBlocked = false;
        notifyListeners();
      }
    }
    return ok;
  }

  Future<void> loadProducts() async {
    _setLoading(true);
    _products = await _repo.getAllProducts();
    _setLoading(false);
  }

  Future<bool> deleteProduct(String productId) async {
    final ok = await _repo.deleteProduct(productId);
    if (ok) {
      _products.removeWhere((p) => p.id == productId);
      notifyListeners();
    }
    return ok;
  }

  Future<bool> blockProduct(String productId) async {
    final ok = await _repo.blockProduct(productId);
    if (ok) {
      final idx = _products.indexWhere((p) => p.id == productId);
      if (idx != -1) {
        _products[idx].isBlocked = true;
        notifyListeners();
      }
    }
    return ok;
  }

  Future<bool> addBalance(double amount) async {
    return await _repo.addBalance(amount);
  }

  Future<bool> unblockProduct(String productId) async {
    final ok = await _repo.unblockProduct(productId);
    if (ok) {
      final idx = _products.indexWhere((p) => p.id == productId);
      if (idx != -1) {
        _products[idx].isBlocked = false;
        notifyListeners();
      }
    }
    return ok;
  }
}
