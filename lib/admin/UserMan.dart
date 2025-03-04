// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_shopping_app/models/User.dart';
// import 'package:flutter_shopping_app/widgets/big_text.dart';
// import 'package:flutter_shopping_app/data/app_data.dart' as app_data;
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';

// class UserMan extends StatelessWidget {
//   const UserMan({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         body: Stack(
//           children: [
//             Positioned(
//                 left: 10,
//                 right: 10,
//                 top: 10,
//                 child: Container(
//                   height: 50,
//                   decoration: BoxDecoration(
//                     color: Color.fromARGB(255, 233, 192, 67),
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Container(
//                         margin: EdgeInsets.only(left: 20),
//                         child: IconButton(
//                           padding: EdgeInsets.all(10),
//                           onPressed: () {
//                             Navigator.pushNamed(context, '/admin');
//                           },
//                           icon: Icon(Icons.arrow_back_ios),
//                         ),
//                       ),
//                       Row(
//                         children: [
//                           Container(
//                             margin: EdgeInsets.only(left: 10),
//                             child: Icon(
//                               Icons.home,
//                               color: Colors.black,
//                             ),
//                           ),
//                           Container(
//                             margin: EdgeInsets.only(right: 10),
//                             child: Center(
//                               child: BigText(
//                                 '',
//                                 text: "FuFu",
//                                 color: Colors.black,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 )),
//             // SizedBox(
//             //   height: 10,
//             // ),
//             app_data.admin.userList.length > 0
//                 ? Positioned(
//                     left: 10,
//                     right: 10,
//                     bottom: 10,
//                     top: 60,
//                     child: Container(
//                       decoration: BoxDecoration(
//                         color: Color.fromARGB(255, 228, 234, 234),
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                       child: ListView.builder(
//                         itemCount: app_data.admin.userList.length,
//                         itemBuilder: (context, index) {
//                           User user = app_data.admin.userList[index];
//                           return Container(
//                             width: 320,
//                             height: 120,
//                             margin: EdgeInsets.only(top: 10, bottom: 10),
//                             decoration: BoxDecoration(
//                               color: Color.fromARGB(255, 252, 252, 252),
//                               borderRadius: BorderRadius.circular(10),
//                             ),
//                             child: Row(
//                               children: [
//                                 Container(
//                                   width: 100,
//                                   height: 100,
//                                   decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(10),
//                                     image: DecorationImage(
//                                       image: AssetImage(
//                                           "assets/image/nam_avatar.png"),
//                                       fit: BoxFit.cover,
//                                     ),
//                                   ),
//                                 ),
//                                 Container(
//                                   width: 210,
//                                   height: 100,
//                                   alignment: Alignment.centerLeft,
//                                   margin: EdgeInsets.only(left: 10, top: 10),
//                                   child: Column(
//                                     children: [
//                                       Text(
//                                         "UserName: ${user.username.toString()}",
//                                         style: TextStyle(
//                                           color: Colors.black,
//                                           fontSize: 13,
//                                         ),
//                                       ),
//                                       Text(
//                                         "SDT: ${user.phone.toString()}",
//                                         style: TextStyle(
//                                           color: Colors.black,
//                                           fontSize: 13,
//                                         ),
//                                       ),
//                                       Text(
//                                         "Email: ${user.email.toString()}",
//                                         style: TextStyle(
//                                           color: Colors.black,
//                                           fontSize: 13,
//                                         ),
//                                       ),
//                                       Text(
//                                         "Địa chỉ: ${user.city.toString()}",
//                                         style: TextStyle(
//                                           color: Colors.black,
//                                           fontSize: 13,
//                                         ),
//                                       ),
//                                       Text(
//                                         'Đơn hàng: ${user.orderList.length}',
//                                         style: TextStyle(
//                                           color: Colors.black,
//                                           fontSize: 13,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                                 Container(
//                                   width: 50,
//                                   height: 100,
//                                   alignment: Alignment.center,
//                                   margin: EdgeInsets.only(left: 15),
//                                   child: IconButton(
//                                     onPressed: () {
//                                       app_data.admin.userList.removeAt(index);
//                                       Get.snackbar(
//                                           'Thông báo', 'Xóa thành công');
//                                       Navigator.pop(context);
//                                       Navigator.pushNamed(
//                                           context, '/admin/user');
//                                     },
//                                     icon: Icon(Icons.delete),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           );
//                         },
//                       ),
//                     ),
//                   )
//                 : Container(
//                     margin: EdgeInsets.only(top: 100),
//                     child: Center(
//                       child: Text('Danh sách trống'),
//                     ),
//                   ),
//           ],
//         ),
//       ),
//     );
//   }
// }
