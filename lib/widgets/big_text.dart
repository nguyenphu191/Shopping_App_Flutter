import 'package:flutter/material.dart';

class BigText extends StatelessWidget {
  Color? color;
  final String text;
  double size; // đặt kích thước mặc định
  TextOverflow
      overflow; //nếu văn bản quá dài, nó sẽ được cắt bớt và thêm dấu ba chấm (...) ở cuối để chỉ ra sự cắt bớt này.
  BigText(String s,
      {super.key,
      this.color = const Color(0xff000000),
      required this.text,
      this.size = 20,
      this.overflow = TextOverflow.ellipsis});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          color: color,
          fontSize: size,
          fontFamily: 'Roboto',
          fontWeight: FontWeight.bold),
      overflow: overflow,
    );
  }
}
