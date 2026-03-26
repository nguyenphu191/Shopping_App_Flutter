import 'package:flutter_shopping_app/core/network/http_client.dart';
import 'package:flutter_shopping_app/core/constants/api_endpoints.dart';
import 'package:flutter_shopping_app/models/order.dart';
import 'package:flutter_shopping_app/models/product.dart';
import 'package:flutter_shopping_app/models/user.dart';

class AdminRepository {
  final AppHttpClient _client;
  AdminRepository(this._client);

  Future<Map<String, dynamic>> getStats() async {
    try {
      final data = await _client.get(ApiEndpoints.adminStats);
      return data as Map<String, dynamic>;
    } catch (e) {
      return {};
    }
  }

  Future<List<OrderModel>> getPendingOrders() async {
    try {
      final data = await _client.get(ApiEndpoints.adminPendingOrders);
      final Map<String, dynamic> responseData = data as Map<String, dynamic>;
      return (responseData['orders'] as List)
          .map((e) => OrderModel.fromJson(e))
          .toList();
    } catch (e) {
      return [];
    }
  }

  Future<bool> approveOrder(String id) async {
    try {
      await _client.patch('${ApiEndpoints.adminApproveOrder}/$id', {});
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> rejectOrder(String id) async {
    try {
      await _client.patch('${ApiEndpoints.adminRejectOrder}/$id', {});
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<List<User>> getAllUsers() async {
    try {
      final data = await _client.get(ApiEndpoints.adminGetUsers);
      final Map<String, dynamic> responseData = data as Map<String, dynamic>;
      return (responseData['users'] as List)
          .map((e) => User.fromJson(e))
          .toList();
    } catch (e) {
      return [];
    }
  }

  Future<bool> deleteUser(String userId) async {
    try {
      await _client.delete('${ApiEndpoints.adminDeleteUser}/$userId');
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> blockUser(String userId) async {
    try {
      await _client.patch('${ApiEndpoints.adminBlockUser}/$userId', {});
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> unblockUser(String userId) async {
    try {
      await _client.patch('${ApiEndpoints.adminUnblockUser}/$userId', {});
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<List<ProductModel>> getAllProducts() async {
    try {
      final data = await _client.get(ApiEndpoints.adminGetProducts);
      final Map<String, dynamic> responseData = data as Map<String, dynamic>;
      return (responseData['products'] as List)
          .map((e) => ProductModel.fromJson(e))
          .toList();
    } catch (e) {
      return [];
    }
  }

  Future<bool> deleteProduct(String productId) async {
    try {
      await _client.delete('${ApiEndpoints.adminDeleteProduct}/$productId');
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> blockProduct(String productId) async {
    try {
      await _client.patch('${ApiEndpoints.adminBlockProduct}/$productId', {});
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> unblockProduct(String productId) async {
    try {
      await _client.patch('${ApiEndpoints.adminUnblockProduct}/$productId', {});
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> addBalance(double amount) async {
    try {
      await _client.patch(ApiEndpoints.adminAddBalance, {'amount': amount});
      return true;
    } catch (e) {
      return false;
    }
  }
}
