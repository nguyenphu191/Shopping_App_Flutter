// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_shopping_app/models/Order.dart';

// class PendingOrder extends StatefulWidget {
//   const PendingOrder({super.key});

//   @override
//   State<PendingOrder> createState() => _PendingOrderState();
// }

// class _PendingOrderState extends State<PendingOrder> {
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//         child: Scaffold(
//           appBar: PreferredSize(
//             preferredSize: Size.fromHeight(100),
//             child: AppBar(
//               flexibleSpace: Container(
//                 decoration: BoxDecoration(
//                   gradient: LinearGradient(
//                     colors: [
//                       Color.fromARGB(255, 68, 142, 240),
//                       Color.fromARGB(255, 39, 195, 174),
//                       Color.fromARGB(255, 202, 224, 88),
//                     ],
//                     begin: Alignment.topLeft,
//                     end: Alignment.bottomRight,
//                   ),
//                 ),
//               ),
//               leading: IconButton(
//                 icon: Icon(Icons.arrow_back_ios),
//                 onPressed: () => Navigator.pop(context, true),
//               ),
//               title: Text(
//                 'Danh sách đơn hàng chờ xác nhận',
//                 style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
//               ),
//               centerTitle: true,
//             ),
//           ),
//           body: Stack(
//             children: [            
//               _buildOrderListView('pending'),
//             ],
//           ),
//         ),
      
//     );
//   }

//   Widget _buildOrderListView(String status) {
//     return FutureBuilder<List<OrderModel>>(
//       future: _getOrderList(status),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return Center(child: CircularProgressIndicator());
//         } else if (snapshot.hasError) {
//           return Center(child: Text('Lỗi tải dữ liệu'));
//         } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//           return Center(child: Text('Không có đơn hàng'));
//         } else {
//           List<OrderModel> orderList = snapshot.data!;
//           return ListView.builder(
//             itemCount: orderList.length,
//             itemBuilder: (context, index) {
//               OrderModel order = orderList[index];
//               return InkWell(
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => OrderDetailPage(
//                         customer: widget.customer,
//                         order: order,
//                       ),
//                     ),
//                   ).then((value) {
//                     if (value == true) {
//                       setState(() {}); // Làm mới danh sách sau khi quay lại
//                     }
//                   });
//                 },
//                 child: Container(
//                   height: 100,
//                   margin: EdgeInsets.all(10),
//                   decoration: BoxDecoration(
//                     border: Border.all(color: Colors.grey, width: 1),
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   child: Row(
//                     children: [
//                       Container(
//                         padding: EdgeInsets.only(left: 10, top: 10),
//                         width: 250,
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.spaceAround,
//                           children: [
//                             Text('ID: ${order.id}'),
//                             Text('Tổng tiền: ${order.total}đ',
//                                 style: TextStyle(fontSize: 12)),
//                             Text('Ngày đặt: ${order.time.substring(0, 19)}',
//                                 style: TextStyle(fontSize: 12)),
//                           ],
//                         ),
//                       ),
//                       Expanded(
//                         child: Container(
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.spaceAround,
//                             children: [
//                               Text(
//                                 _getStatusText(order.status),
//                                 style: TextStyle(
//                                   fontSize: 12,
//                                   color: _getStatusColor(order.status),
//                                 ),
//                               ),
//                               SizedBox(height: 10),
//                               _buildActionButton(order),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               );
//             },
//           );
//         }
//       },
//     );
//   }

//   Widget _buildActionButton(OrderModel order) {
//     if (order.status == 'pendingadmin' || order.status == 'pendingseller') {
//       return _buildButton('Hủy đơn', Colors.red, () {
//         _updateOrder(order.id, 'cancelled');
//       });
//     } else if (order.status == 'delivering') {
//       return _buildButton('Đã nhận hàng', Colors.green, () {
//         _updateOrder(order.id, 'delivered');
//       });
//     }
//     return Container();
//   }

//   Widget _buildButton(String text, Color color, VoidCallback onPressed) {
//     return InkWell(
//       onTap: onPressed,
//       child: Container(
//         padding: EdgeInsets.all(8),
//         decoration: BoxDecoration(
//           color: color,
//           borderRadius: BorderRadius.circular(5),
//         ),
//         child: Text(
//           text,
//           style: TextStyle(color: Colors.white, fontSize: 12),
//         ),
//       ),
//     );
//   }

  
// }

