import 'package:flutter_shopping_app/core/network/http_client.dart';
import 'package:flutter_shopping_app/core/constants/api_endpoints.dart';
import 'package:flutter_shopping_app/models/cart_item.dart';
import 'package:flutter_shopping_app/models/order.dart';

class OrderRepository {
  final AppHttpClient _client;
  OrderRepository(this._client);

  Future<Map<String, dynamic>> getInfor(List<String> cartItemList) async {
    try {
      final data = await _client.post(
        ApiEndpoints.getInfor,
        {'cartItemList': cartItemList},
      );
      final Map<String, dynamic> responseData = data as Map<String, dynamic>;
      final List<CartItem> cartItems =
          (responseData['cartList'] as List)
              .map((item) => CartItem.fromJson(item))
              .toList();
      return {
        'status': 'success',
        'cartList': cartItems,
        'total': (responseData['total'] ?? 0).toDouble(),
      };
    } catch (e) {
      return {'status': 'failed'};
    }
  }

  Future<Map<String, dynamic>> createOrder(
      List<String> cartItemList,
      String userID,
      String methodPayment,
      bool isPaymented,
      String reciever,
      String phone,
      double total,
      String address) async {
    try {
      await _client.post(
        ApiEndpoints.createOrder,
        {
          'cartItemList': cartItemList,
          'userID': userID,
          'methodPayment': methodPayment,
          'isPaymented': isPaymented,
          'reciever': reciever,
          'total': total,
          'phone': phone,
          'address': address,
        },
      );
      return {'status': 'success'};
    } catch (e) {
      return {'status': 'failed'};
    }
  }

  Future<List<OrderModel>> getUserOrder(String userID) async {
    try {
      final data =
          await _client.get('${ApiEndpoints.getOrder}/$userID');
      final Map<String, dynamic> responseData = data as Map<String, dynamic>;
      final List<dynamic> ordersData = responseData['orders'];
      return ordersData
          .map((element) => OrderModel.fromJson(element))
          .toList();
    } catch (e) {
      return [];
    }
  }

  Future<Map<String, dynamic>> updateOrder(String id, String status) async {
    try {
      await _client.patch(
        '${ApiEndpoints.updateOrder}/$id',
        {'status': status},
      );
      return {'status': 'success'};
    } catch (e) {
      return {'status': 'failed'};
    }
  }

  Future<List<OrderModel>> getSellerOrders(String sellerId) async {
    try {
      final data = await _client.get('${ApiEndpoints.getSellerOrders}/$sellerId');
      final Map<String, dynamic> responseData = data as Map<String, dynamic>;
      final List<dynamic> ordersData = responseData['orders'];
      return ordersData.map((e) => OrderModel.fromJson(e)).toList();
    } catch (e) {
      return [];
    }
  }

  Future<Map<String, dynamic>> updateOrderBySeller(String id, String status) async {
    try {
      await _client.patch(
        '${ApiEndpoints.updateOrderBySeller}/$id',
        {'status': status},
      );
      return {'status': 'success'};
    } catch (e) {
      return {'status': 'failed'};
    }
  }

  Future<OrderModel?> getOrderById(String id) async {
    try {
      final data = await _client.get('${ApiEndpoints.getOrderById}/$id');
      final Map<String, dynamic> responseData = data as Map<String, dynamic>;
      return OrderModel.fromJson(responseData['order']);
    } catch (e) {
      return null;
    }
  }
}
