import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shopping_app/provider/AuthProvider.dart';
import 'package:flutter_shopping_app/provider/OrderProvider.dart';
import 'package:flutter_shopping_app/widgets/big_text.dart';
import 'package:provider/provider.dart';

class OrderPage extends StatefulWidget {
  final List<String> cartItems;
  const OrderPage({super.key, required this.cartItems});
  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _receiver = new TextEditingController();
  TextEditingController _phone = new TextEditingController();
  TextEditingController _address = new TextEditingController();
  bool _useDefaultAddress = true;
  String _methodPayment = "Cash on Delivery";
  bool _isPaymented = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final orderProvider = Provider.of<OrderProvider>(context, listen: false);
      orderProvider.getInfor(widget.cartItems);
    });
  }

  @override
  void dispose() {
    _receiver.dispose();
    _phone.dispose();
    _address.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final orderProvider = Provider.of<OrderProvider>(context, listen: false);
    final user = Provider.of<AuthProvider>(context, listen: false);

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
            'Thông tin đặt hàng',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
      ),
      body: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/image/bgs1.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Stack(children: [
            Positioned(
              top: 50,
              left: 15,
              right: 15,
              bottom: 90,
              child: Consumer<OrderProvider>(
                  builder: (context, orderProvider, child) {
                if (orderProvider.isLoading) {
                  return Center(child: CircularProgressIndicator());
                }
                return Container(
                  width: double.maxFinite,
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 255, 255, 255)
                        .withOpacity(0.85),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Danh sách sản phẩm",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[250],
                            border: Border.all(
                                color: const Color.fromARGB(255, 255, 0, 0)),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: EdgeInsets.all(10),
                          child: ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: orderProvider.cartItems.length,
                            itemBuilder: (context, index) {
                              final item = orderProvider.cartItems[index];

                              return Container(
                                height: 70,
                                margin: EdgeInsets.only(bottom: 10),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border(
                                    bottom: BorderSide(
                                      color:
                                          const Color.fromARGB(255, 45, 44, 44),
                                      width: 1,
                                    ),
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 60,
                                      height: 60,
                                      margin: EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                      child: Image.network(
                                        'https://platform.polygon.com/wp-content/uploads/sites/2/chorus/uploads/chorus_asset/file/23612838/5265_SeriesHeaders_OP_2000x800_wm.jpg?quality=90&strip=all&crop=18.85,0,40,100',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            item.product.name,
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            "${item.quantity} x ${item.price} VND",
                                            style: TextStyle(
                                              fontSize: 14,
                                            ),
                                          ),
                                        ])
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                        SizedBox(height: 10),
                        Divider(),
                        SizedBox(height: 10),
                        // Tổng tiền cần thanh toán
                        Text(
                          "Tổng thanh toán: ${orderProvider.total} VND",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.redAccent),
                        ),

                        SizedBox(height: 20),

                        // Thông tin người nhận

                        Text(
                          "Thông tin người nhận",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),

                        SizedBox(height: 10),
                        Form(
                            key: _formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildTextField(
                                  controller: _receiver,
                                  label: "Tên người nhận",
                                  hint: "Nhập tên người nhận",
                                  keyboardType: TextInputType.text,
                                ),
                                SizedBox(height: 10),
                                _buildTextField(
                                  controller: _phone,
                                  label: "Số điện thoại",
                                  hint: "Nhập số điện thoại",
                                  keyboardType: TextInputType.phone,
                                ),
                                SizedBox(height: 10),
                                CheckboxListTile(
                                  value: _useDefaultAddress,
                                  onChanged: (value) {
                                    setState(() {
                                      _useDefaultAddress = value!;
                                    });
                                  },
                                  title: Text("Sử dụng địa chỉ mặc định"),
                                ),
                                if (!_useDefaultAddress)
                                  _buildTextField(
                                    controller: _address,
                                    label: "Địa chỉ",
                                    hint: "Nhập địa chỉ",
                                    keyboardType: TextInputType.text,
                                    maxLines: 3,
                                  ),
                                SizedBox(height: 20),

                                // Phương thức thanh toán
                                Text(
                                  "Phương thức thanh toán",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 10),
                                DropdownButtonFormField<String>(
                                  value: _methodPayment,
                                  onChanged: (value) {
                                    setState(() {
                                      _methodPayment = value!;
                                    });
                                  },
                                  items: [
                                    DropdownMenuItem(
                                      value: "Cash on Delivery",
                                      child: Text("Thanh toán khi nhận hàng"),
                                    ),
                                    DropdownMenuItem(
                                      value: "Credit Card",
                                      child:
                                          Text("Thanh toán bằng thẻ tín dụng"),
                                    ),
                                    DropdownMenuItem(
                                      value: "Bank Transfer",
                                      child: Text("Chuyển khoản ngân hàng"),
                                    ),
                                  ],
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: "Chọn phương thức thanh toán",
                                  ),
                                ),
                              ],
                            )),

                        SizedBox(height: 30),
                      ],
                    ),
                  ),
                );
              }),
            ),
            Positioned(
              bottom: 15,
              left: 0,
              right: 0,
              child: Center(
                  child: InkWell(
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    orderProvider
                        .createOrder(
                      widget.cartItems,
                      user.user!.id,
                      _methodPayment,
                      _isPaymented,
                      _receiver.text,
                      _phone.text,
                      orderProvider.total,
                      _useDefaultAddress
                          ? user.user!.address.toString()
                          : _address.text,
                    )
                        .then((value) {
                      if (value['status'] == 'success') {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Đặt hàng thành công"),
                            backgroundColor: Colors.green,
                            duration: Duration(seconds: 1),
                          ),
                        );
                        Navigator.pop(context, true);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Đặt hàng thất bại"),
                            backgroundColor: Colors.red,
                            duration: Duration(seconds: 1),
                          ),
                        );
                      }
                    });
                  }
                },
                child: Container(
                  padding: EdgeInsets.only(
                    left: 15,
                    right: 10,
                    top: 6,
                  ),
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color.fromARGB(255, 242, 88, 11),
                          Color.fromARGB(255, 255, 30, 0),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: const Color.fromARGB(255, 76, 74, 74)
                              .withOpacity(0.5),
                          spreadRadius: 3,
                          blurRadius: 6,
                          offset: Offset(0, 6),
                        ),
                      ]),
                  height: 40,
                  width: 130,
                  child: BigText(
                    '',
                    text: 'ĐẶT HÀNG',
                    color: Colors.white,
                  ),
                ),
              )),
            ),
          ])),
    );
  }
}

Widget _buildTextField({
  required TextEditingController controller,
  required String label,
  required String hint,
  TextInputType keyboardType = TextInputType.text,
  int maxLines = 1,
}) {
  return TextFormField(
    controller: controller,
    decoration: InputDecoration(
      labelText: label,
      hintText: hint,
      hintStyle: TextStyle(color: const Color.fromARGB(255, 0, 0, 0)),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    ),
    keyboardType: keyboardType,
    maxLines: maxLines,
    validator: (value) {
      if (value == null || value.isEmpty) {
        return 'Vui lòng nhập $label';
      }
      return null;
    },
  );
}
