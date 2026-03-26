import 'package:flutter_shopping_app/core/network/http_client.dart';
import 'package:flutter_shopping_app/core/constants/api_endpoints.dart';
import 'package:flutter_shopping_app/models/product.dart';

class WishlistRepository {
  final AppHttpClient _client;
  WishlistRepository(this._client);

  Future<bool> addToWishlist(String userId, String productId) async {
    try {
      await _client.post(ApiEndpoints.wishlistAdd, {
        'userId': userId,
        'productId': productId,
      });
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> removeFromWishlist(String userId, String productId) async {
    try {
      await _client.delete(
          '${ApiEndpoints.wishlistRemove}/$userId/$productId');
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<List<ProductModel>> getWishlist(String userId) async {
    try {
      final data = await _client.get('${ApiEndpoints.wishlistGet}/$userId');
      final Map<String, dynamic> responseData = data as Map<String, dynamic>;
      return (responseData['products'] as List)
          .map((e) => ProductModel.fromJson(e))
          .toList();
    } catch (e) {
      return [];
    }
  }

  Future<bool> checkWishlist(String userId, String productId) async {
    try {
      final data = await _client
          .get('${ApiEndpoints.wishlistCheck}/$userId/$productId');
      final Map<String, dynamic> responseData = data as Map<String, dynamic>;
      return responseData['isWishlisted'] as bool;
    } catch (e) {
      return false;
    }
  }
}
