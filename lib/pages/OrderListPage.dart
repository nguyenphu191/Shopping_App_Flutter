import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shopping_app/models/OrderModel.dart';
import 'package:flutter_shopping_app/models/User.dart';
import 'package:flutter_shopping_app/pages/home_page.dart';
import 'package:flutter_shopping_app/widgets/big_text.dart';
import 'package:flutter_shopping_app/widgets/small_text.dart';

class OrderListPage extends StatefulWidget {
  final User user;
  const OrderListPage({super.key, required this.user});

  @override
  State<OrderListPage> createState() => _OrderListPageState();
}

class _OrderListPageState extends State<OrderListPage> {
  @override
  Widget build(BuildContext context) {
    User user = widget.user;
    List<OrderModel> orderList = user.orderList;
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
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HomePage(
                                  user: user,
                                ),
                              ),
                            );
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
              top: 60,
              left: 20,
              right: 20,
              bottom: 10,
              child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListView.builder(
                      itemCount: orderList.length,
                      itemBuilder: (context, index) {
                        OrderModel order = orderList[index];
                        return InkWell(
                          onTap: () {},
                          child: Container(
                            height: 100,
                            width: 320,
                            margin: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.only(left: 10, top: 10),
                                  width: 220,
                                  color:
                                      const Color.fromARGB(255, 255, 255, 255),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Container(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                              ' ID: ' + order.id.toString())),
                                      Container(
                                        alignment: Alignment.centerLeft,
                                        child: SmallText('',
                                            text: 'Sản phẩm: ' +
                                                order.cartList[1].product.name
                                                    .toString() +
                                                "..."),
                                      ),
                                      Container(
                                        alignment: Alignment.centerLeft,
                                        child: Text('Tổng tiền: ' +
                                            order.total.toString()),
                                      ),
                                      Container(
                                        alignment: Alignment.centerLeft,
                                        child: Text('Ngày đặt: ' +
                                            order.date.toString()),
                                      ),
                                    ],
                                  ),
                                ),
                                (order.isDone == true)
                                    ? Container(
                                        width: 120,
                                        height: 80,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            border: Border.all(
                                                color: Color.fromARGB(
                                                    255, 4, 244, 56),
                                                width: 1)),
                                        padding: EdgeInsets.all(10),
                                        child:
                                            Center(child: Text('Đã xác nhận')),
                                      )
                                    : Container(
                                        width: 120,
                                        height: 80,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            border: Border.all(
                                                color: Color.fromARGB(
                                                    255, 251, 4, 4),
                                                width: 1)),
                                        child: Column(
                                          children: [
                                            Text('Chưa xác nhận'),
                                            TextButton(
                                                onPressed: (() {
                                                  order.setIsDone = true;
                                                  order.setDateComplete =
                                                      DateTime.now()
                                                          .toString()
                                                          .substring(0, 10);
                                                  Navigator.pushReplacement(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              OrderListPage(
                                                                user: user,
                                                              )));
                                                }),
                                                child: Container(
                                                    height: 30,
                                                    width: 80,
                                                    decoration: BoxDecoration(
                                                      color: Color.fromARGB(
                                                          255, 233, 192, 67),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                    ),
                                                    child: Center(
                                                        child:
                                                            Text('Xác nhận'))))
                                          ],
                                        ))
                              ],
                            ),
                          ),
                        );
                      })),
            ),
          ],
        ),
      ),
    );
  }
}
