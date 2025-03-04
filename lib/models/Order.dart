import 'package:flutter_shopping_app/models/CartItem.dart';

class OrderModel {
  late String id;
  late List<CartItem> cartList;
  late double total;
  late String status;
  late String methodPayment;
  late bool isPaymented;
  late String reciever;
  late String userID;
  late String address;
  late String phone;
  late bool rating;
  late String time;
  late String dateComplete;
  OrderModel(
      {required this.id,
      required this.cartList,
      required this.total,
      required this.status,
      required this.methodPayment,
      required this.isPaymented,
      required this.reciever,
      required this.userID,
      required this.address,
      required this.rating,
      required this.phone,
      required this.time,
      required this.dateComplete});
  OrderModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        cartList = (json['cartList'] as List<dynamic>)
            .map((e) => CartItem.fromJson(e))
            .toList(),
        total = (json['total'] is int)
            ? (json['total'] as int).toDouble()
            : (json['total'] as double),
        status = json['status'],
        methodPayment = json['methodPayment'],
        isPaymented = json['isPaymented'],
        reciever = json['reciever'],
        userID = json['userID'],
        address = json['address'],
        phone = json['phone'],
        rating = json['rating'],
        time = json['time'],
        dateComplete = json['dateComplete'];
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'cartList': cartList.map((e) => e.toJson()).toList(),
      'total': total,
      'status': status,
      'methodPayment': methodPayment,
      'isPaymented': isPaymented,
      'reciever': reciever,
      'userID': userID,
      'address': address,
      'phone': phone,
      'time': time,
      'rating': rating,
      'dateComplete': dateComplete
    };
  }
}
