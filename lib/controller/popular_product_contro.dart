// import 'package:flutter_shopping_app/data/repository/popular_product_repo.dart';
// import 'package:flutter_shopping_app/models/product.dart';
// import 'package:get/get.dart';

// class PopularProductContro extends GetxController {
//   final PopularProductRepo popularProductRepo;
//   PopularProductContro({required this.popularProductRepo});
//   List<dynamic> _popularProductList = [];
//   List<dynamic> get popularProductList => _popularProductList;
//   Future<void> getPopularProductList() async {
//     Response response = await popularProductRepo.getPopularProductList();
//     if (response.statusCode == 200) {
//       print("got products");
//       _popularProductList = [];
//       _popularProductList.addAll(Product.fromJson(response.body).products);
//       update();
//     } else {}
//   }
// }

import 'package:flutter_shopping_app/models/product.dart';
import 'package:flutter_shopping_app/data/app_data.dart' as app_data;

void getPopularProductList(List<ProductModel> popularProductList) {
  for (int i = 0; i < app_data.productList.length; i++) {
    if (app_data.productList[i].sold > 10) {
      popularProductList.add(app_data.productList[i]);
    }
  }
}
