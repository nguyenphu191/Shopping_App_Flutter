import 'package:flutter/cupertino.dart';
import 'package:flutter_shopping_app/models/product.dart';
import 'package:flutter_shopping_app/data/app_data.dart' as app_data;
import 'package:get/get.dart';

void addProduct(String name, String gia, String img, String des, String addr) {
  if (name.isEmpty) {
    ShowMessage(
        context: Get.context!,
        title: "Nhập tên sản phẩm",
        message: "Nhập tên sản phẩm");
  } else if (checkPrice(gia) == false) {
    ShowMessage(
        context: Get.context!,
        title: "Nhập giá sản phẩm",
        message: "Nhập giá sản phẩm");
  } else if (img.isEmpty) {
    ShowMessage(
        context: Get.context!,
        title: "Nhập ảnh sản phẩm",
        message: "Nhập ảnh sản phẩm");
  } else if (des.isEmpty) {
    ShowMessage(
        context: Get.context!,
        title: "Nhập mô tả sản phẩm",
        message: "Nhập mô tả sản phẩm");
  } else if (addr.isEmpty) {
    ShowMessage(
        context: Get.context!, title: "Nhập địa chỉ", message: "Nhập địa chỉ");
  } else {
    ProductModel product = ProductModel(
        id: app_data.productList.length + 1,
        name: name,
        price: double.parse(gia),
        description: des,
        img: img,
        location: addr,
        sold: 0);
    app_data.productList.add(product);
    ShowMessage(
        context: Get.context!,
        title: "Success",
        message: "Thêm sản phẩm thành công");
  }
}

checkPrice(String price) {
  if (price.isEmpty) {
    return false;
  }
  final double? value = double.tryParse(price);
  return value != null;
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
