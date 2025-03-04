import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_shopping_app/models/CartItem.dart';
import 'package:flutter_shopping_app/pages/Customer/AllProductPage.dart';
import 'package:flutter_shopping_app/pages/Customer/HomePage.dart';
import 'package:flutter_shopping_app/pages/Customer/OrderListPage.dart';
import 'package:flutter_shopping_app/pages/Customer/OrderPage.dart';
import 'package:flutter_shopping_app/pages/DetailProduct.dart';
import 'package:flutter_shopping_app/pages/ProfilePage.dart';
import 'package:flutter_shopping_app/provider/AuthProvider.dart';
import 'package:flutter_shopping_app/provider/CartProvider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<String> _selectedItems = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final user = Provider.of<AuthProvider>(context, listen: false).user;
      final cartProvider = Provider.of<CartProvider>(context, listen: false);
      if (user != null) {
        cartProvider.getCartItems(user.id);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<AuthProvider>(context, listen: false);

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(80),
          child: AppBar(
            backgroundColor: Color.fromARGB(255, 252, 100, 54),
            toolbarHeight: 80,
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () => Navigator.pop(context),
            ),
            title: Text(
              'Giỏ hàng',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            centerTitle: true,
          ),
        ),
        body: Consumer<CartProvider>(builder: (context, cartProvider, child) {
          if (cartProvider.isLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (cartProvider.cartItems.isEmpty) {
            return Center(child: Text('Giỏ hàng trống'));
          }
          return Stack(
            children: [
              Container(
                color: Colors.grey[200],
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 10,
                top: 10,
                child: Container(
                  child: ListView.builder(
                    itemCount: cartProvider.cartItems.length,
                    itemBuilder: (context, index) {
                      CartItem item = cartProvider.cartItems[index];

                      return InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DetailProduct(
                                        productId: item.product.id,
                                        role: 'customer',
                                      )));
                        },
                        child: Container(
                          width: double.infinity,
                          height: 180,
                          margin: EdgeInsets.only(
                              left: 0, right: 0, top: 10, bottom: 10),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: const Color.fromARGB(255, 45, 44, 44),
                                width: 1,
                              ),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 3,
                                blurRadius: 6,
                                offset: Offset(0, 3),
                              ),
                            ],
                            color: Color.fromARGB(255, 252, 252, 252),
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width: 20,
                                    margin: EdgeInsets.only(left: 5),
                                    child: Checkbox(
                                      value: _selectedItems.contains(item.id),
                                      onChanged: (bool? value) {
                                        setState(() {
                                          if (value == true) {
                                            _selectedItems.add(item.id);
                                          } else {
                                            _selectedItems.remove(item.id);
                                          }
                                        });
                                      },
                                    ),
                                  ),
                                  Container(
                                    height: 23,
                                    width: 220,
                                    margin: EdgeInsets.only(
                                        left: 10, top: 5, bottom: 5),
                                    child: Text(
                                      "Shop: ${item.sellName}",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          overflow: TextOverflow.ellipsis),
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      height: 20,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          IconButton(
                                            onPressed: () {
                                              cartProvider.updateCartItems(
                                                  item.id, false);
                                            },
                                            icon: Icon(
                                              Icons.remove,
                                              size: 20,
                                            ),
                                          ),
                                          Container(
                                            padding: EdgeInsets.only(top: 0),
                                            child: Text(
                                              item.quantity.toString(),
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 18,
                                              ),
                                            ),
                                          ),
                                          IconButton(
                                            onPressed: () {
                                              cartProvider.updateCartItems(
                                                  item.id, true);
                                            },
                                            icon: Icon(Icons.add, size: 20),
                                          ),
                                          Expanded(
                                            child: Container(
                                                child: IconButton(
                                              onPressed: () {
                                                cartProvider
                                                    .deleteCartItem(item.id);
                                              },
                                              icon: Icon(Icons.delete),
                                            )),
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              Container(
                                height: 1,
                                width: double.maxFinite,
                                margin: EdgeInsets.only(
                                    top: 5, left: 20, right: 20, bottom: 5),
                                color: Colors.grey,
                              ),
                              Container(
                                width: double.maxFinite,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 110,
                                      height: 110,
                                      margin: EdgeInsets.only(left: 0, top: 3),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        image: DecorationImage(
                                          image: (item.product.imgs
                                                      .isNotEmpty &&
                                                  File(item.product.imgs[0])
                                                      .existsSync())
                                              ? FileImage(File(item
                                                      .product.imgs[
                                                  0])) // Nếu đường dẫn hệ thống tồn tại
                                              : (item.product.imgs[0]
                                                      .isNotEmpty)
                                                  ? AssetImage(
                                                      item.product.imgs[0])
                                                  : AssetImage('')
                                                      as ImageProvider,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        margin:
                                            EdgeInsets.only(left: 5, top: 0),
                                        child: Column(
                                          children: [
                                            Container(
                                              width: 300,
                                              child: Text(
                                                item.product.name,
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                                textAlign: TextAlign.left,
                                              ),
                                            ),
                                            Container(
                                              width: 300,
                                              child: Text(
                                                'Giá: ${item.price} VND',
                                                style: TextStyle(
                                                  color: const Color.fromARGB(
                                                      255, 255, 0, 0),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  fontSize: 14,
                                                ),
                                                textAlign: TextAlign.left,
                                              ),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                (item.color != "No")
                                                    ? Container(
                                                        width: 110,
                                                        child: Text(
                                                          'Màu: ${item.color}',
                                                          style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 15,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                          ),
                                                          textAlign:
                                                              TextAlign.left,
                                                        ),
                                                      )
                                                    : Container(
                                                        height: 0,
                                                      ),
                                                (item.size != "No")
                                                    ? Container(
                                                        width: 110,
                                                        child: Text(
                                                          'Size: ${item.size}',
                                                          style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 15,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                          ),
                                                          textAlign:
                                                              TextAlign.left,
                                                        ),
                                                      )
                                                    : Container(
                                                        height: 0,
                                                      ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Container(
                                              width: 300,
                                              child: Text(
                                                'Địa chỉ: ${item.product.address.toString()}',
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 12,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                                textAlign: TextAlign.left,
                                              ),
                                            ),
                                            Container(
                                              width: 300,
                                              child: Text(
                                                'Thời gian: ${item.time.substring(0, 19)}',
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 12,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                                textAlign: TextAlign.left,
                                              ),
                                            ),
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
                  ),
                ),
              ),
              //Khung tổng tiền
              Positioned(
                  left: 10,
                  right: 10,
                  bottom: 30,
                  child: Container(
                      margin: EdgeInsets.only(left: 10, right: 10, bottom: 5),
                      height: 50,
                      child: Center(
                        child: InkWell(
                          onTap: () {
                            if (Provider.of<CartProvider>(context,
                                    listen: false)
                                .cartItems
                                .isEmpty) {
                              SnackBar snackBar = SnackBar(
                                content: Text('Giỏ hàng trống'),
                                backgroundColor: Colors.red,
                                duration: Duration(seconds: 1),
                              );
                            } else if (_selectedItems.isEmpty) {
                              SnackBar snackBar = SnackBar(
                                content: Text('Vui lòng chọn sản phẩm'),
                                backgroundColor: Colors.red,
                                duration: Duration(seconds: 1),
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            } else {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => OrderPage(
                                    cartItems: _selectedItems,
                                  ),
                                ),
                              ).then((value) {
                                if (value == true) {
                                  final cartProvier = Provider.of<CartProvider>(
                                      context,
                                      listen: false);
                                  final user = Provider.of<AuthProvider>(
                                          context,
                                          listen: false)
                                      .user;
                                  cartProvier.getCartItems(user!.id);
                                }
                              });
                            }
                          },
                          splashColor:
                              Colors.blue.withOpacity(0.3), // Màu ripple
                          highlightColor:
                              Colors.transparent, // Màu khi nhấn giữ
                          child: AnimatedScale(
                            duration: Duration(milliseconds: 150),
                            scale: 1.1, // Phóng to khi nhấn
                            child: Container(
                              margin: EdgeInsets.only(left: 10, right: 10),
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Color.fromARGB(255, 242, 88, 11),
                                    Color.fromARGB(255, 255, 30, 0),
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              height: 40,
                              width: 200,
                              child: Text(
                                'Đặt hàng',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                      ))),
            ],
          );
        }),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          shape: const CircleBorder(),
          backgroundColor: Colors.orange,
          child: FaIcon(
            FontAwesomeIcons.shoppingCart,
            color: const Color.fromARGB(255, 255, 255, 255),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
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
                      builder: (context) => OrderListPage(),
                    ),
                  ).then((value) {
                    if (value == true) {
                      setState(() {});
                    }
                  });
                },
                icon: FaIcon(
                  FontAwesomeIcons.truck,
                ),
              ),
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProfilePage(
                        user: userProvider.user!,
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
    );
  }
}
