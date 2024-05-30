import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shopping_app/models/OrderModel.dart';
import 'package:flutter_shopping_app/widgets/big_text.dart';
import 'package:flutter_shopping_app/data/app_data.dart' as app_data;

class OrderMan extends StatelessWidget {
  const OrderMan({super.key});

  @override
  Widget build(BuildContext context) {
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
                            Navigator.pushNamed(context, '/admin');
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
            app_data.admin.orderList.length > 0
                ? Positioned(
                    left: 10,
                    right: 10,
                    bottom: 10,
                    top: 60,
                    child: Container(
                      width: double.maxFinite,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 228, 234, 234),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ListView.builder(
                        itemCount: app_data.admin.orderList.length,
                        itemBuilder: (context, index) {
                          OrderModel order = app_data.admin.orderList[index];
                          return Container(
                            width: 200,
                            height: 140,
                            margin: EdgeInsets.only(top: 10, bottom: 10),
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 252, 252, 252),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 80,
                                  height: 100,
                                  margin: EdgeInsets.only(left: 5),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(
                                      image: (order.cartList[1].product.img
                                                  .isNotEmpty &&
                                              File(order
                                                      .cartList[1].product.img)
                                                  .existsSync())
                                          ? FileImage(File(order
                                              .cartList[1]
                                              .product
                                              .img)) // Nếu đường dẫn hệ thống tồn tại
                                          : (order.cartList[1].product.img
                                                  .isNotEmpty)
                                              ? AssetImage(
                                                  order.cartList[1].product.img)
                                              : AssetImage('') as ImageProvider,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 150,
                                  height: 130,
                                  alignment: Alignment.centerLeft,
                                  padding: EdgeInsets.all(10),
                                  child: Column(
                                    children: [
                                      Text(
                                        order.cartList[1].product.name,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 13,
                                        ),
                                      ),
                                      Text(
                                        order.total.toString(),
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 13,
                                        ),
                                      ),
                                      Text(
                                        "đặt: ${order.date.toString()}",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 13,
                                        ),
                                      ),
                                      Text(
                                        order.isDone == true
                                            ? 'Đã giao'
                                            : 'Chưa giao',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 13,
                                        ),
                                      ),
                                      Text(
                                        "giao: ${order.dateComplete.toString()}",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 13,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: 1,
                                  decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 8, 8, 8),
                                  ),
                                ),
                                Container(
                                    width: 130,
                                    height: 130,
                                    margin: EdgeInsets.all(10),
                                    child: Column(
                                      children: [
                                        Text(
                                          "UserName: ${order.userName.toString()}",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 13,
                                          ),
                                        ),
                                        Text(
                                          "Người nhận: ${order.reciever.toString()}",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 13,
                                          ),
                                        ),
                                        Text(
                                          "Phone: ${order.phone.toString()}",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 13,
                                          ),
                                        ),
                                        Text(
                                          "ADR: ${order.address.toString()}",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 13,
                                          ),
                                        ),
                                      ],
                                    )),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  )
                : Container(
                    margin: EdgeInsets.only(top: 100),
                    child: Center(
                      child: Text('Danh sách trống'),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
