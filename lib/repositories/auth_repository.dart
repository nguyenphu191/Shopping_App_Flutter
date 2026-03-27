import 'package:flutter_shopping_app/core/network/http_client.dart';
import 'package:flutter_shopping_app/core/constants/api_endpoints.dart';
import 'package:flutter_shopping_app/models/address.dart';
import 'package:flutter_shopping_app/models/user.dart';

class AuthRepository {
  final AppHttpClient _client;
  AuthRepository(this._client);

  Future<Map<String, dynamic>> login(
      String email, String password) async {
    try {
      final data = await _client.post(
        ApiEndpoints.login,
        {'email': email, 'password': password},
      );
      if (data['user'] != null) {
        final User user = User.fromJson(data['user']);
        final String role = data['role'];
        return {'status': 'success', 'user': user, 'role': role};
      } else {
        throw Exception('Failed to login');
      }
    } catch (e) {
      throw Exception('Failed to login: $e');
    }
  }

  Future<Map<String, dynamic>> register(
      String username,
      String role,
      String email,
      String phone,
      String password,
      Address address) async {
    try {
      await _client.post(
        ApiEndpoints.register,
        {
          'username': username,
          'role': role,
          'email': email,
          'phone': phone,
          'password': password,
          'address': address.toJson(),
        },
      );
      return {'status': 'success'};
    } catch (e) {
      return {'status': 'error', 'message': e.toString()};
    }
  }
}
