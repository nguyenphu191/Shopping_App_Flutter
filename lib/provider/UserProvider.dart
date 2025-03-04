import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_shopping_app/models/User.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_shopping_app/utils/url.dart' as url;

class UserProvider with ChangeNotifier {
  final String baseUrl = url.baseUrl;
  User? _user;
  User? _sel;
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  User? get user => _user;
  User? get sel => _sel;

  void setUser(User user) {
    _user = user;
    notifyListeners();
  }

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<User> findUserById(String id) async {
    final url = Uri.parse('$baseUrl/users/getuser/$id');
    setLoading(true);
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);

        User user = User.fromJson(jsonData['user']);
        setLoading(false);
        _sel = user;
        notifyListeners();
        return user;
      } else {
        throw Exception('Failed to load user');
      }
    } on Exception catch (e) {
      throw Exception('Failed to load user: $e');
    } finally {
      setLoading(false);
    }
  }

  Future<User> getUserReview(String userId) async {
    setLoading(true);
    final url = Uri.parse('$baseUrl/users/getuser/$userId');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);

        User user = User.fromJson(jsonData['user']);
        setLoading(false);
        notifyListeners();
        return user;
      } else {
        throw Exception('Failed to load user');
      }
    } on Exception catch (e) {
      throw Exception('Failed to load user: $e');
    } finally {
      setLoading(false);
    }
  }
}
