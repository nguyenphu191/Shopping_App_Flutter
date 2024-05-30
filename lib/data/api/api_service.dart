// import 'dart:convert';

// import 'package:flutter_shopping_app/data/api/ApiConst.dart';
// import 'package:flutter_shopping_app/models/User.dart';
// import 'package:http/http.dart' as http;

// class ApiService {
//   Future<List<User>?> getUsers() async {
//     try {
//       var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.usersEndpoint);
//       var response = await http.get(url);
//       if (response.statusCode == 200) {
//         List<User> _model = userFromJson(response.body);
//       }
//     } catch (e) {
//       log(e.toString());
//     }
//   }
// }
