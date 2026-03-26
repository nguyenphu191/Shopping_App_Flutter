import 'package:flutter/material.dart';
import 'package:flutter_shopping_app/models/product.dart';
import 'package:flutter_shopping_app/repositories/wishlist_repository.dart';

class WishlistViewModel with ChangeNotifier {
  final WishlistRepository _repo;
  WishlistViewModel(this._repo);

  List<ProductModel> _items = [];
  bool _isLoading = false;
  // tracks wishlisted productIds for the current product detail screen
  final Set<String> _wishlisted = {};

  List<ProductModel> get items => _items;
  bool get isLoading => _isLoading;
  bool isWishlisted(String productId) => _wishlisted.contains(productId);

  void _setLoading(bool v) {
    _isLoading = v;
    notifyListeners();
  }

  Future<void> loadWishlist(String userId) async {
    _setLoading(true);
    _items = await _repo.getWishlist(userId);
    _wishlisted
      ..clear()
      ..addAll(_items.map((p) => p.id));
    _setLoading(false);
  }

  Future<void> checkProduct(String userId, String productId) async {
    final result = await _repo.checkWishlist(userId, productId);
    if (result) {
      _wishlisted.add(productId);
    } else {
      _wishlisted.remove(productId);
    }
    notifyListeners();
  }

  Future<bool> toggle(String userId, String productId) async {
    final isNowWishlisted = _wishlisted.contains(productId);
    bool ok;
    if (isNowWishlisted) {
      ok = await _repo.removeFromWishlist(userId, productId);
      if (ok) {
        _wishlisted.remove(productId);
        _items.removeWhere((p) => p.id == productId);
      }
    } else {
      ok = await _repo.addToWishlist(userId, productId);
      if (ok) {
        _wishlisted.add(productId);
      }
    }
    notifyListeners();
    return ok;
  }
}
