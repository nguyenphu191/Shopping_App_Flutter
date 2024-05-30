import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
// import 'package:flutter_shopping_app/controller/loginControler.dart';
import 'package:flutter_shopping_app/widgets/big_text.dart';
import 'package:flutter_shopping_app/controller/loginControler.dart'
    as loginControler;

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    // LoginController controller = Get.put(LoginController());
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              height: double.maxFinite,
              width: double.maxFinite,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/image/login_background.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              top: 20,
              right: 30,
              left: 30,
              bottom: 20,
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Center(
                  child: Container(
                    height: 680,
                    // width: 340,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 50),
                        child: BigText(
                          '',
                          text: 'Đăng nhập',
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
                            hint: 'email',
                            txtController: emailController,
                            isSecured: false),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: InputBox(
                            hint: 'password',
                            txtController: passwordController,
                            isSecured: true),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: ElevatedButton(
                          onPressed: () {
                            // login();
                            String email = emailController.text.trim();
                            String password = passwordController.text.trim();
                            loginControler.login(email, password);
                          },
                          child: Text('Đăng nhập'),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Bạn chưa có tài khoản?'),
                            TextButton(
                              onPressed: () {
                                Navigator.pushNamed(context, '/signup');
                              },
                              child: Text('Đăng ký'),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Column(
                          children: [
                            Text('Đăng nhập với:'),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                  onPressed: () {},
                                  icon: Icon(Icons.facebook),
                                  color: Color.fromARGB(255, 3, 60, 107),
                                ),
                                IconButton(
                                  onPressed: () {},
                                  icon: Icon(Icons.g_mobiledata_rounded),
                                  color: Color.fromARGB(255, 0, 0, 0),
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
