import 'package:flutter/material.dart';
import 'package:flutter_shopping_app/models/CartItem.dart';
import 'package:flutter_shopping_app/models/Order.dart';
import 'package:flutter_shopping_app/provider/OrderProvider.dart';
import 'package:flutter_shopping_app/provider/ReviewProvider.dart';
import 'package:flutter_shopping_app/widgets/big_text.dart';
import 'package:flutter_shopping_app/widgets/small_text.dart';
import 'package:provider/provider.dart';

class OrderDetailPage extends StatefulWidget {
  final OrderModel order;

  const OrderDetailPage({super.key, required this.order});

  @override
  State<OrderDetailPage> createState() => _OrderDetailPageState();
}

class _OrderDetailPageState extends State<OrderDetailPage> {
  String _status = '';
  TextEditingController _reviewController = TextEditingController();
  int _rating = 0;
  bool _clickRV = false;

  void _getStatus() {
    if (widget.order.status == 'pendingadmin') {
      _status = 'Chờ xác nhận từ hệ thống';
    } else if (widget.order.status == 'pendingseller') {
      _status = 'Chờ xác nhận từ nhà bán hàng';
    } else if (widget.order.status == 'delivering') {
      _status = 'Đang giao hàng';
    } else if (widget.order.status == 'delivered') {
      _status = 'Đã hoàn thành';
    } else if (widget.order.status == 'cancelled') {
      _status = 'Đã hủy';
    }
  }

