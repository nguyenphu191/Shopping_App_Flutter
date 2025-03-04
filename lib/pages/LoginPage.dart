import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_shopping_app/models/Admin.dart';

import 'package:flutter_shopping_app/pages/Admin/admin_page.dart';
import 'package:flutter_shopping_app/pages/Customer/HomePage.dart';
import 'package:flutter_shopping_app/pages/Seller/SellerPage.dart';
import 'package:flutter_shopping_app/provider/AuthProvider.dart';
import 'package:flutter_shopping_app/provider/UserProvider.dart';
import 'package:flutter_shopping_app/widgets/big_text.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  late VideoPlayerController _videoController;
  bool _isVideoInitialized = false;

  @override
  void initState() {
    super.initState();
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
  void dispose() {
    super.dispose();
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
              top: 150,
              right: 30,
              left: 30,
              bottom: 100,
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Center(
                  child: Container(
                    decoration: BoxDecoration(
                      color:
                          const Color.fromARGB(255, 0, 0, 0).withOpacity(0.7),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 20),
                        child: BigText(
                          '',
                          text: 'Đăng nhập',
                          size: 30,
                          color: Colors.white,
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
                                fontStyle: FontStyle.italic,
                                color: Colors.white,
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
                            hint: 'username',
                            txtController: _usernameController,
                            isSecured: false),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: InputBox(
                            hint: 'password',
                            txtController: _passwordController,
                            isSecured: false),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: InkWell(
                          onTap: () {
                            if (_usernameController.text.isEmpty) {
                              ShowMessage(
                                  context: Get.context!,
                                  title: "Nhập username",
                                  message: "Nhập username");
                            } else if (_passwordController.text.isEmpty) {
                              ShowMessage(
                                  context: Get.context!,
                                  title: "Nhập mật khẩu",
                                  message: "Nhập mật khẩu");
                            } else {
                              handleLogin(context);
                            }
                          },
                          child: Container(
                            height: 50,
                            width: double.maxFinite,
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.blue,
                            ),
                            child: Text('Đăng nhập',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {},
                        child: Text(
                          'Quên mật khẩu?',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontFamily: 'Roboto',
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Bạn chưa có tài khoản?',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pushNamed(context, '/signup');
                              },
                              child: Text(
                                'Đăng ký',
                                style:
                                    TextStyle(color: Colors.blue, fontSize: 18),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Column(
                          children: [
                            Text(
                              'Đăng nhập với:',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.facebook,
                                    size: 35,
                                  ),
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

  void handleLogin(BuildContext context) async {
    try {
      await Provider.of<AuthProvider>(context, listen: false)
          .login(_usernameController.text, _passwordController.text);
      final role = Provider.of<AuthProvider>(context, listen: false).role;
      final user = Provider.of<AuthProvider>(context, listen: false).user;

      if (role == null || user == null) {
        throw Exception('Invalid role or user data');
      } else {
        Provider.of<UserProvider>(context, listen: false).setUser(user);
      }

      if (role == 'Customer') {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomePage()));
      } else if (role == 'Seller') {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => SellerPage(seller: user)));
      } else if (role == 'Admin') {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => AdminPage(admin: user as Admin)));
      } else {
        throw Exception('Unknown role: $role');
      }
    } catch (error) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('Login Error'),
          content: Text(error.toString()),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }
}

Widget InputBox(
    {required String hint,
    required TextEditingController txtController,
    required bool isSecured}) {
  return Container(
    height: 50,
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
                Navigator.pop(context);
                // Navigator.pushNamed(context, '/');
              },
            )
          ],
        );
      });
}
