import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shopping_app/pages/profile.dart';
import 'package:get/get.dart';

void editName(TextEditingController usernameController, user, context) {
  String username = usernameController.text.trim();
  if (username.isEmpty) {
    ShowMessage(
        context: Get.context!,
        title: "Nhập tên người dùng",
        message: "Nhập tên người dùng");
  } else {
    user.setName = username;
    Navigator.pop(context);
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => Profile(user: user)));
  }
}

void editPhone(TextEditingController phoneController, user, context) {
  String phone = phoneController.text.trim();
  if (phone.isEmpty) {
    ShowMessage(
        context: Get.context!,
        title: "Nhập số điện thoại",
        message: "Nhập số điện thoại");
  } else {
    user.setPhone = phone;
    Navigator.pop(context);
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => Profile(user: user)));
  }
}

void editEmail(TextEditingController emailController, user, context) {
  String email = emailController.text.trim();
  if (email.isEmpty) {
    ShowMessage(
        context: Get.context!, title: "Nhập email", message: "Nhập email");
  } else if (!GetUtils.isEmail(email)) {
    ShowMessage(
        context: Get.context!,
        title: "Email không hợp lệ",
        message: "Email không hợp lệ");
  } else {
    user.setEmail = email;
    Navigator.pop(context);
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => Profile(user: user)));
  }
}

void editCity(TextEditingController cityController, user, context) {
  String city = cityController.text.trim();
  if (city.isEmpty) {
    ShowMessage(
        context: Get.context!, title: "Nhập địa chỉ", message: "Nhập địa chỉ");
  } else {
    user.setCity = city;
    Navigator.pop(context);
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => Profile(user: user)));
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
