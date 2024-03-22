// class Product {
//   int? _totalSize;
//   int? _typeId;
//   int? _offset;
//   late List<ProductModel> _products;
//   List<ProductModel> get products => _products;
//   Product(
//       {required totalSize,
//       required typeId,
//       required offset,
//       required products}) {
//     this._totalSize = totalSize;
//     this._typeId = typeId;
//     this._offset = offset;
//     this._products = products;
//   }
//   Product.fromJson(Map<String, dynamic> json) {
//     _totalSize = json['totalSize'];
//     _typeId = json['typeId'];
//     _offset = json['offset'];
//     if (json['products'] != null) {
//       _products = <ProductModel>[];
//       json['products'].forEach((v) {
//         _products.add(ProductModel.fromJson(v));
//       });
//     }
//   }
// }

// class ProductModel {
//   int? id;
//   String? name;
//   int? price;
//   int? stars;
//   String? description;
//   String? img;
//   String? location;
//   String? createdAt;
//   String? updatedAt;
//   int? typeId;

//   ProductModel(
//       {this.id,
//       this.name,
//       this.price,
//       this.stars,
//       this.description,
//       this.img,
//       this.location,
//       this.createdAt,
//       this.updatedAt,
//       this.typeId});
//   ProductModel.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     price = json['price'];
//     stars = json['stars'];
//     description = json['description'];
//     img = json['img'];
//     location = json['location'];
//     createdAt = json['createdAt'];
//     updatedAt = json['updatedAt'];
//     typeId = json['typeId'];
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
  ProductModel(
      {required this.name,
      required this.price,
      required this.description,
      required this.img,
      required this.location});
}
