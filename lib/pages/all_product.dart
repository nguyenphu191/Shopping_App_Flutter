import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_shopping_app/models/cart_item.dart';
import 'package:flutter_shopping_app/models/product.dart';
import 'package:flutter_shopping_app/pages/detail_product.dart';
import 'package:flutter_shopping_app/widgets/big_text.dart';
import 'package:flutter_shopping_app/data/app_data.dart' as app_data;
import 'package:flutter_shopping_app/widgets/small_text.dart';
import 'package:get/get.dart';
import 'package:flutter_shopping_app/models/User.dart';

class AllProduct extends StatefulWidget {
  final User user;
  const AllProduct({super.key, required this.user});

  @override
  State<AllProduct> createState() => _AllProductState();
}

class _AllProductState extends State<AllProduct> {
  @override
  Widget build(BuildContext context) {
    User user = widget.user;
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
            app_data.admin.productList.length > 0
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
                        itemCount: app_data.admin.productList.length,
                        itemBuilder: (context, index) {
                          ProductModel product =
                              app_data.admin.productList[index];
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DetailProduct(
                                            product: product,
                                            user: user,
                                          )));
                            },
                            child: Container(
                              margin: EdgeInsets.only(left: 20, right: 20),
                              child: Container(
                                height: 100,
                                margin: EdgeInsets.only(top: 10),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      height: 100,
                                      width: 100,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        image: DecorationImage(
                                          image: (product.img.isNotEmpty &&
                                                  File(product.img)
                                                      .existsSync())
                                              ? FileImage(File(product
                                                  .img)) // Nếu đường dẫn hệ thống tồn tại
                                              : (product.img.isNotEmpty)
                                                  ? AssetImage(product.img)
                                                  : AssetImage('')
                                                      as ImageProvider,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        BigText(
                                          '',
                                          text: product.name,
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Container(
                                          width: 220,
                                          child: SmallText(
                                            '',
                                            text: product.description,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Container(
                                          width: 220,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                children: [
                                                  Container(
                                                    child: Text(
                                                      '${product.price} VND',
                                                      style: TextStyle(
                                                        fontSize: 10,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Container(
                                                        child: Icon(
                                                          Icons.location_on,
                                                          size: 15,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 5,
                                                      ),
                                                      Text(
                                                        product.location,
                                                        style: TextStyle(
                                                          fontSize: 10,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  for (int i = 0;
                                                      i < user.cartList.length;
                                                      i++) {
                                                    if (app_data
                                                            .user1
                                                            .cartList[i]
                                                            .product
                                                            .id ==
                                                        product.id) {
                                                      user.cartList[i]
                                                          .quantity++;
                                                      Get.snackbar(
                                                          'Thêm vào giỏ hàng',
                                                          'Đã thêm vào giỏ hàng');
                                                      return;
                                                    }
                                                  }
                                                  user.addCart(CartItem(
                                                      product: product,
                                                      quantity: 1));
                                                  Get.snackbar(
                                                      'Thêm vào giỏ hàng',
                                                      'Đã thêm vào giỏ hàng');
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color: Colors.blue,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50),
                                                  ),
                                                  child: Icon(
                                                    Icons.add,
                                                    size: 30,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
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
