import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_shopping_app/widgets/big_text.dart';

class DetailProduct extends StatelessWidget {
  const DetailProduct({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            left: 10,
            top: 0,
            right: 10,
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 237, 186, 76),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back_ios),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/cart');
                    },
                    icon: Icon(Icons.shopping_cart),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            top: 60,
            child: Container(
              height: 350,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/image/banhmi.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Positioned(
            left: 5,
            right: 5,
            bottom: 0,
            child: Container(
              height: 380,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 250, 250, 250),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.all(10),
                    child: BigText('', text: "Bánh mì thịt nướng"),
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "20.000đ",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          // child: Icon(
                          //   Icons.add,
                          //   size: 20,
                          // ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 1,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 8, 8, 8),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Container(
                            margin: EdgeInsets.only(
                                bottom: 20, top: 10, left: 10, right: 10),
                            child: Text(
                              "Thông tin sản phẩm: ",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.red,
                              ),
                            )),
                        Container(
                          margin: EdgeInsets.all(10),
                          child: Text(
                              "Bánh mì thịt nướng thường được chế biến nhanh chóng và dễ dàng, phù hợp để thưởng thức trong bữa ăn sáng, trưa hoặc chiều. "),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            left: 15,
            right: 15,
            bottom: 5,
            child: InkWell(
              onTap: () {},
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Center(
                  child: Text("Thêm vào giỏ hàng",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      )),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
