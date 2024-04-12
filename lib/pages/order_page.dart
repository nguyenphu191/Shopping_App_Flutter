import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shopping_app/models/OrderModel.dart';
import 'package:flutter_shopping_app/models/cart_item.dart';
import 'package:flutter_shopping_app/widgets/big_text.dart';
import 'package:flutter_shopping_app/data/app_data.dart' as app_data;
import 'package:flutter_shopping_app/widgets/small_text.dart';

class OrderPage extends StatelessWidget {
  const OrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController namecontroller = new TextEditingController();
    TextEditingController phonecontroller = new TextEditingController();
    TextEditingController addresscontroller = new TextEditingController();
    double total = 0;
    for (var i = 0; i < app_data.cartList.length; i++) {
      total += app_data.cartList[i].product.price;
    }
    total += 20000;
    void order() {
      if (namecontroller.text.isEmpty) {
        ShowMessage(
            context: context,
            title: "Nhập tên người nhận",
            message: "Nhập tên người nhận");
      } else if (addresscontroller.text.isEmpty) {
        ShowMessage(
            context: context, title: "Nhập địa chỉ", message: "Nhập địa chỉ");
      } else if (phonecontroller.text.isEmpty) {
        ShowMessage(
            context: context,
            title: "Nhập số điện thoại",
            message: "Nhập số điện thoại");
      } else {
        OrderModel orderModel = OrderModel(id: (app_data.orderList.length+1).toString(),
            cartList: app_data.cartList, total: total, isDone: false);
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
                      app_data.cartList.clear();
                      Navigator.pop(context);
                      Navigator.pushNamed(context, '/');
                    },
                  )
                ],
              );
            });
      }
    }

    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Stack(
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
                              Navigator.pop(context);
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
                                  text: "FuFu",
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
                bottom: 0,
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: AssetImage('assets/image/background2.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                  top: 65,
                  left: 20,
                  right: 20,
                  child: Container(
                    height: 150,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        image: AssetImage('assets/image/shipper.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  )),
              Positioned(
                  top: 220,
                  left: 20,
                  right: 20,
                  bottom: 10,
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white.withOpacity(0.7),
                    ),
                    child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Column(
                        children: [
                          Container(
                            height: 30,
                            margin: EdgeInsets.all(10),
                            child: BigText(
                              '',
                              text: "Thông tin đơn hàng",
                            ),
                          ),
                          Container(
                            height: 30,
                            margin: EdgeInsets.only(
                                left: 20, right: 20, bottom: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SmallText('', text: 'Sản phẩm'),
                                SmallText('', text: 'Số lượng'),
                                SmallText('', text: 'Giá'),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                                left: 10, right: 10, bottom: 10),
                            height: 120,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                            ),
                            child: ListView.builder(
                              itemCount: app_data.cartList.length,
                              itemBuilder: (context, index) {
                                CartItem item = app_data.cartList[index];
                                return Container(
                                  margin: EdgeInsets.only(
                                      left: 10, right: 10, top: 10),
                                  height: 30,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Color.fromARGB(255, 255, 254, 254),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(left: 10),
                                        child: SmallText(
                                          '',
                                          text: item.product.name,
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(right: 10),
                                        child: SmallText(
                                          '',
                                          text: item.quantity.toString(),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(right: 10),
                                        child: SmallText(
                                          '',
                                          text: item.product.price.toString(),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                          Container(
                            height: 30,
                            margin: EdgeInsets.only(
                                left: 20, right: 20, bottom: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Tổng cộng',
                                ),
                                Text(total.toString()),
                              ],
                            ),
                          ),
                          InputBox(
                              label: "Tên người nhận",
                              txtController: namecontroller),
                          InputBox(
                              label: "Số điện thoại",
                              txtController: phonecontroller),
                          InputBox(
                              label: "Địa chỉ",
                              txtController: addresscontroller),
                          Container(
                              alignment: Alignment.center,
                              height: 40,
                              width: 120,
                              margin: EdgeInsets.only(top: 10),
                              decoration: BoxDecoration(
                                color: Color.fromARGB(255, 233, 192, 67),
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.5),
                                    spreadRadius: 3,
                                    blurRadius: 6,
                                    offset: Offset(0, 6),
                                  ),
                                ],
                              ),
                              child: TextButton(
                                onPressed: () {
                                  order();
                                },
                                child: BigText(
                                  '',
                                  text: "Đặt hàng",
                                ),
                              ))
                        ],
                      ),
                    ),
                  )),
            ],
          ),
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
        margin: EdgeInsets.only(left: 20, right: 20, bottom: 10),
        height: 40,
        padding: const EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: const Color.fromARGB(255, 2, 2, 2)),
        ),
        child: TextField(
          controller: txtController,
          decoration: InputDecoration(
            border: InputBorder.none,
          ),
        ),
      ),
    ],
  );
}

// checkPhone(TextEditingController txtController) {
//   if (txtController.text.length != 10) {
//     return false;
//   }
//   for (var i = 0; i < txtController.text.length; i++) {
//     if (txtController.text.codeUnitAt(i) <= '0'.codeUnitAt(i) &&
//         txtController.text.codeUnitAt(i) >= '9'.codeUnitAt(i)) {
//       return false;
//     }
//   }
//   return true;
// }

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
