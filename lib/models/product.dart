import 'package:flutter/foundation.dart';

class ProductModel {
  final String id = UniqueKey().toString();
  String name;
  double price;
  String description;
  String img;
  String location;
  ProductModel(
      {required this.name,
      required this.price,
      required this.description,
      required this.img,
      required this.location});
}
