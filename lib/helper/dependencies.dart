// import 'package:flutter_shopping_app/controller/authController.dart';
// import 'package:flutter_shopping_app/controller/popular_product_contro.dart';
// import 'package:flutter_shopping_app/data/api/api_client.dart';
// import 'package:flutter_shopping_app/data/repository/authRepo.dart';
// import 'package:flutter_shopping_app/data/repository/popular_product_repo.dart';
// import 'package:flutter_shopping_app/utils/app_constants.dart';
// import 'package:get/get.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// Future<void> init() async {
//   //tạo ra một đối tượng ApiClient
//   // Get.lazyPut(() => ApiClient(appBaseUrl: AppConstants.BASE_URL));
//   // //tạo ra một đối tượng PopularProductRepo
//   // Get.lazyPut(() => PopularProductRepo(apiClient: Get.find()));
//   // //tạo ra một đối tượng PopularProductContro
//   // Get.lazyPut(() => PopularProductContro(popularProductRepo: Get.find()));
//   Get.lazyPut(() => SharedPreferences);
//   Get.lazyPut(
//       () => AuthRepo(apiClient: Get.find(), sharedPreferences: Get.find()));
//   Get.lazyPut(() => AuthController(authRepo: Get.find()));
// }
