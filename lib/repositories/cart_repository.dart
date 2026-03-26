import 'package:flutter_shopping_app/core/network/http_client.dart';
import 'package:flutter_shopping_app/core/constants/api_endpoints.dart';
import 'package:flutter_shopping_app/models/cart_item.dart';

class CartRepository {
  final AppHttpClient _client;
  CartRepository(this._client);

  Future<Map<String, dynamic>> addToCart(
      String userId,
      String productID,
      String sellID,
      String color,
      String size,
      double price,
      int quantity) async {
    try {
      final data = await _client.post(
        '${ApiEndpoints.addToCart}/$userId',
        {
          'productID': productID,
          'sellID': sellID,
          'quantity': quantity,
          'color': color,
          'size': size,
          'price': price,
        },
      );
      final List<dynamic> list = data as List<dynamic>;
      final List<CartItem> cartItems =
          list.map((element) => CartItem.fromJson(element)).toList();
      return {'status': 'success', 'cartItems': cartItems};
    } catch (e) {
      return {'status': 'failed'};
    }
  }

  Future<List<CartItem>> getCartItems(String userId) async {
    try {
      final data = await _client.get('${ApiEndpoints.getCart}/$userId');
      final List<dynamic> list = data as List<dynamic>;
      return list.map((element) => CartItem.fromJson(element)).toList();
    } catch (e) {
      return [];
    }
  }

  Future<Map<String, dynamic>> updateCartItems(
      String cartItemID, bool isAdd) async {
    try {
      final data = await _client.patch(
        '${ApiEndpoints.updateCart}/$cartItemID',
        {'isAdd': isAdd},
      );
      final List<dynamic> list = data as List<dynamic>;
      final List<CartItem> cartItems =
          list.map((element) => CartItem.fromJson(element)).toList();
      return {'status': 'success', 'cartItems': cartItems};
    } catch (e) {
      return {'status': 'failed'};
    }
  }

  Future<Map<String, dynamic>> deleteCartItem(String cartItemID) async {
    try {
      final data =
          await _client.delete('${ApiEndpoints.deleteCart}/$cartItemID');
      final List<dynamic> list = data as List<dynamic>;
      final List<CartItem> cartItems =
          list.map((element) => CartItem.fromJson(element)).toList();
      return {'status': 'success', 'cartItems': cartItems};
    } catch (e) {
      return {'status': 'failed'};
    }
  }
}
