import 'package:flutter_shopping_app/core/network/http_client.dart';
import 'package:flutter_shopping_app/core/constants/api_endpoints.dart';
import 'package:flutter_shopping_app/models/review.dart';

class ReviewRepository {
  final AppHttpClient _client;
  ReviewRepository(this._client);

  Future<Review> addReview(
      String productId,
      String userId,
      String orderId,
      double rate,
      String content) async {
    try {
      final data = await _client.post(
        '${ApiEndpoints.addReview}/$productId',
        {
          'userId': userId,
          'rate': rate,
          'content': content,
          'orderId': orderId,
        },
      );
      return Review.fromJson(data as Map<String, dynamic>);
    } catch (e) {
      throw Exception('Failed to add review: $e');
    }
  }

  Future<List<Review>> getReviews(String productId) async {
    try {
      final data =
          await _client.get('${ApiEndpoints.getReviews}/$productId');
      final List<dynamic> list = data as List<dynamic>;
      return list.map((element) => Review.fromJson(element)).toList();
    } catch (e) {
      return [];
    }
  }

  Future<Review> getReviewById(String reviewId) async {
    try {
      final data =
          await _client.get('${ApiEndpoints.getReview}/$reviewId');
      return Review.fromJson(data as Map<String, dynamic>);
    } catch (e) {
      throw Exception('Failed to get review: $e');
    }
  }
}
