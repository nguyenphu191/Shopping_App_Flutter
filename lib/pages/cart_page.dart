import 'package:flutter/material.dart';
import 'package:flutter_shopping_app/data/app_data.dart' as app_data;
import 'package:flutter_shopping_app/models/cart_item.dart';
import 'package:flutter_shopping_app/providers/cart_provider.dart';
import 'package:flutter_shopping_app/widgets/big_text.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    List<CartItem> cartList = app_data.cartList;
    // CartItem cartItem=CartItem(product: product, quantity: 1);
    return Scaffold(
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
          // SizedBox(
          //   height: 10,
          // ),
          cartList.length > 0
              ? Positioned(
                  left: 10,
                  right: 10,
                  bottom: 10,
                  child: Container(
                    height: 640,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 228, 234, 234),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListView.builder(
                      itemCount: cartList.length,
                      itemBuilder: (context, index) {
                        CartItem item = cartList[index];
                        return InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, '/detail');
                          },
                          child: Container(
                            width: 200,
                            height: 100,
                            margin: EdgeInsets.only(top: 10, bottom: 10),
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 252, 252, 252),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: 100,
                                  height: 100,
                                  margin: EdgeInsets.only(left: 10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(
                                      image: AssetImage(item.product.img),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 15, top: 10),
                                  child: Column(
                                    children: [
                                      Text(
                                        item.product.name,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 20,
                                        ),
                                      ),
                                      Text(
                                        '${item.product.price} VND',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Column(
                                  children: [
                                    Container(
                                      height: 40,
                                      margin:
                                          EdgeInsets.only(top: 10, right: 10),
                                      child: Row(
                                        children: [
                                          IconButton(
                                            onPressed: () {},
                                            icon: Icon(Icons.remove),
                                          ),
                                          Text(
                                            item.quantity.toString(),
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 15,
                                            ),
                                          ),
                                          IconButton(
                                            onPressed: () {},
                                            icon: Icon(Icons.add),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                        height: 30,
                                        margin: EdgeInsets.only(
                                            bottom: 20, right: 10),
                                        child: IconButton(
                                          onPressed: () {
                                            app_data.cartList.remove(item);
                                            Get.snackbar('Remove item',
                                                'Remove item success');
                                          },
                                          icon: Icon(Icons.delete),
                                        )),
                                  ],
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                )
              //Xu ly khi gio hang rong
              : Container(
                  margin: EdgeInsets.only(top: 100),
                  child: Center(
                    child: Text('Giỏ hàng trống'),
                  ),
                ),
          //Khung tổng tiền
          Positioned(
            left: 10,
            right: 10,
            bottom: 0,
            child: Container(
              margin: EdgeInsets.only(left: 10, right: 10),
              height: 150,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 255, 255, 255),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 10),
                          child: Text(
                            'Tổng tiền sản phẩm:',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 10),
                          child: Text(
                            '10000 VND',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 10),
                          child: Text(
                            'Phí vận chuyển:',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 10),
                          child: Text(
                            '10000 VND',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 10),
                          child: Text(
                            'Số tiền thanh toán:',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 10),
                          child: Text(
                            '110000 VND',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Center(
                      child: InkWell(
                    onTap: () {},
                    child: Container(
                      margin: EdgeInsets.only(top: 15),
                      padding: EdgeInsets.only(
                        left: 15,
                        right: 10,
                        top: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 45, 201, 219),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      height: 40,
                      width: 120,
                      child: BigText('', text: 'Đặt hàng'),
                    ),
                  ))
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
