import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_shopping_app/models/User.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

// class RegisterController extends GetxController {
//   TextEditingController username = TextEditingController();
//   TextEditingController email = TextEditingController();
//   TextEditingController password = TextEditingController();

//   String _mes = "";
//   // Dio _dio = Dio();

//   Future<void> submit() async {
//     User user = User(
//         username: username.text.trim(),
//         email: email.text.trim(),
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
//       await ShowMessage(
//           context: Get.context!, title: "Error", message: "Error");
//     }
//   }

//   bool ValidateUser(User user) {
//     if (user.username == null || user.email == null || user.password == null) {
//       _mes = "username or email or password cannot empty";
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
//     if (user.email!.isEmpty) {
//       _mes = "email cannot empty";
//       return false;
//     }
//     return true;
//   }

//   Future<bool> authenticateUser(User user) async {
//     Dio dio = Dio(BaseOptions(connectTimeout: Duration(seconds: 30)));
//     String _apiUrl = "https://dummyjson.com/auth/register";
//     try {
//       Map<String, dynamic> requestData = {
//         'username': user.username,
//         'email': user.email,
//         'password': user.password
//       };
//       final response = await dio.post(_apiUrl, data: requestData);
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
//                   Navigator.pushNamed(context, '/');
//                 },
//               )
//             ],
//           );
//         });
//   }
// }
import 'package:flutter_shopping_app/data/app_data.dart' as app_data;

void registration(
    TextEditingController emailController,
    TextEditingController passwordController,
    TextEditingController usernameController) {
  String username = usernameController.text.trim();
  String email = emailController.text.trim();
  String password = passwordController.text.trim();
  bool ckemail = true;
  for (var i = 0; i < app_data.userList.length; i++) {
    if (app_data.userList[i].email == email) {
      ckemail = false;
      break;
    }
  }
  if (username.isEmpty) {
    ShowMessage(
        context: Get.context!,
        title: "Nhập tên người dùng",
        message: "Nhập tên người dùng");
  } else if (email.isEmpty) {
    ShowMessage(
        context: Get.context!, title: "Nhập email", message: "Nhập email");
  } else if (!GetUtils.isEmail(email)) {
    ShowMessage(
        context: Get.context!,
        title: "Email không hợp lệ",
        message: "Email không hợp lệ");
  } else if (password.isEmpty) {
    ShowMessage(
        context: Get.context!,
        title: "Nhập mật khẩu",
        message: "Nhập mật khẩu");
  } else if (ckemail == false) {
    ShowMessage(
        context: Get.context!,
        title: "Email đã được sử dụng",
        message: "Email đã được sử dụng");
  } else {
    User user = new User(
      username: username,
      email: email,
      password: password,
      phone: "",
      city: "",
      productList: [],
      cartList: [app_data.it0],
      orderList: [],
    );
    app_data.userList.add(user);
    showCupertinoDialog(
        context: Get.context!,
        builder: (context) {
          return CupertinoAlertDialog(
            title: Text("Success"),
            content: Text("Success"),
            actions: [
              CupertinoDialogAction(
                child: Text("OK"),
                onPressed: () {
                  Navigator.pushNamed(context, '/login');
                },
              )
            ],
          );
        });
  }
}

ShowMessage(
    {required BuildContext context,
    required String title,
    required String message}) {
  showCupertinoDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            CupertinoDialogAction(
              child: Text("OK"),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        );
      });
}
