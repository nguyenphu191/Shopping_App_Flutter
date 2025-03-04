import 'dart:convert';
import 'package:flutter_shopping_app/models/Address.dart';
import 'package:flutter_shopping_app/models/CartItem.dart';
import 'package:flutter_shopping_app/models/Order.dart';
import 'package:flutter_shopping_app/models/Product.dart';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = 'http://localhost:8000/api';
  // final String baseUrl = 'http://172.20.10.2:8000/api';
  // final String baseUrl = 'http://192.168.0.100:8000/api';
  // Future<Map<String, dynamic>> login(String username, String password) async {
  //   final url = Uri.parse('$baseUrl/users/login');
  //   print('$username, $password');
  //   final response = await http.post(
  //     url,
  //     body: jsonEncode({'username': username, 'password': password}),
  //     headers: <String, String>{
  //       'Content-Type': 'application/json; charset=UTF-8',
  //     },
  //   );

  //   if (response.statusCode == 200) {
  //     return jsonDecode(response.body);
  //   } else {
  //     throw Exception('Failed to login');
  //   }
  // }

  // Future<Map<String, dynamic>> register(String username, String role,
  //     String email, String phone, String password, Address address) async {
  //   final url = Uri.parse('$baseUrl/users/register');
  //   final response = await http.post(
  //     url,
  //     body: jsonEncode({
  //       'username': username,
  //       'role': role,
  //       'email': email,
  //       'phone': phone,
  //       'password': password,
  //       'address': address.toJson(),
  //     }),
  //     headers: <String, String>{
  //       'Content-Type': 'application/json; charset=UTF-8',
  //     },
  //   );

  //   if (response.statusCode == 200) {
  //     return jsonDecode(response.body);
  //   } else {
  //     throw Exception('Failed to register');
  //   }
  // }

  Future<Map<String, dynamic>> updateUser(
      {required String userId,
      String? username,
      String? phone,
      String? email,
      Map<String, dynamic>? address}) async {
    final url = Uri.parse('$baseUrl/users/update/$userId');
    final Map<String, dynamic> data = {
      if (username != null) 'username': username,
      if (phone != null) 'phone': phone,
      if (email != null) 'email': email,
      if (address != null) 'address': address,
    };

    final response = await http.patch(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data),
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      return {
        'status': 'success',
        'updatedUser': responseData['updatedUser'],
      };
    } else {
      throw Exception('Failed to update user');
    }
  }

  Future<Map<String, dynamic>> deleteUser(String userId) async {
    final url = Uri.parse('$baseUrl/users/delete/$userId');
    final response = await http.delete(url);
    if (response.statusCode == 200) {
      return {'status': 'success'};
    } else {
      throw Exception('Failed to delete user');
    }
  }

  // Future<void> addProduct(
  //     String sellerId, Map<String, dynamic> product, File img) async {
  //   final url = Uri.parse('$baseUrl/products/addproduct/$sellerId');
  //   try {
  //     final request = http.MultipartRequest('POST', url);

  //     // Thêm dữ liệu sản phẩm vào request
  //     request.fields['product'] = jsonEncode(product);

  //     // Thêm ảnh vào request
  //     request.files.add(
  //       await http.MultipartFile.fromPath('image', img.path),
  //     );

  //     final response = await request.send();
  //     if (response.statusCode == 200) {
  //       print("Thêm sản phẩm và upload ảnh thành công!");
  //     } else {
  //       print("Thêm sản phẩm thất bại: ${response.reasonPhrase}");
  //     }
  //   } catch (e) {
  //     print("Lỗi khi gọi API: $e");
  //   }
  // }
  Future<void> addProduct(String userId, Map<String, dynamic> product) async {
    final url = Uri.parse('$baseUrl/products/addproduct/$userId');
    try {
      final response = await http.post(
        url,
        body: jsonEncode(product),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      if (response.statusCode == 200) {
        print("Thêm sản phẩm thành công!");
      } else {
        print("Thêm sản phẩm thất bại: ${response.reasonPhrase}");
      }
    } catch (e) {
      print("Lỗi khi gọi API: $e");
    }
  }

  Future<List<ProductModel>> getUserProducts(String userId) async {
    final url = Uri.parse('$baseUrl/products/getproducts/$userId');
    List<ProductModel> productList = [];
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        data.forEach((element) {
          productList.add(ProductModel.fromJson(element));
        });
        print(productList.first);
        return productList;
      } else {
        print("Lấy danh sách sản phẩm thất bại: ${response.reasonPhrase}");
        return [];
      }
    } catch (e) {
      print("Lỗi khi gọi API: $e");
      return [];
    }
  }

  Future<List<ProductModel>> getPopularProducts() async {
    final url = Uri.parse('$baseUrl/products/getpopular');
    List<ProductModel> productList = [];
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        data.forEach((element) {
          productList.add(ProductModel.fromJson(element));
        });
        return productList;
      } else {
        return [];
      }
    } catch (e) {
      print("Lỗi khi gọi API: $e");
      return [];
    }
  }

  Future<Map<String, dynamic>> getAllProducts() async {
    final url = Uri.parse('$baseUrl/products/getproducts');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        List<ProductModel> products = (responseData['products'] as List)
            .map((item) => ProductModel.fromJson(item))
            .toList();
        return {
          'status': 'success',
          'products': products,
        };
      } else {
        return {'status': 'failed'};
      }
    } catch (e) {
      print("Lỗi khi gọi API: $e");
      return {'status': 'failed'};
    }
  }

  Future<ProductModel> getProduct(String id) async {
    final url = Uri.parse('$baseUrl/products/getproduct/$id');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return ProductModel.fromJson(data);
      } else {
        throw Exception("Lấy sản phẩm thất bại: ${response.reasonPhrase}");
      }
    } catch (e) {
      throw Exception("Lỗi khi gọi API: $e");
    }
  }

  Future<Map<String, dynamic>> updateProduct(
      String id, Map<String, dynamic> product) async {
    final url = Uri.parse('$baseUrl/products/updateproduct/$id');
    try {
      final response = await http.patch(
        url,
        body: jsonEncode(product),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      if (response.statusCode == 200) {
        return {'status': 'success'};
      } else {
        return {'status': 'failed'};
      }
    } catch (e) {
      return {'status': 'failed'};
    }
  }

  Future<Map<String, dynamic>> addToCart(
      String userId, String productID, int quantity) async {
    final url = Uri.parse('$baseUrl/carts/addtocart/$userId');
    try {
      final response = await http.post(
        url,
        body: jsonEncode({'productID': productID, 'quantity': quantity}),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      if (response.statusCode == 200) {
        return {'status': 'success'};
      } else {
        return {'status': 'failed'};
      }
    } catch (e) {
      print("Lỗi khi gọi API: $e");
      return {'status': 'failed'};
    }
  }

  Future<List<CartItem>> getCartItems(String userId) async {
    final url = Uri.parse('$baseUrl/carts/getcart/$userId');
    List<CartItem> cartList = [];
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        data.forEach((element) {
          cartList.add(CartItem.fromJson(element));
        });
        return cartList;
      } else {
        print("Lấy danh sách sản phẩm thất bại: ${response.reasonPhrase}");
        return [];
      }
    } catch (e) {
      print("Lỗi khi gọi API: $e");
      return [];
    }
  }

  Future<Map<String, dynamic>> updateCartItems(
      String cartiteamID, bool isAdd) async {
    final url = Uri.parse('$baseUrl/carts/updatecart/$cartiteamID');
    try {
      final response = await http.patch(
        url,
        body: jsonEncode({'isAdd': isAdd}),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      if (response.statusCode == 200) {
        return {'status': 'success'};
      } else {
        return {'status': 'failed'};
      }
    } catch (e) {
      print("Lỗi khi gọi API: $e");
      return {'status': 'failed'};
    }
  }

  Future<Map<String, dynamic>> deleteCartItem(String cartiteamID) async {
    final url = Uri.parse('$baseUrl/carts/deletecart/$cartiteamID');
    try {
      final response = await http.delete(url);
      if (response.statusCode == 200) {
        return {'status': 'success'};
      } else {
        return {'status': 'failed'};
      }
    } catch (e) {
      return {'status': 'success'};
    }
  }

  Future<Map<String, dynamic>> getInfor(List<String> cartItemList) async {
    final url = Uri.parse('$baseUrl/orders/getInfor');
    try {
      final response = await http.post(
        url,
        body: jsonEncode({'cartItemList': cartItemList}),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        List<CartItem> cartItems = (responseData['cartList'] as List)
            .map((item) => CartItem.fromJson(item))
            .toList();

        return {
          'status': 'success',
          'cartList': cartItems,
          'total': responseData['total'],
        };
      } else {
        return {'status': 'failed'};
      }
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
    final url = Uri.parse('$baseUrl/orders/create');
    try {
      final response = await http.post(
        url,
        body: jsonEncode({
          'cartItemList': cartItemList,
          'userID': userID,
          'methodPayment': methodPayment,
          'isPaymented': isPaymented,
          'reciever': reciever,
          'total': total,
          'phone': phone,
          'address': address,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      if (response.statusCode == 200) {
        return {'status': 'success'};
      } else {
        return {'status': 'failed'};
      }
    } catch (e) {
      return {'status': 'failed'};
    }
  }

  Future<List<OrderModel>> getUserOrder(String userID) async {
    final url = Uri.parse('$baseUrl/orders/get/$userID');
    List<OrderModel> orderList = [];
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body); // Lấy đối tượng chứa 'orders'
        final List<dynamic> ordersData = data['orders'];

        ordersData.forEach((element) {
          orderList.add(OrderModel.fromJson(element));
        });
        return orderList;
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }

  Future<Map<String, dynamic>> updateOrder(String id, String status) async {
    final url = Uri.parse('$baseUrl/orders/update/$id');
    try {
      final response = await http.patch(
        url,
        body: jsonEncode({'status': status}),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      if (response.statusCode == 200) {
        return {'status': 'success'};
      } else {
        return {'status': 'failed'};
      }
    } catch (e) {
      return {'status': 'failed'};
    }
  }
}
