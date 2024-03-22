import 'package:flutter/material.dart';
import 'package:flutter_shopping_app/pages/home_body_page.dart';
import 'package:flutter_shopping_app/widgets/big_text.dart';
import 'package:flutter_shopping_app/widgets/small_text.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Container(
          height: 50,
          color: Color.fromARGB(255, 237, 186, 76),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
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
              Container(
                margin: EdgeInsets.only(right: 10),
                child: IconButton(
                  padding: EdgeInsets.all(10),
                  onPressed: () {
                    Navigator.pushNamed(context, '/cart');
                  },
                  icon: Icon(Icons.shopping_cart),
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.only(
            left: 10,
            right: 10,
            bottom: 5,
          ),
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment
                .spaceBetween, // làm cho các widget con nằm cùng hàng và cách đều nhau
            children: [
              //Tạo chức năng chọn thành phố
              Column(
                children: [
                  BigText(
                    '',
                    text: "Thành Phố",
                    color: Color.fromARGB(255, 10, 65, 153),
                  ),
                  Row(
                    children: [
                      SmallText(
                        '',
                        text: "Hà Nội",
                        color: Colors.black,
                      ),
                      Icon(Icons.arrow_drop_down_rounded),
                    ],
                  ),
                ],
              ),
              //Tạo nút tìm kiếm
              Center(
                child: Container(
                    width: 100,
                    height: 30,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 10),
                          child: Text("Tìm kiếm",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 10,
                              )),
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 10),
                          child: Icon(
                            Icons.search,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 123, 194, 253),
                      borderRadius: BorderRadius.circular(15),
                    )),
              ),
            ],
          ),
        ),
        Expanded(child: SingleChildScrollView(child: HomeBodyPage())),
      ],
    ));
  }
}
