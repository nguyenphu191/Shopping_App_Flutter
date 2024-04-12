import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shopping_app/models/cart_item.dart';
import 'package:flutter_shopping_app/models/product.dart';
import 'package:flutter_shopping_app/pages/detail_product.dart';

import 'package:flutter_shopping_app/widgets/big_text.dart';
import 'package:flutter_shopping_app/widgets/small_text.dart';
import 'package:flutter_shopping_app/data/app_data.dart' as app_data;
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class HomeBodyPage extends StatefulWidget {
  const HomeBodyPage({super.key});

  @override
  State<HomeBodyPage> createState() => _HomeBodyPageState();
}

// Tạo 1 trang PageView để hiển thị các món ăn nổi bật
class _HomeBodyPageState extends State<HomeBodyPage> {
  //điều khiển các trang của PageView, không gian chiếm mỗi trang là 85% container
  PageController pageController = PageController(viewportFraction: 0.85);
  var _currentPage = 0.0;
  @override
  // bắt sự kiện khi trang thay đổi trang, _currentPage sẽ lấy giá trị của trang hiện tại
  void initState() {
    super.initState();
    pageController.addListener(() {
      setState(() {
        _currentPage = pageController.page!;
      });
    });
  }

  @override
  void dispose() {
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 320,
          child: PageView.builder(
              controller: pageController,
              itemCount: app_data.productList.length,
              itemBuilder: (context, position) {
                return _buildPageIteam(position, context);
              }),
        ),

        // Hiển thị các chấm để biểu thị trang hiện tại
        new DotsIndicator(
          dotsCount: app_data.productList.length,
          position: _currentPage,
          decorator: DotsDecorator(
            size: const Size.square(9.0),
            activeSize: const Size(18.0, 9.0),
            activeShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0)),
          ),
        ),

        SizedBox(height: 10),
        // Phổ biến
        Container(
          margin: EdgeInsets.only(left: 20, right: 20),
          child: Row(
            //căn chỉnh các widget chéo nhau
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                child: BigText(
                  '',
                  text: "Phổ biến",
                ),
              ),
              SizedBox(
                width: 20,
              ),
              Container(
                child: SmallText(
                  '',
                  text: "Xem tất cả",
                ),
              ),
            ],
          ),
        ),

        Container(
          height: 400,
          child: ListView.builder(
            itemCount: app_data.productList.length,
            itemBuilder: (context, index) {
              ProductModel product = app_data.productList[index];
              return Container(
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailProduct(
                            product: product,
                      ),
                    ),
                  );
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
                              fit: BoxFit.cover,
                              image: AssetImage(product.img),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
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
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    children: [
                                      Container(
                                        child: Text(
                                          '${product.price} VND',
                                          style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                height: 5,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                    '5km',
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
                                      app_data.cartList.add(CartItem(
                                          product: product, quantity: 1));
                                      Get.snackbar('Thêm vào giỏ hàng', 'Đã thêm vào giỏ hàng');
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.blue,
                                        borderRadius: BorderRadius.circular(50),
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
              ));
            },
            
          ),
        ),
      ],
    );
  }
}

//Lấy ảnh từ assets để hiển thị
Widget _buildPageIteam(int index, BuildContext context) {
  ProductModel product =
      app_data.productList[app_data.productList.length - 1 - index];
  return Stack(
    children: [
      Container(
        height: 220,
        margin: EdgeInsets.only(left: 5, right: 5),
        decoration: BoxDecoration(
            color: index.isEven
                ? Color.fromARGB(255, 241, 203, 65)
                : Color.fromARGB(255, 74, 236, 203),
            borderRadius: BorderRadius.circular(30),
            image: DecorationImage(
                fit: BoxFit.cover, image: AssetImage(product.img))),
      ),
      Align(
        alignment: Alignment.bottomCenter, // Đặt ở giữa và ở dưới
        child: Container(
          height: 150,
          margin: EdgeInsets.only(left: 40, right: 40, bottom: 15),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
          ),
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailProduct(
                    product: product,
                  ),
                ),
              );
            },
            child: Container(
              margin: EdgeInsets.all(10),
              child: Column(children: [
                BigText(
                  '',
                  text: product.name,
                ),
                SizedBox(
                  height: 5,
                ),
                SmallText(
                  '',
                  text: product.description,
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${product.price} VND',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        app_data.cartList
                            .add(CartItem(product: product, quantity: 1));
                            Get.snackbar('Thêm vào giỏ hàng', 'Đã thêm vào giỏ hàng');
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Icon(
                          Icons.add,
                          size: 30,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Container(
                      height: 30,
                      width: 30,
                      child: Icon(
                        Icons.location_on,
                        size: 20,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "5km",
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ],
                )
              ]),
            ),
          ),
        ),
      ),
    ],
  );
}

class PopularProduct extends StatelessWidget {
  final ProductModel product;
  PopularProduct({required this.product});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, '/detail');
      },
      child: Container(
        margin: EdgeInsets.only(left: 20, right: 20),
        child: Container(
          height: 110,
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
                    fit: BoxFit.cover,
                    image: AssetImage(product.img),
                  ),
                ),
              ),
              SizedBox(
                width: 20,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Text(
                          '${product.price} VND',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 50,
                      ),
                      InkWell(
                        onTap: () {
                          app_data.cartList
                              .add(CartItem(product: product, quantity: 1));
                              Get.snackbar('Thêm vào giỏ hàng', 'Đã thêm vào giỏ hàng');
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Icon(
                            Icons.add,
                            size: 25,
                          ),
                        ),
                      ),
                    ],
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
                      Text(
                        '5km',
                        style: TextStyle(
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
