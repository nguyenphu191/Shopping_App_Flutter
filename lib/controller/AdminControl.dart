import 'package:flutter_shopping_app/models/product.dart';
import 'package:flutter_shopping_app/data/app_data.dart' as app_data;

void addProduct(String name, String gia, String img, String des, String addr) {
  ProductModel product = ProductModel(
      name: name,
      price: double.parse(gia),
      description: des,
      img: img,
      location: addr,
      sold: 0);
  app_data.productList.add(product);
}
