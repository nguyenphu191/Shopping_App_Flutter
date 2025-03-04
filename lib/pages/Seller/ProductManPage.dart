import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_shopping_app/API_SERVICE/api_service.dart';
import 'package:flutter_shopping_app/models/Product.dart';
import 'package:flutter_shopping_app/models/User.dart';
import 'package:flutter_shopping_app/pages/Seller/AddProductPage.dart';
import 'package:flutter_shopping_app/pages/DetailProduct.dart';
import 'package:flutter_shopping_app/widgets/big_text.dart';
import 'package:flutter_shopping_app/widgets/small_text.dart';

class ProductManPage extends StatefulWidget {
  final User seller;
  const ProductManPage({super.key, required this.seller});

  @override
  State<ProductManPage> createState() => _ProductManPageState();
}

class _ProductManPageState extends State<ProductManPage> {
  final ApiService _api = ApiService();
  late User _seller;
  List<ProductModel> _products = [];
  late TextEditingController _searchController = TextEditingController();

  void _getProducts() async {
    final products = await _api.getUserProducts(_seller.id);
    setState(() {
      _products = products;
    });
  }

  void _updateData() {
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _seller = widget.seller;
    _getProducts();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              const Color.fromARGB(255, 65, 164, 245),
              const Color.fromARGB(255, 119, 238, 218),
              const Color.fromARGB(255, 231, 212, 212)
            ],
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              top: 20,
              left: 0,
              right: 0,
              child: Container(
                height: 100,
                width: double.infinity,
                margin: EdgeInsets.only(
                  left: 20,
                  right: 20,
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 40,
                          width: 40,
                          padding: EdgeInsets.only(left: 5),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: const Color.fromARGB(255, 255, 255, 255),
                          ),
                          child: IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: Icon(Icons.arrow_back_ios)),
                        ),
                        Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: const Color.fromARGB(255, 255, 255, 255),
                          ),
                          child: PopupMenuButton<String>(
                            itemBuilder: (BuildContext context) {
                              return <PopupMenuEntry<String>>[
                                PopupMenuItem<String>(
                                  value: 'Add',
                                  child: BigText('',
                                      text: 'Thêm sản phẩm', size: 15),
                                ),
                              ];
                            },
                            onSelected: (String value) {
                              // Xử lý khi lựa chọn một mục trong danh sách
                              if (value == 'Add') {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            AddProductPage(seller: _seller)));
                                _updateData();
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                    Container(
                      height: 50,
                      width: 300,
                      alignment: Alignment.center,
                      child: Row(
                        children: [
                          InputBox(
                            hint: 'Tìm kiếm',
                            txtController: _searchController,
                            isSecured: false,
                            width: 200,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: const Color.fromARGB(255, 255, 255, 255),
                            ),
                            child: IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.search),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Positioned(
                top: 150,
                left: 10,
                right: 10,
                child: SingleChildScrollView(
                  child: Container(
                      height: 600,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 255, 255, 255)
                            .withOpacity(0.5),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ListView.builder(
                        itemCount: _products.length,
                        itemBuilder: (context, index) {
                          ProductModel product = _products[index];
                          return Container(
                              child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DetailProduct(
                                          productId: product.id,
                                          role: 'seller',
                                        )),
                              );
                              _updateData();
                            },
                            child: Container(
                              margin: EdgeInsets.only(left: 20, right: 20),
                              child: Container(
                                height: 120,
                                margin: EdgeInsets.only(top: 10),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      height: 100,
                                      width: 100,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        image: DecorationImage(
                                          image:
                                              FileImage(File(product.imgs[0])),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Container(
                                      width: 250,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          BigText(
                                            '',
                                            text: product.name,
                                            overflow: TextOverflow.ellipsis,
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
                                            child: Row(
                                              children: [
                                                Text(
                                                  'Giá: ${product.variants[0].price} VND',
                                                  style: TextStyle(
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 20,
                                                ),
                                                Text(
                                                  'Đã bán: ${product.sold}',
                                                  style: TextStyle(
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Row(
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
                                              Container(
                                                width: 230,
                                                child: Text(
                                                  product.address.toString(),
                                                  style: TextStyle(
                                                    fontSize: 10,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Container(
                                            height: 1,
                                            margin: EdgeInsets.only(
                                                top: 5, right: 5, bottom: 5),
                                            width: 200,
                                            color: Colors.black,
                                          )
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Container(
                                        width: 50,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            IconButton(
                                              onPressed: () {},
                                              icon: Icon(Icons.edit),
                                            ),
                                            IconButton(
                                              onPressed: () {},
                                              icon: Icon(Icons.delete),
                                            ),
                                          ],
                                        ))
                                  ],
                                ),
                              ),
                            ),
                          ));
                        },
                      )),
                )),
          ],
        ),
      ),
    ));
  }
}

Widget InputBox(
    {required String hint,
    required TextEditingController txtController,
    required bool isSecured,
    required double width}) {
  return Container(
    height: 30,
    width: width,
    padding: const EdgeInsets.only(left: 10, bottom: 5),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(30),
      border: Border.all(color: const Color.fromARGB(255, 2, 2, 2)),
    ),
    child: TextField(
      obscureText: isSecured,
      controller: txtController,
      decoration: InputDecoration(
        hintText: hint,
        border: InputBorder.none,
      ),
    ),
  );
}
