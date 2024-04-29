import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shopping_app/widgets/big_text.dart';
import 'package:flutter_shopping_app/controller/AdminControl.dart' as control;
import 'package:get/get.dart';

class AdminPage extends StatelessWidget {
  const AdminPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController nameControl = new TextEditingController();
    TextEditingController priceControl = new TextEditingController();
    TextEditingController imageControl = new TextEditingController();
    TextEditingController desControl = new TextEditingController();
    TextEditingController addrControl = new TextEditingController();
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Positioned(
                left: 10,
                right: 10,
                top: 10,
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 233, 192, 67),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 20),
                        child: IconButton(
                          padding: EdgeInsets.all(10),
                          onPressed: () {
                            Navigator.pushNamed(context, '/');
                          },
                          icon: Icon(Icons.arrow_back_ios),
                        ),
                      ),
                      Row(
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 10),
                            child: Icon(
                              Icons.home,
                              color: Colors.black,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(right: 10),
                            child: Center(
                              child: BigText(
                                '',
                                text: "FuFu Admin Page",
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )),
            Positioned(
                top: 60,
                left: 10,
                right: 10,
                child: Container(
                    height: 430,
                    child: Column(children: [
                      Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(top: 10),
                        child: BigText(
                          '',
                          text: "Thêm Sản Phẩm",
                          size: 15,
                        ),
                      ),
                      InputBox(
                          label: "Tên sản phẩm: ", txtController: nameControl),
                      InputBox(
                          label: "Giá sản phẩm: ", txtController: priceControl),
                      InputBox(
                          label: "Hình ảnh: ", txtController: imageControl),
                      InputBox(label: "Mô tả: ", txtController: desControl),
                      InputBox(label: "Địa chỉ: ", txtController: addrControl),
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        child: ElevatedButton(
                          onPressed: () {
                            String name = nameControl.text.trim();
                            String price = priceControl.text.trim();
                            String image = imageControl.text.trim();
                            String des = desControl.text.trim();
                            String addr = addrControl.text.trim();
                            control.addProduct(name, price, image, des, addr);
                            Get.snackbar(
                                "Thông báo", "Thêm sản phẩm thành công");
                          },
                          child: Text("Thêm sản phẩm"),
                        ),
                      ),
                    ]))),
            Positioned(
                top: 480,
                left: 10,
                right: 10,
                child: Container(
                    height: 250,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 255, 255, 255),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(children: [
                      Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(top: 10),
                        child: BigText(
                          '',
                          text: "Lựa chọn khác",
                          size: 20,
                        ),
                      ),
                      Container(
                        width: 200,
                        margin: EdgeInsets.only(top: 10),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/admin/product');
                          },
                          child: Text("Quản lý sản phẩm"),
                        ),
                      ),
                      Container(
                        width: 200,
                        margin: EdgeInsets.only(top: 10),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/admin/user');
                          },
                          child: Text("Quản lý người dùng"),
                        ),
                      ),
                      Container(
                        width: 200,
                        margin: EdgeInsets.only(top: 10),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/admin/order');
                          },
                          child: Text("Quản lý đơn hàng"),
                        ),
                      ),
                    ]))),
          ],
        ),
      ),
    );
  }
}

Widget InputBox(
    {required String label, required TextEditingController txtController}) {
  return Column(
    children: [
      Container(
          margin: EdgeInsets.only(left: 20),
          alignment: Alignment.centerLeft,
          height: 20,
          child: Text(label)),
      Container(
        margin: EdgeInsets.only(left: 20, right: 20, bottom: 5),
        height: 35,
        padding: const EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: const Color.fromARGB(255, 2, 2, 2)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: TextField(
            controller: txtController,
            decoration: InputDecoration(
              border: InputBorder.none,
            ),
          ),
        ),
      ),
    ],
  );
}
