import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_shopping_app/models/User.dart';
import 'package:flutter_shopping_app/models/cart_item.dart';
import 'package:flutter_shopping_app/pages/detail_product.dart';
import 'package:flutter_shopping_app/pages/order_page.dart';
// import 'package:flutter_shopping_app/providers/cart_provider.dart';
import 'package:flutter_shopping_app/widgets/big_text.dart';
import 'package:get/get.dart';
// import 'package:get/get.dart';
// import 'package:provider/provider.dart';

class CartPage extends StatefulWidget {
  final User user;
  const CartPage({super.key, required this.user});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    User user = widget.user;
    double tong1 = 0;
    for (int i = 1; i < user.cartList.length; i++) {
      tong1 += user.cartList[i].product.price * user.cartList[i].quantity;
    }
    double ship;
    user.cartList.length > 1 ? ship = 20000 : ship = 0;
    double tong2 = tong1 + ship;
    // CartItem cartItem=CartItem(product: product, quantity: 1);
    return SafeArea(
      child: Scaffold(
        body: Stack(
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
            // SizedBox(
            //   height: 10,
            // ),
            user.cartList.length > 1
                ? Positioned(
                    left: 10,
                    right: 10,
                    bottom: 10,
                    top: 60,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 228, 234, 234),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ListView.builder(
                        itemCount: user.cartList.length - 1,
                        itemBuilder: (context, index) {
                          CartItem item = user.cartList[index + 1];
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DetailProduct(
                                            product: item.product,
                                            user: widget.user,
                                          )));
                            },
                            child: Container(
                              width: 200,
                              height: 100,
                              margin: EdgeInsets.only(top: 10, bottom: 10),
                              decoration: BoxDecoration(
                                color: Color.fromARGB(255, 252, 252, 252),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: 100,
                                    height: 100,
                                    margin: EdgeInsets.only(left: 10),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      image: DecorationImage(
                                        image: (item.product.img.isNotEmpty &&
                                                File(item.product.img)
                                                    .existsSync())
                                            ? FileImage(File(item.product
                                                .img)) // Nếu đường dẫn hệ thống tồn tại
                                            : (item.product.img.isNotEmpty)
                                                ? AssetImage(item.product.img)
                                                : AssetImage('')
                                                    as ImageProvider,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 15, top: 10),
                                    child: Column(
                                      children: [
                                        Text(
                                          item.product.name,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 15,
                                          ),
                                        ),
                                        Text(
                                          '${item.product.price} VND',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 15,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Column(
                                    children: [
                                      Container(
                                        height: 40,
                                        margin:
                                            EdgeInsets.only(top: 10, right: 10),
                                        child: Row(
                                          children: [
                                            IconButton(
                                              onPressed: () {
                                                item.quantity--;
                                                if (item.quantity == 0) {
                                                  user.cartList.remove(item);
                                                }

                                                Navigator.pop(context);
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        CartPage(
                                                      user: widget.user,
                                                    ),
                                                  ),
                                                );
                                              },
                                              icon: Icon(Icons.remove),
                                            ),
                                            Text(
                                              item.quantity.toString(),
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 15,
                                              ),
                                            ),
                                            IconButton(
                                              onPressed: () {
                                                item.quantity++;

                                                Navigator.pop(context);
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        CartPage(
                                                      user: widget.user,
                                                    ),
                                                  ),
                                                );
                                              },
                                              icon: Icon(Icons.add),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                          height: 30,
                                          margin: EdgeInsets.only(
                                              bottom: 20, right: 10),
                                          child: IconButton(
                                            onPressed: () {
                                              user.cartList.remove(item);
                                              Navigator.pop(context);
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      CartPage(
                                                    user: widget.user,
                                                  ),
                                                ),
                                              );
                                            },
                                            icon: Icon(Icons.delete),
                                          )),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  )
                //Xu ly khi gio hang rong
                : Container(
                    margin: EdgeInsets.only(top: 100),
                    child: Center(
                      child: Text('Giỏ hàng trống'),
                    ),
                  ),
            //Khung tổng tiền
            Positioned(
              left: 10,
              right: 10,
              bottom: 0,
              child: Container(
                margin: EdgeInsets.only(left: 10, right: 10, bottom: 5),
                height: 150,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 10),
                            child: Text(
                              'Tổng tiền sản phẩm:',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(right: 10),
                            child: Text(
                              '$tong1 VND',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 10),
                            child: Text(
                              'Phí vận chuyển:',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(right: 10),
                            child: Text(
                              '$ship VND',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 10),
                            child: Text(
                              'Số tiền thanh toán:',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(right: 10),
                            child: Text(
                              '$tong2 VND',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Center(
                        child: InkWell(
                      onTap: () {
                        if (user.cartList.length > 1) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => OrderPage(
                                user: widget.user,
                              ),
                            ),
                          );
                        } else {
                          Get.snackbar("Chưa có sản phẩm", "Chưa có sản phẩm");
                        }
                      },
                      child: Container(
                        margin: EdgeInsets.only(top: 15),
                        padding: EdgeInsets.only(
                          left: 15,
                          right: 10,
                          top: 6,
                        ),
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
                            ]),
                        height: 40,
                        width: 120,
                        child: BigText('', text: 'Đặt hàng'),
                      ),
                    ))
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
