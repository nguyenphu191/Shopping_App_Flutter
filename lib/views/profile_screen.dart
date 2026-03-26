import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shopping_app/models/user.dart';
import 'package:flutter_shopping_app/models/address.dart';
import 'package:flutter_shopping_app/view_models/user_view_model.dart';
import 'package:flutter_shopping_app/widgets/big_text.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  final User user;
  const ProfileScreen({super.key, required this.user});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _streetController = TextEditingController();
  TextEditingController _districtController = TextEditingController();
  TextEditingController _cityController = TextEditingController();
  TextEditingController _countryController = TextEditingController();

  Future<void> _updateName() async {
    final response = await Provider.of<UserViewModel>(context, listen: false).updateUser(
      userId: widget.user.id,
      username: _nameController.text,
    );
    if (response["status"] == "success") {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Cập nhật thành công'),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 1),
      ));
      setState(() {
        widget.user.username = response["updatedUser"]["username"];
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Cập nhật thất bại'),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 1),
      ));
    }
  }

  Future<void> _updatePhone() async {
    final response = await Provider.of<UserViewModel>(context, listen: false).updateUser(
      userId: widget.user.id,
      phone: _phoneController.text,
    );
    if (response["status"] == "success") {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Cập nhật thành công'),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 1),
      ));
      setState(() {
        widget.user.phone = response["updatedUser"]["phone"];
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Cập nhật thất bại'),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 1),
      ));
    }
  }

  Future<void> _updateEmail() async {
    final response = await Provider.of<UserViewModel>(context, listen: false).updateUser(
      userId: widget.user.id,
      email: _emailController.text,
    );
    if (response["status"] == "success") {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Cập nhật thành công'),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 1),
      ));
      setState(() {
        widget.user.username = response["updatedUser"]["email"];
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Cập nhật thất bại'),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 1),
      ));
    }
  }

  Future<void> _updateAddress() async {
    final Map<String, dynamic> _address = {
      "street": _streetController.text,
      "district": _districtController.text,
      "city": _cityController.text,
      "country": _countryController.text,
    };

    final response = await Provider.of<UserViewModel>(context, listen: false).updateUser(
      userId: widget.user.id,
      address: _address,
    );
    if (response["status"] == "success") {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Cập nhật thành công'),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 1),
      ));
      setState(() {
        widget.user.address = Address(
          street: response["updatedUser"]["address"]["street"],
          district: response["updatedUser"]["address"]["district"],
          city: response["updatedUser"]["address"]["city"],
          country: response["updatedUser"]["address"]["country"],
        ) ;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Cập nhật thất bại'),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 1),
      ));
    }
  }

  Future<void> delete() async {
    final response = await Provider.of<UserViewModel>(context, listen: false).deleteUser(widget.user.id);
    if (response["status"] == "success") {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Xóa tài khoản thành công'),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 1),
      ));
      context.go('/');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Xóa tài khoản thất bại'),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 1),
      ));
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(80),
          child: AppBar(
            backgroundColor: Color.fromARGB(255, 252, 100, 54),
            toolbarHeight: 80,
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () => Navigator.pop(context),
            ),
            title: const Text(
              'Thông tin cá nhân',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            centerTitle: true,
            actions: [
              Container(
                height: 40,
                width: 40,
                child: PopupMenuButton<String>(
                  itemBuilder: (BuildContext context) {
                    return <PopupMenuEntry<String>>[
                      PopupMenuItem<String>(
                        value: 'changePassword',
                        child: BigText('', text: 'Thay đổi mật khẩu', size: 15),
                      ),
                      PopupMenuItem<String>(
                        value: 'deleteAccount',
                        child: BigText('', text: 'Xóa tài khoản', size: 15),
                      ),
                    ];
                  },
                  onSelected: (String value) {
                    // Xử lý khi lựa chọn một mục trong danh sách
                    if (value == 'changePassword') {
                      context.push('/signup');
                    } else if (value == 'deleteAccount') {
                      delete();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
        body: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              color: Colors.grey[200],
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                margin: const EdgeInsets.only(top: 20),
                child: Row(
                  children: [
                    Container(
                      height: 140,
                      width: 140,
                      margin: const EdgeInsets.only(top: 10, left: 100),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(60),
                        image: DecorationImage(
                          image: AssetImage('assets/image/nam_avatar.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.camera_alt),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 70,
              left: 10,
              right: 10,
              top: 200,
              child: Container(
                height: 400,
                width: double.maxFinite,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.green.shade200),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.account_balance_wallet, color: Colors.green[700]),
                            const SizedBox(width: 12),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Số dư ví', style: TextStyle(fontSize: 12, color: Colors.grey)),
                                Text(
                                  '${widget.user.balance.toStringAsFixed(0)} VND',
                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.green[700]),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      _buildInfoCard(
                        icon: Icons.person,
                        label: 'Tên người dùng',
                        value: widget.user.username,
                        controller: _nameController,
                        hint: 'Nhập tên mới của bạn',
                      ),
                      _buildInfoCard(
                        icon: Icons.phone,
                        label: 'Số điện thoại',
                        value: widget.user.phone,
                        controller: _phoneController,
                        hint: 'Nhập số điện thoại mới của bạn',
                      ),
                      _buildInfoCard(
                        icon: Icons.email,
                        label: 'Email',
                        value: widget.user.email,
                        controller: _emailController,
                        hint: 'Nhập email mới của bạn',
                      ),
                      _buildInfoCard2(
                        icon: Icons.location_city,
                        label: 'Thành phố',
                        value: widget.user.address.toString(),
                        controller1: _streetController,
                        controller2: _districtController,
                        controller3: _cityController,
                        controller4: _countryController,
                        hint: 'Nhập địa chỉ mới của bạn',
                      ),
                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          shape: const CircleBorder(),
          backgroundColor: Colors.orange,
          child: FaIcon(
            FontAwesomeIcons.user,
            color: const Color.fromARGB(255, 255, 255, 255),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
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
                onPressed: () => context.go('/home'),
                icon: FaIcon(FontAwesomeIcons.home),
              ),
              IconButton(
                onPressed: () => context.push('/all-products'),
                icon: FaIcon(FontAwesomeIcons.bagShopping),
              ),
              IconButton(
                onPressed: () => context.push('/cart'),
                icon: FaIcon(FontAwesomeIcons.shoppingCart),
              ),
              IconButton(
                onPressed: () => context.push('/orders'),
                icon: FaIcon(FontAwesomeIcons.truck),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoCard({
    required IconData icon,
    required String label,
    required String value,
    required TextEditingController controller,
    required String hint,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.8),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey),
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(255, 72, 70, 70).withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(icon, size: 30, color: Colors.blue),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.edit, color: Colors.blue),
            onPressed: () {
              _showEditDialog(label, hint, controller);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard2({
    required IconData icon,
    required String label,
    required String value,
    required TextEditingController controller1,
    required TextEditingController controller2,
    required TextEditingController controller3,
    required TextEditingController controller4,
    required String hint,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.8),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey),
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(255, 112, 108, 108).withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(icon, size: 30, color: Colors.blue),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.edit, color: Colors.blue),
            onPressed: () {
              _showEditDialog2(
                  label, controller1, controller2, controller3, controller4);
            },
          ),
        ],
      ),
    );
  }

  void _showEditDialog(
      String title, String hint, TextEditingController controller) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Chỉnh sửa $title'),
          content: _buildInputBox(hint: hint, controller: controller),
          actions: [
            TextButton(
              onPressed: () {
                if (title == 'Tên người dùng') {
                  _updateName();
                } else if (title == 'Số điện thoại') {
                  _updatePhone();
                } else if (title == 'Email') {
                  _updateEmail();
                }
                Navigator.pop(context);
              },
              child: const Text('Lưu'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Hủy'),
            ),
          ],
        );
      },
    );
  }

  void _showEditDialog2(
      String title,
      TextEditingController controller1,
      TextEditingController controller2,
      TextEditingController controller3,
      TextEditingController controller4) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Chỉnh sửa $title'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildInputBox(hint: "Địa chỉ cụ thể", controller: controller1),
                const SizedBox(height: 10),
                _buildInputBox(hint: 'Quận/Huyện', controller: controller2),
                const SizedBox(height: 10),
                _buildInputBox(hint: 'Tỉnh/Thành Phố', controller: controller3),
                const SizedBox(height: 10),
                _buildInputBox(hint: 'Quốc gia', controller: controller4),
                const SizedBox(height: 10),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                _updateAddress();
                Navigator.pop(context);
              },
              child: const Text('Lưu'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Hủy'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildInputBox(
      {required String hint, required TextEditingController controller}) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hint,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
