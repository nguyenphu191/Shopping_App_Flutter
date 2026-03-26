import 'package:flutter/material.dart';
import 'package:flutter_shopping_app/view_models/auth_view_model.dart';
import 'package:flutter_shopping_app/view_models/order_view_model.dart';
import 'package:flutter_shopping_app/view_models/user_view_model.dart';
import 'package:flutter_shopping_app/widgets/big_text.dart';
import 'package:provider/provider.dart';

class OrderScreen extends StatefulWidget {
  final List<String> cartItems;
  const OrderScreen({super.key, required this.cartItems});
  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _receiver = new TextEditingController();
  TextEditingController _phone = new TextEditingController();
  TextEditingController _address = new TextEditingController();
  bool _useDefaultAddress = true;
  String _methodPayment = "Cash on Delivery";

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final orderProvider = Provider.of<OrderViewModel>(context, listen: false);
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
    final orderProvider = Provider.of<OrderViewModel>(context, listen: false);
    final user = Provider.of<AuthViewModel>(context, listen: false);

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
              child: Consumer<OrderViewModel>(
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
                          "Tổng thanh toán: ${orderProvider.total.toStringAsFixed(0)} VND",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.redAccent),
                        ),
                        SizedBox(height: 6),
                        Consumer<AuthViewModel>(
                          builder: (context, auth, _) {
                            final balance = auth.user?.balance ?? 0.0;
                            final enough = balance >= orderProvider.total;
                            return Row(
                              children: [
                                Text(
                                  "Số dư ví: ${balance.toStringAsFixed(0)} VND",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: enough ? Colors.green[700] : Colors.red,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(width: 8),
                                if (!enough)
                                  Text(
                                    "(Không đủ)",
                                    style: TextStyle(fontSize: 12, color: Colors.red),
                                  ),
                              ],
                            );
                          },
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
                onTap: () async {
                  if (!_formKey.currentState!.validate()) return;

                  final currentUser = user.user!;
                  final total = orderProvider.total;
                  final messenger = ScaffoldMessenger.of(context);
                  final nav = Navigator.of(context);
                  final userVM = Provider.of<UserViewModel>(context, listen: false);

                  // Kiểm tra số dư
                  if (currentUser.balance < total) {
                    messenger.showSnackBar(SnackBar(
                      content: Text(
                        "Số dư không đủ. Cần ${total.toStringAsFixed(0)} VND, hiện có ${currentUser.balance.toStringAsFixed(0)} VND",
                      ),
                      backgroundColor: Colors.red,
                      duration: Duration(seconds: 2),
                    ));
                    return;
                  }

                  // Trừ tiền từ ví
                  final deducted = await userVM.deductBalance(currentUser.id, total);
                  if (!deducted) {
                    messenger.showSnackBar(SnackBar(
                      content: Text("Thanh toán thất bại, thử lại"),
                      backgroundColor: Colors.red,
                      duration: Duration(seconds: 2),
                    ));
                    return;
                  }

                  // Tạo đơn hàng
                  final value = await orderProvider.createOrder(
                    widget.cartItems,
                    currentUser.id,
                    _methodPayment,
                    true,
                    _receiver.text,
                    _phone.text,
                    total,
                    _useDefaultAddress
                        ? currentUser.address.toString()
                        : _address.text,
                  );

                  if (value['status'] == 'success') {
                    messenger.showSnackBar(SnackBar(
                      content: Text("Đặt hàng thành công"),
                      backgroundColor: Colors.green,
                      duration: Duration(seconds: 1),
                    ));
                    nav.pop(true);
                  } else {
                    messenger.showSnackBar(SnackBar(
                      content: Text("Đặt hàng thất bại"),
                      backgroundColor: Colors.red,
                      duration: Duration(seconds: 1),
                    ));
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
