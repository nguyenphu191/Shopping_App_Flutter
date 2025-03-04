import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_shopping_app/models/Product.dart';
import 'package:flutter_shopping_app/models/Review.dart';
import 'package:flutter_shopping_app/models/User.dart';
import 'package:flutter_shopping_app/pages/Customer/CartPage.dart';
import 'package:flutter_shopping_app/pages/Seller/HomeStore.dart';
import 'package:flutter_shopping_app/provider/CartProvider.dart';
import 'package:flutter_shopping_app/provider/ProductProvider.dart';
import 'package:flutter_shopping_app/provider/ReviewProvider.dart';
import 'package:flutter_shopping_app/provider/UserProvider.dart';
import 'package:flutter_shopping_app/provider/VariantProvider.dart';
import 'package:flutter_shopping_app/widgets/big_text.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class DetailProduct extends StatefulWidget {
  final String productId;
  final String role;
  const DetailProduct({
    super.key,
    required this.productId,
    required this.role,
  });

  @override
  State<DetailProduct> createState() => _DetailProductState();
}

class _DetailProductState extends State<DetailProduct> {
  String _selId = "";
  List<User> users = [];
  PageController pageController = PageController();

  var _currentPage = 0.0;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ProductProvider>(context, listen: false)
          .getProduct(widget.productId);
      Provider.of<ReviewProvider>(context, listen: false)
          .getReviews(widget.productId);
    });
    pageController.addListener(() {
      setState(() {
        _currentPage = pageController.page ?? 0;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context, listen: false).user;
    return Scaffold(
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
            'Thông tin sản phẩm',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          actions: [
            IconButton(
              icon: Icon(Icons.shopping_cart, color: Colors.black),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CartPage(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      body:
          Consumer<ProductProvider>(builder: (context, productProvider, child) {
        if (productProvider.isLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        final ProductModel _product = productProvider.product!;
        _selId = _product.SellerID;
        return Stack(
          children: [
            Positioned(
              left: 0,
              right: 0,
              top: 0,
              bottom: 0,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Column(
                      children: [
                        Container(
                          height: 300,
                          child: PageView.builder(
                            controller: pageController,
                            itemCount: _product.imgs.length,
                            itemBuilder: (context, index) {
                              return Image.asset(
                                _product.imgs[index],
                                fit: BoxFit.cover,
                              );
                            },
                          ),
                        ),
                        new DotsIndicator(
                          dotsCount: _product.imgs.length,
                          position: _currentPage.toInt(),
                          decorator: DotsDecorator(
                            size: const Size.square(7.0),
                            activeSize: const Size(18.0, 7.0),
                            activeShape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0)),
                          ),
                        ),
                        Container(
                          width: double.maxFinite,
                          decoration: BoxDecoration(
                            color: Colors.white,
                          ),
                          child: Column(
                            children: [
                              Center(
                                child: Container(
                                  margin: EdgeInsets.only(top: 10),
                                  child: BigText(
                                    '',
                                    text: _product.name,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                              Center(
                                  child: _Stars(_product.rating, Colors.black)),
                              SizedBox(height: 10),
                              Container(
                                height: 10,
                                color: Colors.grey[300],
                              ),
                              Container(
                                margin: EdgeInsets.all(10),
                                child: Column(
                                  children: [
                                    Container(
                                        margin: EdgeInsets.only(
                                            bottom: 10, left: 10, right: 10),
                                        child: Text(
                                          "Thông tin sản phẩm: ",
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: const Color.fromARGB(
                                                255, 0, 0, 0),
                                          ),
                                        )),
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      margin:
                                          EdgeInsets.only(left: 10, bottom: 5),
                                      child: Text(
                                        'Giá: ${_product.variants[0].price}VND',
                                        style: TextStyle(
                                          fontSize: 15,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      margin:
                                          EdgeInsets.only(left: 10, bottom: 5),
                                      child: Text(
                                        'Địa chỉ: ${_product.address.toString()}',
                                        style: TextStyle(
                                          fontSize: 15,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      margin:
                                          EdgeInsets.only(left: 10, bottom: 5),
                                      child: Text(
                                        ' Lượt bán: ${_product.sold}',
                                        style: TextStyle(
                                          fontSize: 15,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      margin:
                                          EdgeInsets.only(left: 10, bottom: 5),
                                      child: Text(
                                        'Tồn kho: ${_product.variants[0].stock}',
                                        style: TextStyle(
                                          fontSize: 15,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      margin:
                                          EdgeInsets.only(left: 10, bottom: 5),
                                      child: Text(
                                        'Danh mục: ${_product.category}',
                                        style: TextStyle(
                                          fontSize: 15,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.all(10),
                                      child: Text(
                                          "Mô tả: ${_product.description}"),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: 10,
                          color: Colors.grey[300],
                        ),
                      ],
                    ),
                    Container(
                      height: 80,
                      color: Colors.white,
                      child: Consumer<UserProvider>(
                        builder: (context, userProvider, child) {
                          if (userProvider.isLoading) {
                            return SizedBox();
                          }
                          userProvider.findUserById(_selId);
                          final sel = userProvider.sel;
                          return Row(
                            children: [
                              Container(
                                margin: EdgeInsets.only(
                                    left: 10, top: 10, bottom: 10),
                                height: 60,
                                width: 60,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  image: DecorationImage(
                                    image: AssetImage(
                                        'assets/image/nam_avatar.png'),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              SizedBox(width: 15),
                              Container(
                                width: 220,
                                padding: EdgeInsets.only(top: 20),
                                child: Column(
                                  children: [
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        sel!.username,
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: 5),
                              Expanded(
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => HomeStorePage(
                                          sellerId: _selId,
                                          role: widget.role,
                                        ),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    height: 20,
                                    margin: EdgeInsets.only(right: 10),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: const Color.fromARGB(
                                            255, 236, 81, 4),
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "Xem Shop",
                                        style: TextStyle(
                                          color: const Color.fromARGB(
                                              255, 236, 81, 4),
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                    Container(
                      height: 10,
                      color: Colors.grey[300],
                    ),
                    Container(
                      color: Colors.white,
                      height: 400,
                      padding: EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Container(
                            height: 50,
                            child: Text(
                              "Đánh giá: ",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: const Color.fromARGB(255, 0, 0, 0),
                              ),
                            ),
                          ),
                          Container(
                            height: 320,
                            decoration: BoxDecoration(
                              color: Colors.grey[100],
                            ),
                            child: Consumer<ReviewProvider>(
                              builder: (context, reviewProvider, child) {
                                if (reviewProvider.isLoading) {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                                final userProvider = Provider.of<UserProvider>(
                                    context,
                                    listen: false);

                                return ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: reviewProvider.reviews.length,
                                  itemBuilder: (context, index) {
                                    return FutureBuilder<User>(
                                      future: userProvider.getUserReview(
                                          reviewProvider.reviews[index].userId),
                                      builder: (context, snapshot) {
                                        if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          return Center(
                                            child: CircularProgressIndicator(),
                                          );
                                        }
                                        final cus = snapshot.data;
                                        return _Comment(
                                            reviewProvider.reviews[index],
                                            cus!);
                                      },
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      }),
      bottomNavigationBar: widget.role == "customer"
          ? Consumer<ProductProvider>(
              builder: (context, productProvider, child) {
              if (productProvider.isLoading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              final ProductModel _product = productProvider.product!;
              final sellerId = _product.SellerID;
              return Container(
                height: 70,
                color: const Color.fromARGB(255, 0, 0, 0), // Nền đen cho thanh
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {
                        // Xử lý sự kiện khi nhấn nút "Chat"
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width / 2,
                        padding: EdgeInsets.only(top: 10),
                        color: const Color.fromARGB(255, 0, 0, 0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            FaIcon(
                              FontAwesomeIcons.message,
                              color: Colors.white,
                            ),
                            SizedBox(height: 5),
                            Text(
                              "Chat",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: 1,
                      height: double.infinity,
                      color: Colors.white, // Đường viền trắng giữa 2 nút
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Provider.of<VariantProvider>(context, listen: false)
                              .reset();
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            barrierColor:
                                Colors.black.withOpacity(0.5), // Làm tối nền
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(20),
                              ),
                            ),
                            builder: (BuildContext context) {
                              return Container(
                                height: MediaQuery.of(context).size.height *
                                    0.5, // Chiếm nửa màn hình
                                padding: EdgeInsets.all(16),
                                child: SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Center(
                                        child: Container(
                                          width: 50,
                                          height: 5,
                                          decoration: BoxDecoration(
                                            color: Colors.grey,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 20),
                                      Text(
                                        'Chọn phân loại và số lượng',
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: 20),
                                      _product.variants.length > 1
                                          ? Consumer<VariantProvider>(builder:
                                              (context, variantProvider,
                                                  child) {
                                              return Column(children: [
                                                Container(
                                                  width: double.maxFinite,
                                                  child: Text(
                                                    "Màu sắc: ",
                                                    style: TextStyle(
                                                      fontSize: 18,
                                                    ),
                                                    textAlign: TextAlign.start,
                                                  ),
                                                ),
                                                SizedBox(height: 5),
                                                Container(
                                                  margin: EdgeInsets.only(
                                                      bottom: 5),
                                                  width: double.maxFinite,
                                                  child: Wrap(
                                                    alignment:
                                                        WrapAlignment.start,
                                                    spacing: 10,
                                                    runSpacing: 10,
                                                    children: List.generate(
                                                      _product.colors.length,
                                                      (index) => InkWell(
                                                        onTap: () {
                                                          variantProvider
                                                              .setColor(index);
                                                        },
                                                        child: Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  right: 10),
                                                          padding:
                                                              EdgeInsets.all(5),
                                                          height: 30,
                                                          width: 80,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: variantProvider
                                                                        .color ==
                                                                    index
                                                                ? Colors
                                                                    .blue[200]
                                                                : Colors
                                                                    .grey[200],
                                                            border: Border.all(
                                                              color: const Color
                                                                  .fromARGB(
                                                                  255, 0, 0, 0),
                                                            ),
                                                          ),
                                                          child: Text(
                                                            _product
                                                                .colors[index],
                                                            style: TextStyle(
                                                              fontSize: 15,
                                                              color:
                                                                  Colors.black,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                            ),
                                                            textAlign: TextAlign
                                                                .center,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(height: 10),
                                                Container(
                                                  width: double.maxFinite,
                                                  child: Text(
                                                    "Kích thước: ",
                                                    style: TextStyle(
                                                      fontSize: 18,
                                                    ),
                                                    textAlign: TextAlign.start,
                                                  ),
                                                ),
                                                SizedBox(height: 5),
                                                Container(
                                                  margin: EdgeInsets.only(
                                                      bottom: 5),
                                                  width: double.maxFinite,
                                                  child: Wrap(
                                                    alignment:
                                                        WrapAlignment.start,
                                                    spacing: 10,
                                                    runSpacing: 10,
                                                    children: List.generate(
                                                      _product.sizes.length,
                                                      (index) => InkWell(
                                                        onTap: () {
                                                          variantProvider
                                                              .setSize(index);
                                                        },
                                                        child: Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  right: 10),
                                                          padding:
                                                              EdgeInsets.all(5),
                                                          height: 30,
                                                          width: 80,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: variantProvider
                                                                        .size ==
                                                                    index
                                                                ? Colors
                                                                    .blue[200]
                                                                : Colors
                                                                    .grey[200],
                                                            border: Border.all(
                                                              color: const Color
                                                                  .fromARGB(
                                                                  255, 0, 0, 0),
                                                            ),
                                                          ),
                                                          child: Text(
                                                            _product
                                                                .sizes[index],
                                                            style: TextStyle(
                                                              fontSize: 15,
                                                              color:
                                                                  Colors.black,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                            ),
                                                            textAlign: TextAlign
                                                                .center,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(height: 15),
                                                Row(
                                                  children: [
                                                    Text(
                                                      'Giá: ',
                                                      style: TextStyle(
                                                        fontSize: 18,
                                                      ),
                                                    ),
                                                    Text(
                                                      '${_product.variants[variantProvider.color * _product.sizes.length + variantProvider.size].price.toStringAsFixed(1)} đ',
                                                      style: TextStyle(
                                                        fontSize: 18,
                                                        color: Colors.red,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(height: 5),
                                                Row(
                                                  children: [
                                                    Container(
                                                      margin: EdgeInsets.only(
                                                          right: 10),
                                                      child: Text(
                                                        'Số lượng: ',
                                                        style: TextStyle(
                                                          fontSize: 18,
                                                        ),
                                                      ),
                                                    ),
                                                    ButtonTheme(
                                                      minWidth: 25,
                                                      height: 25,
                                                      child: ElevatedButton(
                                                        onPressed: () {
                                                          variantProvider
                                                              .increaseQuantity();
                                                        },
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                          shape: CircleBorder(),
                                                        ),
                                                        child: Icon(
                                                          Icons.add,
                                                          color: const Color
                                                              .fromARGB(
                                                              255, 0, 0, 0),
                                                          size: 20,
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(width: 10),
                                                    Container(
                                                      width: 50,
                                                      height: 30,
                                                      decoration: BoxDecoration(
                                                        border: Border.all(
                                                          color: Colors.grey,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                      child: Center(
                                                        child: Text(
                                                          '${variantProvider.quantity}',
                                                          style: TextStyle(
                                                            fontSize: 15,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(width: 10),
                                                    ButtonTheme(
                                                      minWidth: 25,
                                                      height: 25,
                                                      child: ElevatedButton(
                                                        onPressed: () {
                                                          variantProvider
                                                              .decreaseQuantity();
                                                        },
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                          shape: CircleBorder(),
                                                        ),
                                                        child: Icon(
                                                          Icons.remove,
                                                          color: const Color
                                                              .fromARGB(
                                                              255, 0, 0, 0),
                                                          size: 20,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(height: 10),
                                                InkWell(
                                                  onTap: () {
                                                    Provider.of<CartProvider>(
                                                            context,
                                                            listen: false)
                                                        .addToCart(
                                                            user!.id,
                                                            _product.id,
                                                            sellerId,
                                                            _product.colors[
                                                                variantProvider
                                                                    .color],
                                                            _product.sizes[
                                                                variantProvider
                                                                    .size],
                                                            _product
                                                                .variants[variantProvider
                                                                            .color *
                                                                        _product
                                                                            .sizes
                                                                            .length +
                                                                    variantProvider
                                                                        .size]
                                                                .price,
                                                            variantProvider
                                                                .quantity)
                                                        .then((value) {
                                                      if (value['status'] ==
                                                          'success') {
                                                        Navigator.pop(context);
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(
                                                          SnackBar(
                                                            content: Text(
                                                                "Thêm vào giỏ hàng thành công"),
                                                            backgroundColor:
                                                                Colors.green,
                                                            duration: Duration(
                                                                seconds: 1),
                                                          ),
                                                        );
                                                      } else {
                                                        Navigator.pop(context);
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(
                                                          SnackBar(
                                                            content: Text(
                                                                "Thêm vào giỏ hàng thất bại"),
                                                            backgroundColor:
                                                                Colors.red,
                                                            duration: Duration(
                                                                seconds: 1),
                                                          ),
                                                        );
                                                      }
                                                    });
                                                  },
                                                  child: Container(
                                                    height: 40,
                                                    padding: EdgeInsets.all(5),
                                                    width: double.maxFinite,
                                                    decoration: BoxDecoration(
                                                      color: Colors.blue,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                    child: Text(
                                                      'Xác nhận',
                                                      style: TextStyle(
                                                          fontSize: 18,
                                                          color: Colors.white),
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                  ),
                                                )
                                              ]);
                                            })
                                          : SizedBox(),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.only(top: 10),
                          color: const Color.fromARGB(255, 0, 0, 0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              FaIcon(
                                FontAwesomeIcons.cartPlus,
                                color: Colors.white,
                              ),
                              SizedBox(height: 5),
                              Text(
                                "Thêm vào giỏ hàng",
                                style: TextStyle(
                                    fontSize: 12, color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            })
          : SizedBox(
              height: 1,
            ),
    );
  }
}

Widget _Comment(Review rv, User user) {
  return Container(
    margin: EdgeInsets.only(top: 10),
    child: Row(
      children: [
        Container(
          margin: EdgeInsets.only(left: 10),
          child: CircleAvatar(
            radius: 20,
            backgroundImage: AssetImage('assets/image/nam_avatar.png'),
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 10),
          child: Column(
            children: [
              Container(
                child: Text(
                  user.username,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                child: _Stars(rv.rate, Colors.black),
              ),
              Container(
                child: Text(
                  rv.content,
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
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
        size: 12,
      );
    }),
  );
}