  Future<void> _updateOrder(String status) async {
    final orderProvider = Provider.of<OrderProvider>(context, listen: false);
    final response = await orderProvider.updateOrder(widget.order.id, status);
    if (response['status'] == "success") {
      setState(() {
        widget.order.status = 'delivered';
        _getStatus();
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Cập nhật đơn hàng thành công'),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 1),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Cập nhật đơn hàng thất bại'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 1),
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _getStatus();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
                'Thông tin đơn hàng',
                style: TextStyle(fontSize: 25),
              ),
              centerTitle: true,
            ),
          ),
          body:
              Consumer<OrderProvider>(builder: (context, orderProvider, child) {
            if (orderProvider.isLoading) {
              return Center(child: CircularProgressIndicator());
            }
            return Stack(children: [
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  height: MediaQuery.of(context).size.height - 120,
                  width: double.maxFinite,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Thông tin đơn hàng
                          Container(
                            height: 220,
                            width: double.maxFinite,
                            padding: EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.red,
                              ),
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 1,
                                  blurRadius: 5,
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Đơn hàng ',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                  ),
                                ),
                                SizedBox(height: 10),
                                SmallText('',
                                    text: 'Ngày đặt: ${widget.order.time}'),
                                SizedBox(height: 10),
                                SmallText('',
                                    text:
                                        'Ngày hoàn thành: ${widget.order.dateComplete}'),
                                SizedBox(height: 10),
                                SmallText('', text: 'Trạng thái: ${_status}'),
                                SizedBox(height: 10),
                                SmallText('',
                                    text:
                                        'Phương thức thanh toán: ${widget.order.methodPayment}'),
                                SizedBox(height: 10),
                                BigText('',
                                    text: 'Tổng tiền: ${widget.order.total}'),
                              ],
                            ),
                          ),
                          SizedBox(height: 20),
                          // Thông tin sản phẩm
                          Text(
                            'Sản phẩm đã đặt',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 10),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: widget.order.cartList.length,
                            itemBuilder: (context, index) {
                              CartItem item = widget.order.cartList[index];

                              return Container(
                                height: 82,
                                width: MediaQuery.of(context).size.width,
                                margin: EdgeInsets.only(bottom: 10),
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: Colors.grey,
                                    width: 1,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.2),
                                      spreadRadius: 1,
                                      blurRadius: 5,
                                    ),
                                  ],
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 60,
                                      height: 60,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        color: const Color.fromARGB(
                                            255, 255, 0, 0),
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          item.product.name,
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text('Số lượng: ${item.quantity}',
                                                style: TextStyle(fontSize: 12)),
                                            SizedBox(width: 10),
                                            Text('Giá: ${item.price}',
                                                style: TextStyle(fontSize: 12)),
                                          ],
                                        ),
                                        SizedBox(height: 5),
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width -
                                              150,
                                          child: Text('D/c: ${item}',
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  overflow:
                                                      TextOverflow.ellipsis)),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                          SizedBox(height: 20),

                          Text(
                            'Thông tin giao hàng',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text('Tên người nhận: ${widget.order.reciever}'),
                          Text('Địa chỉ: ${widget.order.address}'),
                          Text('Số điện thoại: ${widget.order.phone}'),
                          SizedBox(height: 10),
                          Consumer<ReviewProvider>(
                              builder: (context, reviewProvider, child) {
                            if (reviewProvider.isLoading) {
                              return Center(child: CircularProgressIndicator());
                            }
                            return widget.order.status != "delivered"
                                ? Container(
                                    height: 0,
                                  )
                                : Container(
                                    height: 200,
                                    child: widget.order.rating == true
                                        ? Container(
                                            height: 70,
                                            child: Center(
                                                child: Text(
                                              "Đã đánh giá",
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.green,
                                                  fontWeight: FontWeight.bold),
                                            )))
                                        : (AnimatedContainer(
                                            duration:
                                                Duration(milliseconds: 300),
                                            height: _clickRV ? 200.0 : 70.0,
                                            padding: EdgeInsets.all(5),
                                            curve: Curves.easeInOut,
                                            child: _clickRV == true
                                                ? Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Row(
                                                            children:
                                                                List.generate(5,
                                                                    (index) {
                                                              return IconButton(
                                                                icon: Icon(
                                                                  Icons.star,
                                                                  size: 30,
                                                                  color: _rating >
                                                                          index
                                                                      ? Colors
                                                                          .yellow
                                                                      : Colors
                                                                          .grey,
                                                                ),
                                                                onPressed: () {
                                                                  setState(() {
                                                                    _rating =
                                                                        index +
                                                                            1;
                                                                  });
                                                                },
                                                              );
                                                            }),
                                                          ),
                                                          IconButton(
                                                            icon: Transform
                                                                .rotate(
                                                              angle: 3.14159,
                                                              child: Icon(
                                                                Icons
                                                                    .send_sharp,
                                                                color:
                                                                    Colors.blue,
                                                                size: 30,
                                                              ),
                                                            ),
                                                            onPressed: () {
                                                              String review =
                                                                  _reviewController
                                                                      .text;
                                                              if (_rating ==
                                                                      0 ||
                                                                  review
                                                                      .isEmpty) {
                                                                ScaffoldMessenger.of(
                                                                        context)
                                                                    .showSnackBar(
                                                                  SnackBar(
                                                                    content: Text(
                                                                        'Nhập đánh giá'),
                                                                    backgroundColor:
                                                                        Colors
                                                                            .red,
                                                                  ),
                                                                );
                                                              } else {
                                                                for (int i = 0;
                                                                    i <
                                                                        widget
                                                                            .order
                                                                            .cartList
                                                                            .length;
                                                                    i++) {
                                                                  reviewProvider.addReview(
                                                                      widget
                                                                          .order
                                                                          .cartList[
                                                                              i]
                                                                          .product
                                                                          .id,
                                                                      widget
                                                                          .order
                                                                          .userID,
                                                                      widget
                                                                          .order
                                                                          .id,
                                                                      _rating
                                                                          .toDouble(),
                                                                      review);
                                                                }
                                                              }
                                                              setState(() {
                                                                _clickRV =
                                                                    false;
                                                                widget.order
                                                                        .rating =
                                                                    true;
                                                              });
                                                            },
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(height: 5),
                                                      TextField(
                                                        controller:
                                                            _reviewController,
                                                        decoration:
                                                            InputDecoration(
                                                          hintText:
                                                              "Nhập đánh giá của bạn ở đây...",
                                                          filled: true,
                                                          fillColor:
                                                              Colors.white,
                                                          border:
                                                              OutlineInputBorder(),
                                                        ),
                                                        maxLines: 3,
                                                      ),
                                                      SizedBox(height: 5),
                                                    ],
                                                  )
                                                : Center(
                                                    child: InkWell(
                                                      onTap: () {
                                                        setState(() {
                                                          _clickRV = true;
                                                        });
                                                      },
                                                      child: Container(
                                                        height: 40,
                                                        width: double.maxFinite,
                                                        alignment:
                                                            Alignment.center,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors.blue,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(12),
                                                          border: Border.all(
                                                            color: Colors.white,
                                                            width: 1,
                                                          ),
                                                          boxShadow: [
                                                            BoxShadow(
                                                              color: Colors.grey
                                                                  .withOpacity(
                                                                      0.2),
                                                              spreadRadius: 1,
                                                              blurRadius: 5,
                                                            ),
                                                          ],
                                                        ),
                                                        child: Text(
                                                          "Đánh giá",
                                                          style: TextStyle(
                                                            fontSize: 20,
                                                            color: Colors.white,
                                                          ),
                                                          textAlign:
                                                              TextAlign.center,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                          )),
                                  );
                          }),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ]);
          }),
          bottomNavigationBar: Container(
            child: widget.order.status == "delivered"
                ? Container(height: 0)
                : Container(
                    height: 70,
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () {
                            if (widget.order.status == 'pendingadmin' ||
                                widget.order.status == 'pendingseller') {
                              _updateOrder("cancelled");
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content:
                                      Text('Đơn hàng đang giao, không thể hủy'),
                                  backgroundColor: Colors.red,
                                  duration: Duration(seconds: 1),
                                ),
                              );
                            }
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width / 2,
                            padding: EdgeInsets.only(top: 10),
                            color: Colors.red,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.close,
                                  color: Colors.white,
                                ),
                                SizedBox(height: 5),
                                Text(
                                  "Hủy",
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.white),
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
                              if (widget.order.status == 'delivering') {
                                _updateOrder("delivered");
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                        'Đơn hàng chưa giao, không thể xác nhận'),
                                    backgroundColor: Colors.red,
                                    duration: Duration(seconds: 1),
                                  ),
                                );
                              }
                            },
                            child: Container(
                              padding: EdgeInsets.only(top: 10),
                              color: Colors.green,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.done,
                                    color: Colors.white,
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    "Đã nhận",
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
                  ),
          )),
    );
  }
}
