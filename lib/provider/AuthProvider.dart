import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_shopping_app/models/Address.dart';
import 'package:flutter_shopping_app/models/User.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_shopping_app/utils/url.dart' as url;

class AuthProvider with ChangeNotifier {
  final String baseUrl = url.baseUrl;
  User? _user;
  String? _role;
  User? get user => _user;
  String? get role => _role;
  Future<void> login(String username, String password) async {
    final url = Uri.parse('$baseUrl/users/login');
    final response = await http.post(
      url,
      body: jsonEncode({'username': username, 'password': password}),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> userData = jsonDecode(response.body)['user'];
      _user = User.fromJson(userData);
      _role = jsonDecode(response.body)['role'];
    } else {
      throw Exception('Failed to login');
    }
    notifyListeners();
  }

  Future<Map<String, dynamic>> register(String username, String role,
      String email, String phone, String password, Address address) async {
    final url = Uri.parse('$baseUrl/users/register');
    try {
      final response = await http.post(
        url,
        body: jsonEncode({
          'username': username,
          'role': role,
          'email': email,
          'phone': phone,
          'password': password,
          'address': address.toJson(),
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      // Kiểm tra mã trạng thái thành công
      if (response.statusCode == 200) {
        // Nếu thành công, trả về thông tin thành công
        return {'status': 'success'};
      } else {
        // Nếu không thành công, phân tích và trả về thông báo lỗi
        final responseData = jsonDecode(response.body);
        return {
          'status': 'error',
          'message': responseData['message'] ?? 'Đăng ký thất bại'
        };
      }
    } catch (e) {
      // Xử lý các lỗi mạng hoặc lỗi khác
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
