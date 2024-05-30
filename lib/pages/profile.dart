import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shopping_app/models/User.dart';
// import 'package:flutter_shopping_app/models/User.dart';
import 'package:flutter_shopping_app/widgets/big_text.dart';
import 'package:flutter_shopping_app/controller/profileControl.dart' as control;

class Profile extends StatefulWidget {
  final User user;
  const Profile({super.key, required this.user});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    User user = widget.user;
    TextEditingController nameController = TextEditingController();
    TextEditingController phoneController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController cityController = TextEditingController();

    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.maxFinite,
          height: double.maxFinite,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/image/background2.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Stack(
            children: [
              Positioned(
                  left: 0,
                  right: 0,
                  top: 0,
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
              Positioned(
                top: 70,
                left: 10,
                right: 10,
                child: Container(
                  height: 700,
                  width: 320,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              Positioned(
                  top: 80,
                  left: 10,
                  right: 10,
                  child: Container(
                    alignment: Alignment.center,
                    child: BigText('', text: "Thông tin người dùng"),
                  )),
              Positioned(
                top: 120,
                left: 120,
                child: Container(
                  alignment: Alignment.center,
                  height: 150,
                  width: 150,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/image/nam_avatar.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 280,
                left: 30,
                child: Container(
                  height: 400,
                  width: 320,
                  // color: const Color.fromARGB(255, 149, 24, 24),
                  margin: EdgeInsets.only(left: 15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        child: Column(
                          children: [
                            Container(
                                alignment: Alignment.centerLeft,
                                child: BigText('',
                                    text: 'Tên người dùng: ', size: 15)),
                            Row(
                              children: [
                                Container(
                                  child: Icon(
                                    Icons.person,
                                  ),
                                ),
                                Container(
                                    width: 230,
                                    alignment: Alignment.topLeft,
                                    padding: EdgeInsets.only(left: 5),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: BigText('',
                                        text: user.username.toString(),
                                        size: 15)),
                                Container(
                                  child: IconButton(
                                    icon: Icon(Icons.edit),
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title:
                                                Text('Sửa thông tin cá nhân'),
                                            content: InputBox(
                                              hint: 'Nhập tên mới của bạn',
                                              txtController: nameController,
                                              isSecured: false,
                                            ),
                                            actions: <Widget>[
                                              InkWell(
                                                child: Text('Save'),
                                                onTap: () {
                                                  control.editName(
                                                      nameController,
                                                      user,
                                                      context);
                                                },
                                              ),
                                              SizedBox(
                                                width: 20,
                                              ),
                                              InkWell(
                                                child: Text('Cancel'),
                                                onTap: () {
                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        child: Column(
                          children: [
                            Container(
                                alignment: Alignment.centerLeft,
                                child: BigText('',
                                    text: 'Số điện thoại: ', size: 15)),
                            Row(
                              children: [
                                Container(
                                  child: Icon(
                                    Icons.phone,
                                  ),
                                ),
                                Container(
                                    width: 230,
                                    alignment: Alignment.topLeft,
                                    padding: EdgeInsets.only(left: 5),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: BigText('',
                                        text: user.phone.toString(), size: 15)),
                                Container(
                                  child: IconButton(
                                    icon: Icon(Icons.edit),
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title:
                                                Text('Sửa thông tin cá nhân'),
                                            content: InputBox(
                                              hint:
                                                  'Nhập số điện thoại mới của bạn',
                                              txtController: phoneController,
                                              isSecured: false,
                                            ),
                                            actions: <Widget>[
                                              InkWell(
                                                child: Text('Save'),
                                                onTap: () {
                                                  control.editPhone(
                                                      phoneController,
                                                      user,
                                                      context);
                                                },
                                              ),
                                              SizedBox(
                                                width: 20,
                                              ),
                                              InkWell(
                                                child: Text('Cancel'),
                                                onTap: () {
                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        child: Column(
                          children: [
                            Container(
                                alignment: Alignment.centerLeft,
                                child: BigText('', text: 'Email: ', size: 15)),
                            Row(
                              children: [
                                Container(
                                  child: Icon(
                                    Icons.email,
                                  ),
                                ),
                                Container(
                                    width: 230,
                                    alignment: Alignment.topLeft,
                                    padding: EdgeInsets.only(left: 5),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: BigText('',
                                        text: user.email.toString(), size: 15)),
                                Container(
                                  child: IconButton(
                                    icon: Icon(Icons.edit),
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title:
                                                Text('Sửa thông tin cá nhân'),
                                            content: InputBox(
                                              hint: 'Nhập email mới của bạn',
                                              txtController: emailController,
                                              isSecured: false,
                                            ),
                                            actions: <Widget>[
                                              InkWell(
                                                child: Text('Save'),
                                                onTap: () {
                                                  control.editEmail(
                                                      emailController,
                                                      user,
                                                      context);
                                                },
                                              ),
                                              SizedBox(
                                                width: 20,
                                              ),
                                              InkWell(
                                                child: Text('Cancel'),
                                                onTap: () {
                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                          child: Column(
                        children: [
                          Container(
                              alignment: Alignment.centerLeft,
                              child:
                                  BigText('', text: 'Thành phố: ', size: 15)),
                          Row(
                            children: [
                              Container(
                                child: Icon(
                                  Icons.location_city,
                                ),
                              ),
                              Container(
                                  width: 230,
                                  alignment: Alignment.topLeft,
                                  padding: EdgeInsets.only(left: 5),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: BigText('',
                                      text: user.city.toString(), size: 15)),
                              Container(
                                child: IconButton(
                                  icon: Icon(Icons.edit),
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text('Sửa thông tin cá nhân'),
                                          content: InputBox(
                                            hint: 'Nhập thành phố mới của bạn',
                                            txtController: cityController,
                                            isSecured: false,
                                          ),
                                          actions: <Widget>[
                                            InkWell(
                                              child: Text('Save'),
                                              onTap: () {
                                                control.editCity(cityController,
                                                    user, context);
                                              },
                                            ),
                                            SizedBox(
                                              width: 20,
                                            ),
                                            InkWell(
                                              child: Text('Cancel'),
                                              onTap: () {
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      )),
                      Container(
                        child: Column(
                          children: [
                            Container(
                                alignment: Alignment.centerLeft,
                                child: BigText('',
                                    text: 'Số đơn hàng: ', size: 15)),
                            Row(
                              children: [
                                Container(
                                  child: Icon(
                                    Icons.shopping_cart,
                                  ),
                                ),
                                Container(
                                    width: 230,
                                    alignment: Alignment.topLeft,
                                    padding: EdgeInsets.only(left: 5),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: BigText('',
                                        text: user.orderList.length.toString(),
                                        size: 15)),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
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
              },
            )
          ],
        );
      });
}
