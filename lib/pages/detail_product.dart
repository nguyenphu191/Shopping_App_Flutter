import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_shopping_app/models/User.dart';
import 'package:flutter_shopping_app/models/cart_item.dart';
import 'package:flutter_shopping_app/models/product.dart';
import 'package:flutter_shopping_app/widgets/big_text.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class DetailProduct extends StatefulWidget {
  final ProductModel product;
  final User user;
  const DetailProduct({super.key, required this.product, required this.user});

  @override
  State<DetailProduct> createState() => _DetailProductState();
}

class _DetailProductState extends State<DetailProduct> {
  @override
  Widget build(BuildContext context) {
    User user = widget.user;
    ProductModel product = widget.product;
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 237, 186, 76),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back_ios),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/cart');
                    },
                    icon: Icon(Icons.shopping_cart),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            top: 60,
            child: Container(
              height: 300,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: (product.img.isNotEmpty &&
                          File(product.img).existsSync())
                      ? FileImage(
                          File(product.img)) // Nếu đường dẫn hệ thống tồn tại
                      : (product.img.isNotEmpty)
                          ? AssetImage(product.img)
                          : AssetImage('') as ImageProvider,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Positioned(
            top: 350,
            left: 5,
            right: 5,
            bottom: 0,
            child: Container(
              height: 380,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 250, 250, 250),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.all(10),
                      child: BigText('', text: product.name),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.all(10),
                      child: Text(
                        'Giá: ${product.price}VND',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Địa chỉ: ${product.location}',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.all(10),
                      child: Text(
                        ' Lượt bán: ${product.sold}',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      height: 1,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 8, 8, 8),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Container(
                              margin: EdgeInsets.only(
                                  bottom: 10, top: 10, left: 10, right: 10),
                              child: Text(
                                "Thông tin sản phẩm: ",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red,
                                ),
                              )),
                          Container(
                            margin: EdgeInsets.all(10),
                            child: Text(
                              product.description,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            left: 15,
            right: 15,
            bottom: 5,
            child: InkWell(
              onTap: () {
                for (int i = 0; i < user.cartList.length; i++) {
                  if (user.cartList[i].product.id == product.id) {
                    user.cartList[i].quantity++;
                    Get.snackbar('Thêm vào giỏ hàng', 'Đã thêm vào giỏ hàng');
                    return;
                  }
                }
                user.addCart(CartItem(product: product, quantity: 1));
                Get.snackbar('Thêm vào giỏ hàng', 'Đã thêm vào giỏ hàng');
              },
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Center(
                  child: Text("Thêm vào giỏ hàng",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      )),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
