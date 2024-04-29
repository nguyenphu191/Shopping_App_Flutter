// import 'package:flutter/foundation.dart';

// class Product {
//   late List<ProductModel> _products;
//   List<ProductModel> get products => _products;
//   Product({required products}) {
//     this._products = products;
//   }

//   Product.fromJson(Map<String, dynamic> json) {
//     if (json['product'] != null) {
//       _products = <ProductModel>[];
//       json['product'].forEach((v) {
//         _products!.add(new ProductModel.fromJson(v));
//       });
//     }
//   }
// }

// class ProductModel {
//   String? name;
//   int? price;
//   String? img;
//   String? description;
//   String? location;
//   String? id;

//   ProductModel(
//       {this.name,
//       this.price,
//       this.img,
//       this.description,
//       this.location,
//       this.id});

//   ProductModel.fromJson(Map<String, dynamic> json) {
//     name = json['name'];
//     price = json['price'];
//     img = json['img'];
//     description = json['description'];
//     location = json['location'];
//     id = json['id'];
//     price = json[' price'];
//   }
// }
import 'package:flutter/foundation.dart';

class ProductModel {
  final String id = UniqueKey().toString();
  String name;
  double price;
  String description;
  String img;
  String location;
  int sold;
  ProductModel(
      {required this.name,
      required this.price,
      required this.description,
      required this.img,
      required this.location,
      required this.sold});
  set setSold(int sold) {
    this.sold = sold;
  }

  set setPrice(double price) {
    this.price = price;
  }

  set setName(String name) {
    this.name = name;
  }

  set setDescription(String description) {
    this.description = description;
  }

  set setImg(String img) {
    this.img = img;
  }

  set setLocation(String location) {
    this.location = location;
  }
}
