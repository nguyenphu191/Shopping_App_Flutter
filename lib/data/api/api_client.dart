// import 'package:flutter_shopping_app/utils/app_constants.dart';
// import 'package:get/get.dart';
// import 'package:get/get_connect/connect.dart';

// class ApiClient extends GetConnect implements GetxService {
//   late String token;
//   late Map<String, String> _mainHeaders;
//   final String appBaseUrl;
//   ApiClient({required this.appBaseUrl}) {
//     baseUrl = appBaseUrl;
//     //gui yeu cau lay du lieu tu may chu trong 30s
//     timeout = Duration(seconds: 30);
//     token = AppConstants.TOKEN;
//     _mainHeaders = {
//       'Content-Type': 'application/json; charset=UTF-8',
//       'Authorization': 'Bearer $token',
//     };
//   }
//   void updateHeader(String token) {
//     _mainHeaders = {
//       'Content-Type': 'application/json; charset=UTF-8',
//       'Authorization': 'Bearer $token',
//     };
//   }

//   Future<Response> getData(
//     String uri,
//   ) async {
//     try {
//       Response response = await get(uri);
//       return response;
//     } catch (e) {
//       return Response(statusCode: 1, statusText: e.toString());
//     }
//   }

//   Future<Response> postData(String uri, dynamic body) async {
//     try {
//       Response response = await post(uri, body, headers: _mainHeaders);
//       return response;
//     } catch (e) {
//       print(e.toString());
//       return Response(statusCode: 1, statusText: e.toString());
//     }
//   }
// }
// // import 'package:dio/dio.dart';

// // class ApiClient {
// //    final Dio _dio = Dio();

// //     Future<Response> registerUser(Map<String, dynamic>? userData) async {
// //         try {
// //           Response response = await _dio.post(
// //               'https://api.loginradius.com/identity/v2/auth/register',  //ENDPONT URL
// //               data: userData, //REQUEST BODY
// //               queryParameters: {'apikey': 'YOUR_API_KEY'},  //QUERY PARAMETERS
// //               options: Options(headers: {'X-LoginRadius-Sott': 'YOUR_SOTT_KEY', //HEADERS
// //           }));
// //           //returns the successful json object
// //           return response.data;
// //         } on DioError catch (e) {
// //           //returns the error object if there is
// //           return e.response!.data;
// //         }
// //       }

// //      Future<Response> login(String email, String password) async {
// //         try {
// //           Response response = await _dio.post(
// //             'https://api.loginradius.com/identity/v2/auth/login',
// //             data: {
// //               'email': email,
// //               'password': password
// //             },
// //             queryParameters: {'apikey': 'YOUR_API_KEY'},
// //           );
// //           //returns the successful user data json object
// //           return response.data;
// //         } on DioError catch (e) {
// //           //returns the error object if any
// //           return e.response!.data;
// //         }
// //       }

// //     Future<Response> getUserProfileData(String accesstoken) async {
// //         try {
// //           Response response = await _dio.get(
// //             'https://api.loginradius.com/identity/v2/auth/account',
// //             queryParameters: {'apikey': 'YOUR_API_KEY'},
// //             options: Options(
// //               headers: {
// //                 'Authorization': 'Bearer ${YOUR_ACCESS_TOKEN}',
// //               },
// //             ),
// //           );
// //           return response.data;
// //         } on DioError catch (e) {
// //           return e.response!.data;
// //         }

// //     Future<Response> logout(String accessToken) async {
// //         try {
// //           Response response = await _dio.get(
// //             'https://api.loginradius.com/identity/v2/auth/access_token/InValidate',
// //             queryParameters: {'apikey': ApiSecret.apiKey},
// //             options: Options(
// //               headers: {'Authorization': 'Bearer $accessToken'},
// //             ),
// //           );
// //           return response.data;
// //         } on DioError catch (e) {
// //           return e.response!.data;
// //         }
// //       }
// // }