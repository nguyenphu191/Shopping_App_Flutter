import 'package:flutter_shopping_app/models/product.dart';

List<ProductModel> PopularProductList(List<ProductModel> ProductList) {
  List<ProductModel> products = ProductList;
  products.sort((a, b) => b.sold.compareTo(a.sold));
  return products.take(10).toList();
}
