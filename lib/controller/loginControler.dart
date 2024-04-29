import 'package:flutter_shopping_app/data/app_data.dart' as app_data;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_shopping_app/models/User.dart';
import 'package:flutter_shopping_app/pages/home_page.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
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

void login(email, password) {
  bool ckemail = false;
  bool ckpassword = false;
  for (var i = 0; i < app_data.userList.length; i++) {
    if (app_data.userList[i].email == email) {
      ckemail = true;
      if (app_data.userList[i].password == password) {
        ckpassword = true;
      }
      break;
    }
  }
  if (email.isEmpty) {
    ShowMessage(
        context: Get.context!, title: "Nhập email", message: "Nhập email");
  } else if (password.isEmpty) {
    ShowMessage(
        context: Get.context!,
        title: "Nhập mật khẩu",
        message: "Nhập mật khẩu");
  } else if (email == "admin@123" && password == "123456") {
    showCupertinoDialog(
        context: Get.context!,
        builder: (context) {
          return CupertinoAlertDialog(
            title: Text("Đăng nhập thành công"),
            content: Text("Đăng nhập thành công"),
            actions: [
              CupertinoDialogAction(
                child: Text("OK"),
                onPressed: () {
                  Navigator.pushNamed(context, '/admin');
                },
              )
            ],
          );
        });
  } else if (!GetUtils.isEmail(email)) {
    ShowMessage(
        context: Get.context!,
        title: "Email không hợp lệ ",
        message: "Email không hợp lệ");
  } else if (ckemail == false) {
    ShowMessage(
        context: Get.context!,
        title: "Email chưa được đăng ký",
        message: "Email chưa được đăng ký");
  } else if (ckpassword == false) {
    ShowMessage(
        context: Get.context!, title: "Sai mật khẩu", message: "Sai mật khẩu");
  } else {
    for (int i = 0; i < app_data.userList.length; i++) {
      if (app_data.userList[i].email == email) {
        User _user = app_data.userList[i];
        showCupertinoDialog(
            context: Get.context!,
            builder: (context) {
              return CupertinoAlertDialog(
                title: Text("Đăng nhập thành công"),
                content: Text("Đăng nhập thành công"),
                actions: [
                  CupertinoDialogAction(
                    child: Text("OK"),
                    onPressed: () {
                      // Navigator.pushNamed(context, '/home');
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomePage(user: _user),
                        ),
                      );
                    },
                  )
                ],
              );
            });
      }
    }
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
                // Navigator.pushNamed(context, '/');
              },
            )
          ],
        );
      });
}
