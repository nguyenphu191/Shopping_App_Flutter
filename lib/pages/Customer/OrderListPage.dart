import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shopping_app/models/Order.dart';
import 'package:flutter_shopping_app/pages/Customer/AllProductPage.dart';
import 'package:flutter_shopping_app/pages/Customer/CartPage.dart';
import 'package:flutter_shopping_app/pages/Customer/HomePage.dart';
import 'package:flutter_shopping_app/pages/Customer/OrderDetail.dart';
import 'package:flutter_shopping_app/pages/ProfilePage.dart';
import 'package:flutter_shopping_app/provider/AuthProvider.dart';
import 'package:flutter_shopping_app/provider/OrderProvider.dart';
import 'package:flutter_shopping_app/provider/UserProvider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class OrderListPage extends StatefulWidget {
  const OrderListPage({super.key});

  @override
  State<OrderListPage> createState() => _OrderListPageState();
}

class _OrderListPageState extends State<OrderListPage> {
  Future<List<OrderModel>> _getOrderList(String status) async {
    final user = Provider.of<UserProvider>(context, listen: false).user;
    final orderProvider = Provider.of<OrderProvider>(context, listen: false);
    final response = await orderProvider.getUserOrder(user!.id);
    if (status == "pending") {
      return response
          .where((order) =>
              order.status == "pendingadmin" || order.status == "pendingseller")
          .toList();
    }
    return response.where((order) => order.status == status).toList();
  }

