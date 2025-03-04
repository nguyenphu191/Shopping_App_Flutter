import 'package:flutter_shopping_app/models/Address.dart';
import 'package:flutter_shopping_app/models/Variant.dart';

class ProductModel {
  late String id;
  late String SellerID;
  late String name;
  late String description;
  late Address address;
  late List<String> imgs;
  late int sold;
  late String category;
  late double rating;
  late int numberrate;
  late List<String> colors;
  late List<String> sizes;
  late List<Variant> variants;

  ProductModel(
      {required this.id,
      required this.SellerID,
      required this.name,
      required this.description,
      required this.sold,
      required this.address,
      required this.category,
      required this.rating,
      required this.numberrate,
      required this.colors,
      required this.sizes,
      required this.variants,
      required this.imgs});

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    SellerID = json['SellerID'];
    name = json['name'];
    imgs = List<String>.from(json['imgs'] ?? []);
    variants = List<Variant>.from(
        json['variants'].map((variant) => Variant.fromJson(variant)));

    description = json['description'];
    sold = json['sold'];
    address = Address.fromJson(json['address']);
    category = json['category'];
    colors = List<String>.from(json['colors']);
    sizes = List<String>.from(json['sizes']);
    rating = (json['rating'] is int)
        ? (json['rating'] as int).toDouble()
        : (json['rating'] as double);
    numberrate = json['numberrate'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> product = new Map<String, dynamic>();
    product['id'] = this.id;
    product['SellerID'] = this.SellerID;
    product['name'] = this.name;
    product['imgs'] = this.imgs;
    product['variants'] =
        this.variants.map((variant) => variant.toJson()).toList();
    product['description'] = this.description;
    product['sold'] = this.sold;
    product['address'] = this.address.toJson();
    product['category'] = this.category;
    product['rating'] = this.rating;
    product['numberrate'] = this.numberrate;
    return product;
  }
}
