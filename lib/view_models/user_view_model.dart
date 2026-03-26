import 'package:flutter/material.dart';
import 'package:flutter_shopping_app/models/user.dart';
import 'package:flutter_shopping_app/repositories/user_repository.dart';

class UserViewModel with ChangeNotifier {
  final UserRepository _userRepository;
  UserViewModel(this._userRepository);

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
    setLoading(true);
    try {
      final user = await _userRepository.findUserById(id);
      _sel = user;
      setLoading(false);
      notifyListeners();
      return user;
    } on Exception catch (e) {
      throw Exception('Failed to load user: $e');
    } finally {
      setLoading(false);
    }
  }

  Future<User> getUserReview(String userId) async {
    setLoading(true);
    try {
      final user = await _userRepository.getUserReview(userId);
      setLoading(false);
      notifyListeners();
      return user;
    } on Exception catch (e) {
      throw Exception('Failed to load user: $e');
    } finally {
      setLoading(false);
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
    try {
      final result = await _userRepository.updateUser(
        userId: userId,
        username: username,
        phone: phone,
        email: email,
        address: address,
        avatar: avatar,
      );
      notifyListeners();
      return result;
    } catch (e) {
      throw Exception('Failed to update user: $e');
    }
  }

  Future<bool> deductBalance(String userId, double amount) async {
    final ok = await _userRepository.deductBalance(userId, amount);
    if (ok && _user != null && _user!.id == userId) {
      _user!.balance -= amount;
      notifyListeners();
    }
    return ok;
  }

  Future<bool> addBalance(String userId, double amount) async {
    final ok = await _userRepository.addBalance(userId, amount);
    if (ok && _user != null && _user!.id == userId) {
      _user!.balance += amount;
      notifyListeners();
    }
    return ok;
  }

  Future<Map<String, dynamic>> deleteUser(String userId) async {
    try {
      final result = await _userRepository.deleteUser(userId);
      notifyListeners();
      return result;
    } catch (e) {
      throw Exception('Failed to delete user: $e');
    }
  }
}
