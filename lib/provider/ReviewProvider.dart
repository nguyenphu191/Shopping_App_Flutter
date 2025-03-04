import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_shopping_app/models/Review.dart';
import 'package:flutter_shopping_app/models/User.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_shopping_app/utils/url.dart' as url;

class ReviewProvider with ChangeNotifier {
  final String baseUrl = url.baseUrl;
  List<Review> _reviews = [];

  Review? _review;
  bool _isLoading = false;

  List<Review> get reviews => _reviews;
  Review? get review => _review;
  bool get isLoading => _isLoading;

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<void> addReview(String productId, String userId, String orderId,
      double rate, String content) async {
    final url = Uri.parse('$baseUrl/reviews/addreview/$productId');
    setLoading(true);
    try {
      final response = await http.post(
        url,
        body: jsonEncode({
          'userId': userId,
          'rate': rate,
          'content': content,
          'orderId': orderId,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        Review review = Review.fromJson(data);
        _reviews.add(review);
        setLoading(false);
        notifyListeners();
      } else {
        print("${response.reasonPhrase}");
      }
    } catch (e) {
      print("Lỗi khi gọi API: $e");
    } finally {
      setLoading(false);
    }
  }

  Future<void> getReviews(String productId) async {
    setLoading(true);
    final url = Uri.parse('$baseUrl/reviews/getreviews/$productId');
    List<Review> reviewList = [];
    List<User> userList = [];
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        data.forEach((element) {
          Review rv = Review.fromJson(element);
          reviewList.add(rv);
        });
        _reviews = reviewList;
        setLoading(false);
        notifyListeners();
      } else {
        print("Lấy danh sách đánh giá thất bại: ${response.reasonPhrase}");
      }
    } catch (e) {
      print("Lỗi khi gọi API: $e");
    } finally {
      setLoading(false);
    }
  }

  Future<void> getReviewById(String reviewId) async {
    setLoading(true);
    final url = Uri.parse('$baseUrl/reviews/getreview/$reviewId');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        _review = Review.fromJson(data);
        setLoading(false);
        notifyListeners();
      } else {
        print("Lấy đánh giá thất bại: ${response.reasonPhrase}");
      }
    } catch (e) {
      print("Lỗi khi gọi API: $e");
    } finally {
      setLoading(false);
    }
  }
}
