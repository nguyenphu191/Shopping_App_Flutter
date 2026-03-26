import 'package:flutter/material.dart';
import 'package:flutter_shopping_app/models/address.dart';
import 'package:flutter_shopping_app/models/user.dart';
import 'package:flutter_shopping_app/repositories/auth_repository.dart';

class AuthViewModel with ChangeNotifier {
  final AuthRepository _authRepository;
  AuthViewModel(this._authRepository);

  User? _user;
  String? _role;

  User? get user => _user;
  String? get role => _role;

  Future<void> login(String username, String password) async {
    final result = await _authRepository.login(username, password);
    if (result['status'] == 'success') {
      final user = result['user'] as User;
      if (user.isBlocked) {
        throw Exception('Tài khoản của bạn đã bị khóa. Vui lòng liên hệ admin.');
      }
      _user = user;
      _role = result['role'] as String;
    } else {
      throw Exception('Failed to login');
    }
    notifyListeners();
  }

  Future<Map<String, dynamic>> register(
      String username,
      String role,
      String email,
      String phone,
      String password,
      Address address) async {
    try {
      final result = await _authRepository.register(
          username, role, email, phone, password, address);
      return result;
    } catch (e) {
      return {'status': 'error', 'message': e.toString()};
    } finally {
      notifyListeners();
    }
  }

  Future<void> logout() async {
    _user = null;
    notifyListeners();
  }
}
