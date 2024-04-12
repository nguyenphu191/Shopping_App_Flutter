import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shopping_app/models/OrderModel.dart';
import 'package:flutter_shopping_app/widgets/big_text.dart';
import 'package:flutter_shopping_app/data/app_data.dart' as app_data;
import 'package:flutter_shopping_app/widgets/small_text.dart';

class OrderListPage extends StatelessWidget {
  const OrderListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Positioned(
                left: 10,
                right: 10,
                top: 10,
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
                            Navigator.pushNamed(context, '/');
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
              top: 60,
              left: 10,
              right: 10,
              bottom: 0,
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: AssetImage('assets/image/background2.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Positioned(
              top: 60,
              left: 20,
              right: 20,
              bottom: 10,
              child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListView.builder(
                      itemCount: app_data.orderList.length,
                      itemBuilder: (context, index) {
                        OrderModel order = app_data.orderList[index];
                        return InkWell(
                          onTap: () {},
                          child: Container(
                            height: 100,
                            margin: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.only(left: 10,top: 10),
                                  width: 250,
                                  color: const Color.fromARGB(255, 255, 255, 255),
                                  child: Column
                                  (
                                    children: [
                                    Text(' ID: '+order.id.toString()),
                                    SizedBox(height: 5,),
                                    SmallText('',text:'Sản phẩm: '+order.cartList[0].product.name+"..."),
                                    Text('Tổng tiền: '+order.total.toString()),
                                  ],),
                                ),
                                (order.isDone==true)? Container(
                                  width: 120,
                                  height: 80,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(color: Color.fromARGB(255, 4, 244, 56), width: 1)
                                  ),
                                    padding: EdgeInsets.all(10),
                                  child: 
                                    Center(child: Text('Đã xác nhận')),
                                  )
                                
                                :Container(
                                  width: 120,
                                  height: 80,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(color: Color.fromARGB(255, 251, 4, 4), width: 1)
                                  ),
                                    padding: EdgeInsets.all(10),
                                    
                                    child: 
                                      Column(
                                        children: [
                                          Text('Chưa xác nhận'
                                                                            ),
                                          SizedBox(height: 5,),
                                          TextButton(onPressed: (() {
                                            
                                          }), child: Container(
                                            height: 30,
                                            width: 80,
                                            decoration: BoxDecoration(
                                              color: Color.fromARGB(255, 233, 192, 67),
                                              borderRadius: BorderRadius.circular(20),),
                    
                                            child: Center(child: Text('Xác nhận'))))
                                        ],
                                      )
                                )
                              ],
                            ),
                          
                        ),);
                      })),
            ),
          ],
        ),
      ),
    );
  }
}
