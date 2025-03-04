// import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_shopping_app/models/Address.dart';
import 'package:flutter_shopping_app/provider/AuthProvider.dart';
import 'package:flutter_shopping_app/widgets/big_text.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _roleController = TextEditingController();
  TextEditingController _streetController = TextEditingController();
  TextEditingController _districtController = TextEditingController();
  TextEditingController _cityController = TextEditingController();
  TextEditingController _countryController = TextEditingController();
  final List<String> _roles = ['Seller', 'Customer'];
  late String selectedRole;
  late Address address;
  late VideoPlayerController _videoController;
  bool _isVideoInitialized = false;

  @override
  void initState() {
    super.initState();
    selectedRole = _roles.first;
    _roleController.text = selectedRole;
    _videoController = VideoPlayerController.asset('assets/video/shopping.mp4')
      ..initialize().then((_) {
        // Đánh dấu là đã khởi tạo
        setState(() {
          _isVideoInitialized = true;
        });
        _videoController.setLooping(true);
        _videoController.play();
      });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            _isVideoInitialized
                ? SizedBox.expand(
                    child: FittedBox(
                      fit: BoxFit.cover,
                      child: SizedBox(
                        width: _videoController.value.size.width,
                        height: _videoController.value.size.height,
                        child: VideoPlayer(_videoController),
                      ),
                    ),
                  )
                : Center(child: CircularProgressIndicator()),
            Positioned(
              top: 100,
              right: 30,
              left: 30,
              bottom: 100,
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Center(
                  child: Container(
                    // width: 340,
                    decoration: BoxDecoration(
                      color:
                          const Color.fromARGB(255, 0, 0, 0).withOpacity(0.7),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 20),
                        child: BigText(
                          '',
                          text: 'Đăng ký',
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 10, bottom: 10, left: 25),
                        child: Row(
                          children: [
                            Text(
                              'Chào mừng bạn đến với FuFu',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                            Icon(
                              Icons.favorite,
                              color: Colors.red,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: InputBox(
                            isSecured: false,
                            hint: "username",
                            txtController: _usernameController,
                            width: double.maxFinite),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: InputBox(
                            isSecured: false,
                            hint: "email",
                            txtController: _emailController,
                            width: double.maxFinite),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: InputBox(
                            isSecured: false,
                            hint: "phone",
                            txtController: _phoneController,
                            width: double.maxFinite),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: InputBox(
                            isSecured: true,
                            hint: "password",
                            txtController: _passwordController,
                            width: double.maxFinite),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          children: [
                            Text('Địa chỉ: ',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                )),
                            Container(
                              height: 40,
                              width: double.maxFinite,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  InputBox(
                                      hint: "Địa chỉ cụ thể",
                                      txtController: _streetController,
                                      isSecured: false,
                                      width: 150),
                                  InputBox(
                                      hint: "Đường-Quận/Huyện",
                                      txtController: _districtController,
                                      isSecured: false,
                                      width: 180),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Container(
                              height: 40,
                              width: double.maxFinite,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  InputBox(
                                      hint: "Thành phố/Tỉnh",
                                      txtController: _cityController,
                                      isSecured: false,
                                      width: 150),
                                  InputBox(
                                      hint: "Quốc gia",
                                      txtController: _countryController,
                                      isSecured: false,
                                      width: 180),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            children: [
                              Text('Bạn là: ',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18)),
                              DropdownButton<String>(
                                value: selectedRole,
                                items: _roles.map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value,
                                        style: TextStyle(
                                            color: const Color.fromARGB(
                                                255, 255, 0, 0),
                                            fontSize: 15)),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    selectedRole = value!;
                                    _roleController.text = value;
                                  });
                                },
                              ),
                            ],
                          )),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: InkWell(
                          onTap: () async {
                            if (_usernameController.text.isEmpty) {
                              ShowMessage(
                                  context: context,
                                  title: 'Lỗi',
                                  message: 'Vui lòng nhập tên đăng nhập');
                            } else if (_emailController.text.isEmpty) {
                              ShowMessage(
                                  context: context,
                                  title: 'Lỗi',
                                  message: 'Vui lòng nhập email');
                            } else if (_passwordController.text.isEmpty) {
                              ShowMessage(
                                  context: context,
                                  title: 'Lỗi',
                                  message: 'Vui lòng nhập mật khẩu');
                            } else if (_streetController.text.isEmpty) {
                              ShowMessage(
                                  context: context,
                                  title: 'Lỗi',
                                  message: 'Vui lòng nhập số nhà');
                            } else if (_districtController.text.isEmpty) {
                              ShowMessage(
                                  context: context,
                                  title: 'Lỗi',
                                  message: 'Vui lòng nhập đường');
                            } else if (_cityController.text.isEmpty) {
                              ShowMessage(
                                  context: context,
                                  title: 'Lỗi',
                                  message: 'Vui lòng nhập thành phố');
                            } else if (_countryController.text.isEmpty) {
                              ShowMessage(
                                  context: context,
                                  title: 'Lỗi',
                                  message: 'Vui lòng nhập quốc gia');
                            } else if (_phoneController.text.isEmpty) {
                              ShowMessage(
                                  context: context,
                                  title: 'Lỗi',
                                  message: 'Vui lòng nhập số điện thoại');
                            } else {
                              register(context);
                            }
                          },
                          child: Container(
                            width: double.maxFinite,
                            height: 50,
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.blue,
                            ),
                            child: Text(
                              'Đăng ký',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Bạn đã có tài khoản?',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18)),
                            TextButton(
                              onPressed: () {
                                Navigator.pushNamed(context, '/login');
                              },
                              child: Text('Đăng nhập',
                                  style: TextStyle(
                                      color: Colors.blue,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(),
                        child: Column(
                          children: [
                            Text('Đăng ký với:',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18)),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                  onPressed: () {},
                                  icon: Icon(Icons.facebook, size: 35),
                                  color: Color.fromARGB(255, 0, 140, 255),
                                ),
                                IconButton(
                                  onPressed: () {},
                                  icon: Icon(Icons.email, size: 35),
                                  color: Color.fromARGB(255, 255, 255, 255),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ]),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void register(BuildContext context) async {
    address = Address(
      street: _streetController.text,
      district: _districtController.text,
      city: _cityController.text,
      country: _countryController.text,
    );
    final response = await Provider.of<AuthProvider>(context, listen: false)
        .register(
            _usernameController.text,
            _roleController.text,
            _emailController.text,
            _phoneController.text,
            _passwordController.text,
            address);
    if (response['status'] == 'success') {
      ShowMessage(
          context: context, title: 'Thành công', message: 'Đăng ký thành công');
    } else {
      ShowMessage(context: context, title: 'Lỗi', message: 'Đăng ký thất bại');
    }
  }
}

Widget InputBox(
    {required String hint,
    required TextEditingController txtController,
    required bool isSecured,
    required double width}) {
  return Container(
    height: 40,
    width: width,
    padding: const EdgeInsets.symmetric(horizontal: 15),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: const Color.fromARGB(255, 255, 255, 255)),
    ),
    child: TextField(
      obscureText: isSecured,
      controller: txtController,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: Colors.white),
        border: InputBorder.none,
      ),
    ),
  );
}

ShowMessage(
    {required BuildContext context,
    required String title,
    required String message}) {
  showCupertinoDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            CupertinoDialogAction(
              child: Text("OK"),
              onPressed: () {
                Navigator.pushNamed(context, "/");
              },
            )
          ],
        );
      });
}
