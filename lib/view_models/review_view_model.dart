import 'package:flutter/material.dart';
import 'package:flutter_shopping_app/models/review.dart';
import 'package:flutter_shopping_app/repositories/review_repository.dart';

class ReviewViewModel with ChangeNotifier {
  final ReviewRepository _reviewRepository;
  ReviewViewModel(this._reviewRepository);

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
    setLoading(true);
    try {
      final review = await _reviewRepository.addReview(
          productId, userId, orderId, rate, content);
      _reviews.add(review);
      setLoading(false);
      notifyListeners();
    } catch (e) {
    } finally {
      setLoading(false);
    }
  }

  Future<void> getReviews(String productId) async {
    setLoading(true);
    try {
      final reviewList = await _reviewRepository.getReviews(productId);
      _reviews = reviewList;
      setLoading(false);
      notifyListeners();
    } catch (e) {
    } finally {
      setLoading(false);
    }
  }

  Future<void> getReviewById(String reviewId) async {
    setLoading(true);
    try {
      final review = await _reviewRepository.getReviewById(reviewId);
      _review = review;
      setLoading(false);
      notifyListeners();
    } catch (e) {
    } finally {
      setLoading(false);
    }
  }
}
