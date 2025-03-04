import 'package:flutter/material.dart';
// import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_shopping_app/models/User.dart';
import 'package:flutter_shopping_app/pages/Seller/ProductManPage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_shopping_app/widgets/big_text.dart';

class SellerPage extends StatefulWidget {
  final User seller;
  SellerPage({super.key, required this.seller});

  @override
  _SellerPageState createState() => _SellerPageState();
}

class _SellerPageState extends State<SellerPage> {
  late User _seller;

  @override
  void initState() {
    super.initState();
    _seller = widget.seller;
  }

  void _updateData() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Positioned(
              left: 0,
              right: 0,
              top: 0,
              child: Column(
                children: [
                  Container(
                      height: 100,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Color.fromARGB(255, 68, 142, 240),
                            Color.fromARGB(255, 39, 195, 174),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      width: double.infinity,
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Chào mừng nhà bán hàng ${_seller.username}',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              letterSpacing: 1.5, // Khoảng cách giữa các chữ
                              shadows: [
                                Shadow(
                                  offset: Offset(2.0, 2.0), // Vị trí bóng
                                  blurRadius: 3.0, // Độ mờ của bóng
                                  color:
                                      const Color.fromARGB(255, 157, 152, 152)
                                          .withOpacity(0.5), // Màu bóng
                                ),
                              ],
                              fontStyle: FontStyle.italic, // In nghiêng
                            ),
                            textAlign: TextAlign.center, // Căn giữa
                          ),
                          SizedBox(width: 10),
                          Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white,
                            ),
                            child: PopupMenuButton<String>(
                              itemBuilder: (BuildContext context) {
                                return <PopupMenuEntry<String>>[
                                  PopupMenuItem<String>(
                                    value: 'setting',
                                    child: BigText('',
                                        text: 'Tài khoản', size: 15),
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
                                if (value == 'setting') {
                                  Navigator.pushNamed(context, '/signup');
                                } else if (value == 'logout') {
                                  Navigator.pushNamed(context, '/login');
                                }
                              },
                            ),
                          ),
                        ],
                      )),
                  Container(
                    height: 1,
                    width: double.infinity,
                    color: Colors.black,
                  ),
                ],
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              top: 101,
              child: SingleChildScrollView(
                child: Container(
                    height: 800,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color.fromARGB(255, 177, 234, 161),
                          Color.fromARGB(255, 241, 152, 198),
                          Color.fromARGB(255, 112, 160, 238),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: Column(
                      children: [
                        SizedBox(height: 20),
                        Container(
                          height: 350,
                          width: double.infinity,
                          child: PageView(
                            children: [
                              Container(
                                height: 350,
                                margin: EdgeInsets.only(left: 20, right: 20),
                                width: double.maxFinite,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.white,
                                ),
                              ),
                              Container(
                                height: 350,
                                width: double.maxFinite,
                                margin: EdgeInsets.only(left: 20, right: 20),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20),
                        Container(
                            height: 300,
                            width: double.infinity,
                            margin: EdgeInsets.only(left: 20, right: 20),
                            child: Column(
                              children: [
                                Container(
                                    height: 130,
                                    width: double.infinity,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Column(
                                          children: [
                                            Container(
                                              height: 80,
                                              width: 80,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                                color: const Color.fromARGB(
                                                    255, 255, 255, 255),
                                              ),
                                              child: IconButton(
                                                onPressed: () {},
                                                icon: FaIcon(
                                                  FontAwesomeIcons.box,
                                                  size: 40.0,
                                                  color: const Color.fromARGB(
                                                      255, 0, 0, 0),
                                                ),
                                              ),
                                            ),
                                            Text(
                                              'Đơn hàng mới',
                                              style: TextStyle(
                                                fontSize: 10,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                                letterSpacing: 1.5,
                                                fontStyle: FontStyle.italic,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            Container(
                                              height: 80,
                                              width: 80,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                                color: const Color.fromARGB(
                                                    255, 255, 255, 255),
                                              ),
                                              child: IconButton(
                                                onPressed: () {},
                                                icon: FaIcon(
                                                  FontAwesomeIcons.truck,
                                                  size: 40.0,
                                                  color: const Color.fromARGB(
                                                      255, 0, 0, 0),
                                                ),
                                              ),
                                            ),
                                            Text(
                                              'Đơn hàng đang giao',
                                              style: TextStyle(
                                                fontSize: 10,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                                letterSpacing: 1.5,
                                                fontStyle: FontStyle.italic,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            Container(
                                              height: 80,
                                              width: 80,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                                color: const Color.fromARGB(
                                                    255, 255, 255, 255),
                                              ),
                                              child: IconButton(
                                                onPressed: () {},
                                                icon: FaIcon(
                                                  FontAwesomeIcons.checkCircle,
                                                  size: 40.0,
                                                  color: const Color.fromARGB(
                                                      255, 0, 0, 0),
                                                ),
                                              ),
                                            ),
                                            Text(
                                              'Đơn hàng đã giao',
                                              style: TextStyle(
                                                fontSize: 10,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                                letterSpacing: 1.5,
                                                fontStyle: FontStyle.italic,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ],
                                        ),
                                      ],
                                    )),
                                Container(
                                    height: 130,
                                    width: double.infinity,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Column(
                                          children: [
                                            Container(
                                              height: 80,
                                              width: 80,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                                color: const Color.fromARGB(
                                                    255, 255, 255, 255),
                                              ),
                                              child: IconButton(
                                                onPressed: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              ProductManPage(
                                                                  seller:
                                                                      _seller)));
                                                  _updateData();
                                                },
                                                icon: FaIcon(
                                                  FontAwesomeIcons.productHunt,
                                                  size: 40.0,
                                                  color: const Color.fromARGB(
                                                      255, 0, 0, 0),
                                                ),
                                              ),
                                            ),
                                            Text(
                                              'Sản phẩm',
                                              style: TextStyle(
                                                fontSize: 10,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                                letterSpacing: 1.5,
                                                fontStyle: FontStyle.italic,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            Container(
                                              height: 80,
                                              width: 80,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                                color: const Color.fromARGB(
                                                    255, 255, 255, 255),
                                              ),
                                              child: IconButton(
                                                onPressed: () {},
                                                icon: FaIcon(
                                                  FontAwesomeIcons.bullhorn,
                                                  size: 40.0,
                                                  color: const Color.fromARGB(
                                                      255, 0, 0, 0),
                                                ),
                                              ),
                                            ),
                                            Text(
                                              'Quảng bá',
                                              style: TextStyle(
                                                fontSize: 10,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                                letterSpacing: 1.5,
                                                fontStyle: FontStyle.italic,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            Container(
                                              height: 80,
                                              width: 80,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                                color: const Color.fromARGB(
                                                    255, 255, 255, 255),
                                              ),
                                              child: IconButton(
                                                onPressed: () {},
                                                icon: FaIcon(
                                                  FontAwesomeIcons.wallet,
                                                  size: 40.0,
                                                  color: const Color.fromARGB(
                                                      255, 0, 0, 0),
                                                ),
                                              ),
                                            ),
                                            Text(
                                              'Doanh thu',
                                              style: TextStyle(
                                                fontSize: 10,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                                letterSpacing: 1.5,
                                                fontStyle: FontStyle.italic,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ))
                              ],
                            )),
                      ],
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget InputBox({
  required String label,
  required TextEditingController txtController,
}) {
  return Column(
    children: [
      Container(
        margin: EdgeInsets.only(left: 20),
        alignment: Alignment.centerLeft,
        height: 20,
        child: Text(label),
      ),
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
