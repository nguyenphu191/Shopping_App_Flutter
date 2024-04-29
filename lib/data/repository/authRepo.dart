// import 'package:flutter_shopping_app/data/api/api_client.dart';
// import 'package:flutter_shopping_app/models/signupBody.dart';
// import 'package:flutter_shopping_app/utils/app_constants.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:get/get.dart';

// class AuthRepo {
//   final ApiClient apiClient;
//   final SharedPreferences sharedPreferences;
//   AuthRepo({required this.apiClient, required this.sharedPreferences});
//   Future<Response> registration(SignupBody signupBody) async {
//     return await apiClient.postData(
//         AppConstants.REGISTER_URI, signupBody.toJson());
//   }

//   SaveUserToken(String token) async {
//     apiClient.token = token;
//     apiClient.updateHeader(token);
//     return await sharedPreferences.setString(AppConstants.TOKEN, token);
//   }
// }
