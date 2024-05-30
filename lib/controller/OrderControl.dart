import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shopping_app/models/OrderModel.dart';
import 'package:flutter_shopping_app/models/User.dart';
import 'package:flutter_shopping_app/data/app_data.dart' as app_data;
import 'package:flutter_shopping_app/pages/OrderListPage.dart';

double getTotal(User user) {
  double _total = 0;
  for (var i = 1; i < user.cartList.length; i++) {
    _total += user.cartList[i].product.price * user.cartList[i].quantity;
  }
  _total += 20000;
  return _total;
}

void order(User user, String ReName, String Address, String phone, context) {
  if (user.cartList.length <= 1) {
    ShowMessage(
        context: context,
        title: "Chưa có sản phẩm",
        message: "Chưa có sản phẩm");
  } else if (ReName.isEmpty) {
    ShowMessage(
        context: context,
        title: "Nhập tên người nhận",
        message: "Nhập tên người nhận");
  } else if (Address.isEmpty) {
    ShowMessage(
        context: context, title: "Nhập địa chỉ", message: "Nhập địa chỉ");
  } else if (phone.isEmpty) {
    ShowMessage(
        context: context,
        title: "Nhập số điện thoại",
        message: "Nhập số điện thoại");
  } else if (checkPhone(phone) == false) {
    ShowMessage(
        context: context,
        title: "Số điện thoại không hợp lệ",
        message: "Số điện thoại không hợp lệ");
  } else {
    OrderModel orderModel = OrderModel(
        id: (user.orderList.length + 1).toString(),
        cartList: user.cartList,
        total: getTotal(user),
        isDone: false,
        reciever: ReName,
        userName: user.username.toString(),
        address: Address,
        phone: phone,
        dateComplete: "",
        date: DateTime.now().toString().substring(0, 10));
    user.orderList.add(orderModel);
    app_data.orderList.add(orderModel);

    showCupertinoDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: Text("Success"),
            content: Text("Đặt hàng thành công"),
            actions: [
              CupertinoDialogAction(
                child: Text("OK"),
                onPressed: () {
                  for (var i = 1; i < user.cartList.length; i++) {
                    user.cartList[i].product.setSold =
                        user.cartList[i].product.sold +
                            user.cartList[i].quantity;
                  }
                  user.reCart();
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => OrderListPage(
                                user: user,
                              )));
                },
              )
            ],
          );
        });
  }
}

checkPhone(String phone) {
  if (phone.length != 10) {
    return false;
  }
  for (var i = 0; i < 10; i++) {
    if (int.parse(phone[i]) < 0 && int.parse(phone[i]) > 9) {
      return false;
    }
  }
  return true;
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
