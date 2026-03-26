import 'package:flutter_shopping_app/core/network/http_client.dart';
import 'package:flutter_shopping_app/core/constants/api_endpoints.dart';
import 'package:flutter_shopping_app/models/user.dart';

class UserRepository {
  final AppHttpClient _client;
  UserRepository(this._client);

  Future<User> findUserById(String id) async {
    try {
      final data = await _client.get('${ApiEndpoints.getUser}/$id');
      return User.fromJson(data['user']);
    } catch (e) {
      throw Exception('Failed to load user: $e');
    }
  }

  Future<User> getUserReview(String userId) async {
    try {
      final data = await _client.get('${ApiEndpoints.getUser}/$userId');
      return User.fromJson(data['user']);
    } catch (e) {
      throw Exception('Failed to load user: $e');
    }
  }

  Future<Map<String, dynamic>> updateUser({
    required String userId,
    String? username,
    String? phone,
    String? email,
    Map<String, dynamic>? address,
    String? avatar,
  }) async {
    final Map<String, dynamic> body = {
      if (username != null) 'username': username,
      if (phone != null) 'phone': phone,
      if (email != null) 'email': email,
      if (address != null) 'address': address,
      if (avatar != null) 'avatar': avatar,
    };
    final data =
        await _client.patch('${ApiEndpoints.updateUser}/$userId', body);
    return {
      'status': 'success',
      'updatedUser': data['updatedUser'],
    };
  }

  Future<bool> deductBalance(String userId, double amount) async {
    try {
      await _client.patch('${ApiEndpoints.deductBalance}/$userId', {'amount': amount});
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> addBalance(String userId, double amount) async {
    try {
      await _client.patch('${ApiEndpoints.addBalance}/$userId', {'amount': amount});
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<Map<String, dynamic>> deleteUser(String userId) async {
    await _client.delete('${ApiEndpoints.deleteUser}/$userId');
    return {'status': 'success'};
  }
}
