import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_shopping_app/models/User.dart';
import 'package:flutter_shopping_app/pages/OrderListPage.dart';
import 'package:flutter_shopping_app/pages/cart_page.dart';
import 'package:flutter_shopping_app/pages/home_body_page.dart';
import 'package:flutter_shopping_app/pages/profile.dart';
import 'package:flutter_shopping_app/widgets/big_text.dart';
import 'package:flutter_shopping_app/widgets/small_text.dart';

class HomePage extends StatefulWidget {
  final User user;
  HomePage({super.key, required this.user});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 50,
              color: Color.fromARGB(255, 237, 186, 76),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
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
                  Container(
                    height: 40,
                    width: 120,
                    margin: EdgeInsets.only(right: 20),
                    child: Row(
                      children: [
                        Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image:
                                    AssetImage('assets/image/nam_avatar.png'),
                                fit: BoxFit.cover,
                              ),
                            )),
                        Center(
                          child: Container(
                            height: 40,
                            width: 40,
                            child: PopupMenuButton<String>(
                              itemBuilder: (BuildContext context) {
                                return <PopupMenuEntry<String>>[
                                  PopupMenuItem<String>(
                                    value: 'signup',
                                    child:
                                        BigText('', text: 'Đăng ký', size: 15),
                                  ),
                                  PopupMenuItem<String>(
                                    value: 'logout',
                                    child: BigText('',
                                        text: 'Đăng xuất', size: 15),
                                  ),
                                ];
                              },
                              onSelected: (String value) {
                                // Xử lý khi lựa chọn một mục trong danh sách
                                if (value == 'signup') {
                                  Navigator.pushNamed(context, '/signup');
                                } else if (value == 'logout') {
                                  Navigator.pushNamed(context, '/login');
                                }
                              },
                            ),
                          ),
                        ),
                        Container(
                          height: 40,
                          width: 40,
                          child: IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.notifications_none_rounded),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 60,
            left: 10,
            right: 10,
            child: Container(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment
                    .spaceBetween, // làm cho các widget con nằm cùng hàng và cách đều nhau
                children: [
                  //Tạo chức năng chọn thành phố
                  Column(
                    children: [
                      BigText(
                        '',
                        text: "Thành Phố",
                        color: Color.fromARGB(255, 10, 65, 153),
                      ),
                      Row(
                        children: [
                          SmallText(
                            '',
                            text: "Hà Nội",
                            color: Colors.black,
                          ),
                          Icon(Icons.arrow_drop_down_rounded),
                        ],
                      ),
                    ],
                  ),
                  //Tạo nút tìm kiếm
                  Center(
                    child: Container(
                        width: 100,
                        height: 30,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 10),
                              child: Text("Tìm kiếm",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 10,
                                  )),
                            ),
                            Container(
                              margin: EdgeInsets.only(right: 10),
                              child: Icon(
                                Icons.search,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 123, 194, 253),
                          borderRadius: BorderRadius.circular(15),
                        )),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
              left: 0,
              right: 0,
              top: 120,
              bottom: 50,
              child: Expanded(
                  child: SingleChildScrollView(
                      child: HomeBodyPage(
                user: widget.user,
              )))),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              height: 40,
              color: Color.fromARGB(255, 255, 255, 255),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                    onPressed: () {
                      // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage(user: user)));
                    },
                    icon: Icon(Icons.home),
                  ),
                  IconButton(
                    onPressed: () {
                      // Navigator.pushNamed(context, '/cart');
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CartPage(
                            user: widget.user,
                          ),
                        ),
                      );
                    },
                    icon: Icon(Icons.shopping_cart),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => OrderListPage(
                            user: widget.user,
                          ),
                        ),
                      );
                    },
                    icon: Icon(Icons.shopping_cart_checkout_outlined),
                  ),
                  IconButton(
                    onPressed: () {
                      // Navigator.pushNamed(context, '/profile');
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Profile(
                            user: widget.user,
                          ),
                        ),
                      );
                    },
                    icon: Icon(Icons.person),
                  ),
                ],
              ),
            ),
          ),
        ],
      )),
    );
  }
}
