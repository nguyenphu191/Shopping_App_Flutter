import 'package:flutter/material.dart';
import 'package:flutter_shopping_app/models/product.dart';
import 'package:flutter_shopping_app/repositories/product_repository.dart';

class ProductViewModel with ChangeNotifier {
  final ProductRepository _productRepository;
  ProductViewModel(this._productRepository);

  List<ProductModel> _allproducts = [];
  List<ProductModel> _filterproducts = [];
  ProductModel? _product;
  List<ProductModel> _popularproducts = [];
  List<ProductModel> _userproducts = [];
  bool _isLoading = false;

  List<ProductModel> get popularproducts => _popularproducts.where((p) => !p.isBlocked).toList();
  List<ProductModel> get userproducts => _userproducts;
  List<ProductModel> get allproducts => _allproducts.where((p) => !p.isBlocked).toList();
  List<ProductModel> get filterproducts => _filterproducts.where((p) => !p.isBlocked).toList();
  ProductModel? get product => _product;
  bool get isLoading => _isLoading;

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void setFilterProducts(List<ProductModel> value) {
    _filterproducts = value;
    notifyListeners();
  }

  Future<void> addProduct(String userId, Map<String, dynamic> product) async {
    try {
      await _productRepository.addProduct(userId, product);
      notifyListeners();
    } catch (e) {}
  }

  Future<List<ProductModel>> getUserProducts(String userId) async {
    setLoading(true);
    try {
      final productList = await _productRepository.getUserProducts(userId);
      _userproducts = productList;
      setLoading(false);
      notifyListeners();
      return productList;
    } catch (e) {
      return [];
    } finally {
      setLoading(false);
    }
  }

  Future<void> getPopularProducts() async {
    setLoading(true);
    try {
      final productList = await _productRepository.getPopularProducts();
      _popularproducts = productList;
      setLoading(false);
      notifyListeners();
    } catch (e) {
    } finally {
      setLoading(false);
    }
  }

  Future<void> getAllProducts() async {
    setLoading(true);
    try {
      final products = await _productRepository.getAllProducts();
      _allproducts = products;
      setLoading(false);
      notifyListeners();
    } catch (e) {
    } finally {
      setLoading(false);
    }
  }

  Future<ProductModel> getProduct(String id) async {
    setLoading(true);
    try {
      final product = await _productRepository.getProduct(id);
      _product = product;
      setLoading(false);
      notifyListeners();
      return product;
    } catch (e) {
      throw Exception('Failed to get product: $e');
    } finally {
      setLoading(false);
    }
  }

  Future<Map<String, dynamic>> updateProduct(
      String id, Map<String, dynamic> product) async {
    try {
      return await _productRepository.updateProduct(id, product);
    } catch (e) {
      return {'status': 'failed'};
    }
  }

  Future<bool> deleteProduct(String id) async {
    final ok = await _productRepository.deleteProduct(id);
    if (ok) {
      _userproducts.removeWhere((p) => p.id == id);
      notifyListeners();
    }
    return ok;
  }

  Future<void> getSearchProduct(String key) async {
    setLoading(true);
    try {
      final products = await _productRepository.searchProducts(key);
      setFilterProducts(products);
      setLoading(false);
      notifyListeners();
    } catch (e) {
      throw Exception('Failed to search products: $e');
    } finally {
      setLoading(false);
    }
  }
}
