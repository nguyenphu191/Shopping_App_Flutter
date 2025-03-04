import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shopping_app/models/Product.dart';
import 'package:flutter_shopping_app/pages/Customer/AllProductPage.dart';
import 'package:flutter_shopping_app/pages/Customer/CartPage.dart';
import 'package:flutter_shopping_app/pages/Customer/OrderListPage.dart';
import 'package:flutter_shopping_app/pages/DetailProduct.dart';
import 'package:flutter_shopping_app/pages/ProfilePage.dart';
import 'package:flutter_shopping_app/provider/AuthProvider.dart';
import 'package:flutter_shopping_app/provider/ProductProvider.dart';
import 'package:flutter_shopping_app/widgets/big_text.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PageController pageController = PageController(viewportFraction: 0.85);
  var _currentPage = 0.0;
  int _vt1 = 0;
  int _vt2 = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final productProvider =
          Provider.of<ProductProvider>(context, listen: false);
      productProvider.getPopularProducts();
    });
    pageController.addListener(() {
      setState(() {
        _currentPage = pageController.page!;
      });
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthProvider>(context, listen: false).user;

    return SafeArea(
      child:
          Consumer<ProductProvider>(builder: (context, productProvider, child) {
        if (productProvider.isLoading) {
          return Center(child: CircularProgressIndicator());
        }
        if (productProvider.popularproducts.isEmpty) {
          return Center(
            child: Text('Không tìm thấy sản phẩm nào'),
          );
        }
        if (productProvider.popularproducts.length < 2) {
          _vt1 = 1;
          _vt2 = 1;
        } else {
          _vt1 = productProvider.popularproducts.length ~/ 3;
          _vt2 = productProvider.popularproducts.length - _vt1;
        }
        return Scaffold(
          body: Stack(
            children: [
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: 80,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 252, 100, 54),
                  ),
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
                            child: Center(
                              child: BigText(
                                '',
                                text: "FuFu",
                                size: 25,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        height: 40,
                        width: 120,
                        child: Row(
                          children: [
                            Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 255, 255, 255),
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: PopupMenuButton<String>(
                                itemBuilder: (BuildContext context) {
                                  Color color = Colors.black;
                                  return <PopupMenuEntry<String>>[
                                    PopupMenuItem<String>(
                                      value: 'signup',
                                      child: BigText('',
                                          text: 'Đăng ký', size: 15),
                                    ),
                                    PopupMenuItem<String>(
                                      value: 'logout',
                                      child: BigText('',
                                          text: 'Đăng xuất', size: 15),
                                    ),
                                  ];
                                },
                                onSelected: (String value) {
                                  if (value == 'signup') {
                                    Navigator.pushNamed(context, '/signup');
                                  } else if (value == 'logout') {
                                    Navigator.pushNamed(context, '/login');
                                  }
                                },
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 255, 255, 255),
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.notifications_none_rounded,
                                  color: Colors.black,
                                  size: 25,
                                ),
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
                  left: 0,
                  right: 0,
                  top: 80,
                  bottom: 0,
                  child: Expanded(
                      child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          height: 320,
                          child: PageView.builder(
                              controller: pageController,
                              itemCount: _vt1,
                              itemBuilder: (context, position) {
                                ProductModel product =
                                    productProvider.popularproducts[position];
                                return Stack(
                                  children: [
                                    Container(
                                      height: 220,
                                      margin: EdgeInsets.only(
                                          left: 5, right: 5, top: 10),
                                      decoration: BoxDecoration(
                                        color: position.isEven
                                            ? Color.fromARGB(255, 241, 203, 65)
                                            : Color.fromARGB(255, 74, 236, 203),
                                        borderRadius: BorderRadius.circular(30),
                                        // image: DecorationImage(
                                        //   image: (product.img.isNotEmpty &&
                                        //           File(product.img)
                                        //               .existsSync())
                                        //       ? FileImage(File(product
                                        //           .img)) // Nếu đường dẫn hệ thống tồn tại
                                        //       : (product.img.isNotEmpty)
                                        //           ? AssetImage(product.img)
                                        //           : AssetImage('')
                                        //               as ImageProvider,
                                        //   fit: BoxFit.cover,
                                        // ),
                                        image: DecorationImage(
                                          image: AssetImage(
                                              "assets/image/banhmi.png"),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      top: 0,
                                      right: 0,
                                      child: Container(
                                        height: 30,
                                        width: 60,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 5, vertical: 2),
                                        decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                              255, 255, 255, 255),
                                          borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(10),
                                            bottomLeft: Radius.circular(10),
                                          ),
                                        ),
                                        child: Text(
                                          '-${product.variants[0].discount}%',
                                          style: TextStyle(
                                            color: const Color.fromARGB(
                                                255, 255, 0, 0),
                                            fontSize: 18,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment
                                          .bottomCenter, // Đặt ở giữa và ở dưới
                                      child: Container(
                                        height: 100,
                                        margin: EdgeInsets.only(
                                            left: 40, right: 40, bottom: 15),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: Colors.grey,
                                            width: 1,
                                          ),
                                          color: const Color.fromARGB(
                                              255, 0, 0, 0),
                                          borderRadius:
                                              BorderRadius.circular(30),
                                        ),
                                        child: InkWell(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    DetailProduct(
                                                  productId: product.id,
                                                  role: 'customer',
                                                ),
                                              ),
                                            );
                                          },
                                          child: Container(
                                            margin: EdgeInsets.all(10),
                                            child: Column(children: [
                                              Row(
                                                children: [
                                                  Container(
                                                      width: 220,
                                                      margin: EdgeInsets.only(
                                                          left: 10),
                                                      child: Text(
                                                        product.name,
                                                        style: TextStyle(
                                                          fontSize: 16,
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                      )),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    'Giá: ${product.variants[0].price} VND',
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text(
                                                    'Đã bán: ${product.sold}',
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Row(
                                                children: [
                                                  Icon(
                                                    Icons.location_on,
                                                    size: 15,
                                                    color: Colors.white,
                                                  ),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  Text(
                                                    product.address.toString(),
                                                    style: TextStyle(
                                                      fontSize: 10,
                                                      color: Colors.white,
                                                      overflow:
                                                          TextOverflow.ellipsis,
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
                              }),
                        ),
                        // Hiển thị các chấm để biểu thị trang hiện tại
                        new DotsIndicator(
                          dotsCount: _vt1,
                          position: _currentPage.toInt(),
                          decorator: DotsDecorator(
                            size: const Size.square(9.0),
                            activeSize: const Size(18.0, 9.0),
                            activeShape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0)),
                          ),
                        ),

                        Container(
                          height: 10,
                          color: Colors.grey[300],
                        ),
                        // Phổ biến
                        Container(
                          margin: EdgeInsets.only(left: 20, right: 20),
                          padding: EdgeInsets.only(top: 10, bottom: 10),
                          alignment: Alignment.centerLeft,
                          child: BigText(
                            '',
                            text: "Phổ biến",
                          ),
                        ),

                        Container(
                          height: 400,
                          child: productProvider.popularproducts.isEmpty
                              ? Center(
                                  child: Text(
                                    'Không tìm thấy sản phẩm nào',
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.grey),
                                  ),
                                )
                              : GridView.builder(
                                  padding: EdgeInsets.all(10),
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 10,
                                    mainAxisSpacing: 10,
                                    childAspectRatio: 0.8,
                                  ),
                                  itemCount: _vt2,
                                  itemBuilder: (context, index) {
                                    final product = productProvider
                                        .popularproducts[index + _vt1];
                                    return _buildProductCard(product);
                                  },
                                ),
                        ),
                      ],
                    ),
                  ))),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {},
            shape: const CircleBorder(),
            backgroundColor: Colors.orange,
            child: Icon(
              Icons.home,
              color: Colors.white,
              size: 35,
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
        );
      }),
    );
  }

  Widget _buildProductCard(ProductModel product) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 3,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailProduct(
                productId: product.id,
                role: 'customer',
              ),
            ),
          );
        },
        child: Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: const Color.fromARGB(255, 45, 44, 44),
                width: 1,
              ),
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Stack(children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Hình ảnh sản phẩm
                Container(
                  height: 158,
                  width: double.maxFinite,
                  padding: EdgeInsets.all(5),
                  // child: ClipRRect(
                  //   borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                  //   child: Image.network(
                  //     product.img,
                  //     height: 180,
                  //     width: double.infinity,
                  //     fit: BoxFit.cover,
                  //   ),
                  // ),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/image/banhmi.png"),
                      fit: BoxFit.cover,
                    ),
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(10)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Tên sản phẩm
                      Text(
                        product.name,
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 5),
                      // Giá sản phẩm

                      Text(
                        '${product.variants[0].price.toString()}VND',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.blueAccent,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(width: 15),

                      SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _Stars(product.rating, Colors.black),
                          Text(
                            'Lượt bán: ${product.sold} ',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              right: 0,
              top: 0,
              child: Container(
                height: 20,
                width: 40,
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 255, 255, 255),
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                  ),
                ),
                child: Text(
                  '-${product.variants[0].discount}%',
                  style: TextStyle(
                    color: const Color.fromARGB(255, 255, 0, 0),
                    fontSize: 12,
                  ),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}

Widget InputBox(
    {required String hint,
    required TextEditingController txtController,
    required bool isSecured,
    required double width}) {
  return Container(
    height: 20,
    width: width,
    padding: const EdgeInsets.symmetric(horizontal: 15),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
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

Widget _Stars(double rating, Color color) {
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: List.generate(5, (index) {
      return Icon(
        index + 1 <= rating
            ? Icons.star // Sao đầy
            : index + 1 - rating < 1
                ? Icons.star_half // Sao nửa
                : Icons.star_border, // Sao rỗng
        color: color, // Màu sao
        size: 10,
      );
    }),
  );
}
