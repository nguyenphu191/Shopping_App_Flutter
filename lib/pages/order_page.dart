import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shopping_app/models/User.dart';
import 'package:flutter_shopping_app/models/cart_item.dart';
import 'package:flutter_shopping_app/widgets/big_text.dart';
import 'package:flutter_shopping_app/widgets/small_text.dart';
import 'package:flutter_shopping_app/controller/OrderControl.dart'
    as OrderControl;

class OrderPage extends StatefulWidget {
  final User user;
  const OrderPage({super.key, required this.user});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  @override
  Widget build(BuildContext context) {
    User user = widget.user;
    TextEditingController namecontroller = new TextEditingController();
    TextEditingController phonecontroller = new TextEditingController();
    TextEditingController addresscontroller = new TextEditingController();
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Stack(
            children: [
              Positioned(
                  left: 0,
                  right: 0,
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
                              itemCount: user.cartList.length - 1,
                              itemBuilder: (context, index) {
                                CartItem item = user.cartList[index + 1];
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
                                          text: (item.product.price *
                                                  item.quantity)
                                              .toString(),
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
                                Text(OrderControl.getTotal(user).toString()),
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
                                  String ReName = namecontroller.text.trim();
                                  String Address =
                                      addresscontroller.text.trim();
                                  String phone = phonecontroller.text.trim();

                                  OrderControl.order(
                                      user, ReName, Address, phone, context);
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
