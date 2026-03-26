import 'package:flutter/material.dart';
// import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_shopping_app/models/user.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_shopping_app/widgets/big_text.dart';
import 'package:go_router/go_router.dart';

class SellerScreen extends StatefulWidget {
  final User seller;
  SellerScreen({super.key, required this.seller});

  @override
  _SellerScreenState createState() => _SellerScreenState();
}

class _SellerScreenState extends State<SellerScreen> {
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
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Chào mừng ${_seller.username}',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                              Row(
                                children: [
                                  const Icon(Icons.account_balance_wallet, color: Colors.white70, size: 14),
                                  const SizedBox(width: 4),
                                  Text(
                                    '${_seller.balance.toStringAsFixed(0)} VND',
                                    style: const TextStyle(fontSize: 13, color: Colors.white, fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                            ],
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
                                  context.push('/signup');
                                } else if (value == 'logout') {
                                  context.go('/');
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
                                                onPressed: () => context.push('/seller/orders', extra: {'seller': _seller, 'initialStatus': 'pendingseller'}),
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
                                                onPressed: () => context.push('/seller/orders', extra: {'seller': _seller, 'initialStatus': 'delivering'}),
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
                                                onPressed: () => context.push('/seller/orders', extra: {'seller': _seller, 'initialStatus': 'delivered'}),
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
                                                  context.push('/seller/products', extra: _seller);
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