  Future<void> _updateOrder(String orderId, String newStatus) async {
    final orderProvider = Provider.of<OrderProvider>(context, listen: false);
    final response = await orderProvider.updateOrder(orderId, newStatus);
    if (response['status'] == 'success') {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Cập nhật trạng thái thành công'),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 1),
        ),
      );
      setState(() {}); // Làm mới danh sách đơn hàng
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Lỗi: Không thể cập nhật trạng thái'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 1),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthProvider>(context, listen: false).user;
    return DefaultTabController(
      length: 4,
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(80),
            child: AppBar(
              backgroundColor: Color.fromARGB(255, 252, 100, 54),
              toolbarHeight: 80,
              leading: IconButton(
                icon: Icon(Icons.arrow_back_ios),
                onPressed: () => Navigator.pop(context, true),
              ),
              title: Text(
                'Danh sách đơn hàng',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              centerTitle: true,
            ),
          ),
          body: Stack(
            children: [
              Column(
                children: [
                  TabBar(
                    isScrollable: true,
                    labelColor: const Color.fromARGB(255, 47, 120, 246),
                    unselectedLabelColor: const Color.fromARGB(255, 44, 43, 43),
                    indicatorColor: const Color.fromARGB(255, 36, 116, 255),
                    tabs: [
                      Tab(text: 'Chờ xác nhận'),
                      Tab(text: 'Đang vận chuyển'),
                      Tab(text: 'Hoàn thành'),
                      Tab(text: 'Hủy'),
                    ],
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                      ),
                      child: TabBarView(
                        children: [
                          _buildOrderListView('pending'),
                          _buildOrderListView('delivering'),
                          _buildOrderListView('delivered'),
                          _buildOrderListView('cancelled'),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {},
            shape: const CircleBorder(),
            backgroundColor: Colors.orange,
            child: FaIcon(
              FontAwesomeIcons.truck,
              color: const Color.fromARGB(255, 255, 255, 255),
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: BottomAppBar(
            elevation: 1,
            height: 50,
            color: Colors.white,
            shape: CircularNotchedRectangle(),
            notchMargin: 10,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomePage(),
                      ),
                    );
                  },
                  icon: FaIcon(
                    FontAwesomeIcons.home,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AllProductPage(),
                      ),
                    ).then((value) {
                      if (value == true) {
                        setState(() {});
                      }
                    });
                  },
                  icon: FaIcon(
                    FontAwesomeIcons.bagShopping,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CartPage(),
                      ),
                    ).then((value) {
                      if (value == true) {
                        setState(() {}); // Làm mới danh sách sau khi quay lại
                      }
                    });
                  },
                  icon: FaIcon(
                    FontAwesomeIcons.shoppingCart,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProfilePage(
                          user: user!,
                        ),
                      ),
                    ).then((value) {
                      if (value == true) {
                        setState(() {}); // Làm mới danh sách sau khi quay lại
                      }
                    });
                  },
                  icon: FaIcon(
                    FontAwesomeIcons.user,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildOrderListView(String status) {
    return FutureBuilder<List<OrderModel>>(
      future: _getOrderList(status),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Lỗi tải dữ liệu'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('Không có đơn hàng'));
        } else {
          List<OrderModel> orderList = snapshot.data!;
          return ListView.builder(
            itemCount: orderList.length,
            itemBuilder: (context, index) {
              OrderModel order = orderList[index];
              return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => OrderDetailPage(
                        order: order,
                      ),
                    ),
                  ).then((value) {
                    if (value == true) {
                      setState(() {}); // Làm mới danh sách sau khi quay lại
                    }
                  });
                },
                child: Container(
                  height: 140,
                  margin: EdgeInsets.only(left: 0, right: 0, top: 10),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: const Color.fromARGB(255, 45, 44, 44),
                        width: 1,
                      ),
                    ),
                    color: Colors.white,
                  ),
                  child: Column(
                    children: [
                      Container(
                        height: 20,
                        width: double.maxFinite,
                        margin: EdgeInsets.only(left: 10, top: 5, bottom: 5),
                        child: Text(
                          "Shop: Cửa tiệm bánh mì",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      Container(
                        height: 1,
                        width: double.maxFinite,
                        margin: EdgeInsets.only(top: 5, left: 20, right: 20),
                        color: Colors.grey,
                      ),
                      Container(
                        width: double.maxFinite,
                        child: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.only(left: 10, top: 10),
                              width: 250,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Container(
                                      width: 250,
                                      child: Text(
                                        'ID: ${order.id}',
                                        textAlign: TextAlign.left,
                                        style: TextStyle(fontSize: 20),
                                      )),
                                  Container(
                                    width: 250,
                                    child: Text(
                                      'Tổng tiền: ${order.total}đ',
                                      style: TextStyle(fontSize: 12),
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                  Container(
                                    width: 250,
                                    child: Text(
                                      'Ngày đặt: ${order.time.substring(0, 19)}',
                                      style: TextStyle(fontSize: 12),
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Container(
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(
                                      _getStatusText(order.status),
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: _getStatusColor(order.status),
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    _buildActionButton(order),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }
      },
    );
  }

  Widget _buildActionButton(OrderModel order) {
    if (order.status == 'pendingadmin' || order.status == 'pendingseller') {
      return _buildButton('Hủy đơn', Colors.red, () {
        _updateOrder(order.id, 'cancelled');
      });
    } else if (order.status == 'delivering') {
      return _buildButton('Đã nhận hàng', Colors.green, () {
        _updateOrder(order.id, 'delivered');
      });
    }
    return Container();
  }

  Widget _buildButton(String text, Color color, VoidCallback onPressed) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Text(
          text,
          style: TextStyle(color: Colors.white, fontSize: 15),
        ),
      ),
    );
  }

  String _getStatusText(String status) {
    switch (status) {
      case 'pendingadmin':
      case 'pendingseller':
        return 'Chờ xác nhận';
      case 'delivering':
        return 'Đang vận chuyển';
      case 'delivered':
        return 'Hoàn thành';
      case 'cancelled':
        return 'Hủy';
      default:
        return 'Không xác định';
    }
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'pendingadmin':
      case 'pendingseller':
        return Colors.orange;
      case 'delivering':
        return Colors.blue;
      case 'delivered':
        return Colors.green;
      case 'cancelled':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}
