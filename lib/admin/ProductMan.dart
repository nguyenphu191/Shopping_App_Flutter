import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shopping_app/models/product.dart';
import 'package:flutter_shopping_app/pages/detail_product.dart';
import 'package:flutter_shopping_app/widgets/big_text.dart';
import 'package:flutter_shopping_app/data/app_data.dart' as app_data;
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class ProductMan extends StatelessWidget {
  const ProductMan({super.key});

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
            // SizedBox(
            //   height: 10,
            // ),
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
                                          )));
                            },
                            child: Container(
                              width: 320,
                              height: 100,
                              margin: EdgeInsets.only(top: 10, bottom: 10),
                              decoration: BoxDecoration(
                                color: Color.fromARGB(255, 252, 252, 252),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    width: 100,
                                    height: 100,
                                    margin: EdgeInsets.only(left: 10),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      image: DecorationImage(
                                        image: (product.img.isNotEmpty &&
                                                File(product.img).existsSync())
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
                                  Container(
                                    width: 200,
                                    height: 100,
                                    alignment: Alignment.centerLeft,
                                    margin: EdgeInsets.only(left: 15, top: 10),
                                    child: Column(
                                      children: [
                                        Text(
                                          product.name,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 15,
                                          ),
                                        ),
                                        Text(
                                          'Giá: ${product.price} VND',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 15,
                                          ),
                                        ),
                                        Text(
                                          'Địa chỉ: ${product.location}',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 15,
                                          ),
                                        ),
                                        Text(
                                          'Đã bán: ${product.sold}',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 15,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: 50,
                                    height: 100,
                                    alignment: Alignment.center,
                                    margin: EdgeInsets.only(left: 15),
                                    child: IconButton(
                                      onPressed: () {
                                        app_data.admin.productList
                                            .removeAt(index);
                                        Get.snackbar(
                                            'Thông báo', 'Xóa thành công');
                                        Navigator.pop(context);
                                        Navigator.pushNamed(
                                            context, '/admin/product');
                                      },
                                      icon: Icon(Icons.delete),
                                    ),
                                  ),
                                ],
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
