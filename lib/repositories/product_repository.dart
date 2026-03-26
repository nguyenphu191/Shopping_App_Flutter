import 'package:flutter_shopping_app/core/network/http_client.dart';
import 'package:flutter_shopping_app/core/constants/api_endpoints.dart';
import 'package:flutter_shopping_app/models/product.dart';

class ProductRepository {
  final AppHttpClient _client;
  ProductRepository(this._client);

  Future<void> addProduct(String userId, Map<String, dynamic> product) async {
    try {
      await _client.post(
        '${ApiEndpoints.addProduct}/$userId',
        product,
      );
    } catch (e) {
      throw Exception('Failed to add product: $e');
    }
  }

  Future<List<ProductModel>> getUserProducts(String userId) async {
    try {
      final data =
          await _client.get('${ApiEndpoints.getProducts}/$userId');
      final List<dynamic> list = data as List<dynamic>;
      return list.map((element) => ProductModel.fromJson(element)).toList();
    } catch (e) {
      return [];
    }
  }

  Future<List<ProductModel>> getPopularProducts() async {
    try {
      final data = await _client.get(ApiEndpoints.getPopular);
      final List<dynamic> list = data as List<dynamic>;
      return list.map((element) => ProductModel.fromJson(element)).toList();
    } catch (e) {
      return [];
    }
  }

  Future<List<ProductModel>> getAllProducts() async {
    try {
      final data = await _client.get(ApiEndpoints.getProducts);
      final Map<String, dynamic> responseData = data as Map<String, dynamic>;
      return (responseData['products'] as List)
          .map((item) => ProductModel.fromJson(item))
          .toList();
    } catch (e) {
      return [];
    }
  }

  Future<ProductModel> getProduct(String id) async {
    try {
      final data = await _client.get('${ApiEndpoints.getProduct}/$id');
      return ProductModel.fromJson(data);
    } catch (e) {
      throw Exception('Failed to get product: $e');
    }
  }

  Future<Map<String, dynamic>> updateProduct(
      String id, Map<String, dynamic> product) async {
    try {
      await _client.patch(
          '${ApiEndpoints.updateProduct}/$id', product);
      return {'status': 'success'};
    } catch (e) {
      return {'status': 'failed'};
    }
  }

  Future<bool> deleteProduct(String id) async {
    try {
      await _client.delete('${ApiEndpoints.deleteProduct}/$id');
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<List<ProductModel>> searchProducts(String key) async {
    try {
      final data =
          await _client.get('${ApiEndpoints.searchProduct}/$key');
      final Map<String, dynamic> responseData = data as Map<String, dynamic>;
      return (responseData['products'] as List)
          .map((item) => ProductModel.fromJson(item))
          .toList();
    } catch (e) {
      throw Exception('Failed to search products: $e');
    }
  }
}
