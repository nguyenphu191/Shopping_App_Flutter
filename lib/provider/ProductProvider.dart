import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_shopping_app/models/Product.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_shopping_app/utils/url.dart' as url;

class ProductProvider with ChangeNotifier {
  final String baseUrl = url.baseUrl;
  List<ProductModel> _allproducts = [];
  List<ProductModel> _filterproducts = [];
  ProductModel? _product;
  List<ProductModel> _popularproducts = [];
  List<ProductModel> _userproducts = [];
  bool _isLoading = false;

  List<ProductModel> get popularproducts => _popularproducts;
  List<ProductModel> get userproducts => _userproducts;
  List<ProductModel> get allproducts => _allproducts;
  List<ProductModel> get filterproducts => _filterproducts;
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
    final url = Uri.parse('$baseUrl/products/addproduct/$userId');
    try {
      final response = await http.post(
        url,
        body: jsonEncode(product),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      if (response.statusCode == 200) {
        notifyListeners();
      } else {}
    } catch (e) {}
  }

  Future<List<ProductModel>> getUserProducts(String userId) async {
    setLoading(true);
    final url = Uri.parse('$baseUrl/products/getproducts/$userId');
    List<ProductModel> productList = [];
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        data.forEach((element) {
          productList.add(ProductModel.fromJson(element));
        });
        _userproducts = productList;
        setLoading(false);
        notifyListeners();
        return productList;
      } else {
        print("Lấy danh sách sản phẩm thất bại: ${response.reasonPhrase}");
        return [];
      }
    } catch (e) {
      print("Lỗi khi gọi API: $e");
      return [];
    } finally {
      setLoading(false);
    }
  }

  Future<void> getPopularProducts() async {
    final url = Uri.parse('$baseUrl/products/getpopular');
    setLoading(true);
    List<ProductModel> productList = [];
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        data.forEach((element) {
          productList.add(ProductModel.fromJson(element));
        });
        print(productList);
        _popularproducts = productList;
        setLoading(false);
        notifyListeners();
      } else {
        print("Lấy danh sách sản phẩm thất bại: ${response.reasonPhrase}");
      }
    } catch (e) {
      print("Lỗi khi gọi API: $e");
    } finally {
      setLoading(false);
    }
  }

  Future<void> getAllProducts() async {
    final url = Uri.parse('$baseUrl/products/getproducts');
    setLoading(true);
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        List<ProductModel> products = (responseData['products'] as List)
            .map((item) => ProductModel.fromJson(item))
            .toList();
        _allproducts = products;
        setLoading(false);
        notifyListeners();
      }
    } catch (e) {
      print("Lỗi khi gọi API: $e");
    } finally {
      setLoading(false);
    }
  }

  Future<ProductModel> getProduct(String id) async {
    setLoading(true);
    final url = Uri.parse('$baseUrl/products/getproduct/$id');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        ProductModel product = ProductModel.fromJson(data);
        setLoading(false);
        notifyListeners();
        _product = product;
        return product;
      } else {
        throw Exception("Lấy sản phẩm thất bại: ${response.reasonPhrase}");
      }
    } catch (e) {
      throw Exception("Lỗi khi gọi API: $e");
    } finally {
      setLoading(false);
    }
  }

  Future<Map<String, dynamic>> updateProduct(
      String id, Map<String, dynamic> product) async {
    final url = Uri.parse('$baseUrl/products/updateproduct/$id');
    try {
      final response = await http.patch(
        url,
        body: jsonEncode(product),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      if (response.statusCode == 200) {
        return {'status': 'success'};
      } else {
        return {'status': 'failed'};
      }
    } catch (e) {
      return {'status': 'failed'};
    }
  }

  Future<void> getSearchProduct(String key) async {
    setLoading(true);
    final url = Uri.parse('$baseUrl/products/searchproduct/$key');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        List<ProductModel> products = (responseData['products'] as List)
            .map((item) => ProductModel.fromJson(item))
            .toList();
        setFilterProducts(products);
        setLoading(false);
        notifyListeners();
      } else {
        throw Exception("Lấy sản phẩm thất bại: ${response.reasonPhrase}");
      }
    } catch (e) {
      throw Exception("Lỗi khi gọi API: $e");
    } finally {
      setLoading(false);
    }
  }
}
