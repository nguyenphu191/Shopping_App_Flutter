import 'package:flutter_shopping_app/data/app_data.dart' as app_data;

void search(String sear) {
  for (var i = 0; i < app_data.productList.length; i++) {
    if (app_data.productList[i].name
        .toLowerCase()
        .contains(sear.toLowerCase())) {
      app_data.searchList.add(app_data.productList[i]);
    }
  }
}

void back() {
  app_data.searchList.clear();
}
