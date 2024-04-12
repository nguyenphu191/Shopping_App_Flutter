// import 'dart:js';

// import 'package:dio/dio.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:flutter_shopping_app/models/User.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:get/get_state_manager/src/simple/get_controllers.dart';

// class LoginController extends GetxController {
//   TextEditingController username = TextEditingController();
//   TextEditingController password = TextEditingController();

//   String _mes = "";
//   // Dio _dio = Dio();

//   Future<void> submit() async {
//     User user = User(
//         username: username.text.trim(),
//         email: "",
//         city: "",
//         phone: "",
//         password: password.text.trim());
//     bool validateResult = ValidateUser(user);
//     if (validateResult) {
//       bool serverResponse = await authenticateUser(user);
//       if (serverResponse) {
//         await ShowMessage(
//             context: Get.context!, title: "Success!", message: "Success!");
//       } else {
//         await ShowMessage(
//             context: Get.context!, title: "Error!", message: "Error!");
//       }
//     } else {
//       await ShowMessage(context: Get.context!, title: "Error", message: _mes);
//     }
//   }

//   bool ValidateUser(User user) {
//     if (user.username == null || user.password == null) {
//       _mes = "username or password cannot empty";
//       return false;
//     }
//     if (user.username!.isEmpty) {
//       _mes = "username cannot empty";
//       return false;
//     }
//     if (user.password!.isEmpty) {
//       _mes = "password cannot empty";
//       return false;
//     }
//     return true;
//   }

//   Future<bool> authenticateUser(User user) async {
//     Dio dio = Dio(BaseOptions(connectTimeout: Duration(seconds: 30)));
//     String _apiUrl = "http://localhost:3000/user";
//     try {
//       Map<String, dynamic> requestData = {
//         'username': user.username,
//         'password': user.password
//       };
//       final response = await dio.get(_apiUrl, data: requestData);
//       if (response.statusCode == 200) {
//         return true;
//       } else {
//         return false;
//       }
//     } catch (e) {
//       return false;
//     }
//   }

//   ShowMessage(
//       {required BuildContext context,
//       required String title,
//       required String message}) {
//     showCupertinoDialog(
//         context: context,
//         builder: (context) {
//           return CupertinoAlertDialog(
//             title: Text(title),
//             content: Text(message),
//             actions: [
//               CupertinoDialogAction(
//                 child: Text("OK"),
//                 onPressed: () {
//                   Navigator.pop(context);
//                   // Navigator.pushNamed(context, '/');
//                 },
//               )
//             ],
//           );
//         });
//   }
// }
