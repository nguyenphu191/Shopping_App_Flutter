// import 'package:flutter/material.dart';
// import 'package:flutter_shopping_app/models/cart_item.dart';
// import 'package:flutter_shopping_app/models/product.dart';
// import 'package:flutter_shopping_app/widgets/big_text.dart';
// import 'package:flutter_shopping_app/widgets/small_text.dart';
// import 'package:flutter_shopping_app/data/app_data.dart' as app_data;

// class PopularProduct extends StatelessWidget {
//   final ProductModel product;
//   PopularProduct({required this.product});
//   @override
//   Widget build(BuildContext context) {
//     // return ListTile(
//     //   onTap: () {
//     //     Navigator.pushNamed(context, '/detail');
//     //   },
//     //   leading: Image.network(product.img),
//     //   title: BigText('', text: product.name),
//     //   subtitle: Text('${product.price} VND'),
//     // );
//     return InkWell(
//       onTap: () {
//         Navigator.pushNamed(context, '/detail');
//       },
//       child: Container(
//         margin: EdgeInsets.only(left: 20, right: 20),
//         child: Container(
//           height: 100,
//           margin: EdgeInsets.only(top: 10),
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(20),
//           ),
//           child: Row(
//             children: [
//               Container(
//                 height: 100,
//                 width: 100,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(20),
//                   image: DecorationImage(
//                     fit: BoxFit.cover,
//                     image: AssetImage(product.img),
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 width: 20,
//               ),
//               Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   BigText(
//                     '',
//                     text: product.name,
//                   ),
//                   SizedBox(
//                     height: 5,
//                   ),
//                   Container(
//                     width: 220,
//                     child: SmallText(
//                       '',
//                       text: product.description,
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                   ),
//                   SizedBox(
//                     height: 5,
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Container(
//                         child: Text(
//                           '${product.price} VND',
//                           style: TextStyle(
//                             fontSize: 10,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                       SizedBox(
//                         width: 50,
//                       ),
//                       InkWell(
//                         onTap: () {
                          
//                         },
//                         child: Container(
//                           decoration: BoxDecoration(
//                             color: Colors.blue,
//                             borderRadius: BorderRadius.circular(50),
//                           ),
//                           child: Icon(
//                             Icons.add,
//                             size: 15,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                   SizedBox(
//                     height: 5,
//                   ),
//                   Row(
//                     children: [
//                       Container(
//                         child: Icon(
//                           Icons.location_on,
//                           size: 15,
//                         ),
//                       ),
//                       SizedBox(
//                         width: 5,
//                       ),
//                       Text(
//                         '5km',
//                         style: TextStyle(
//                           fontSize: 10,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
