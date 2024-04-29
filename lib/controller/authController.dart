// import 'package:flutter_shopping_app/data/repository/authRepo.dart';
// import 'package:flutter_shopping_app/models/responseModel.dart';
// import 'package:flutter_shopping_app/models/signupBody.dart';
// import 'package:get/get.dart';

// class AuthController extends GetxController implements GetxService {
//   final AuthRepo authRepo;
//   AuthController({required this.authRepo});
//   bool _isloading = false;
//   bool get isloading => _isloading;
//   Future<ResponseModel> registration(SignupBody signupBody) async {
//     _isloading = true;
//     Response response = await authRepo.registration(signupBody);
//     late ResponseModel responseModel;
//     if (response.statusCode == 200) {
//       authRepo.SaveUserToken(response.body["token"]);
//       responseModel = ResponseModel(true, response.body["token"]);
//     } else {
//       responseModel = ResponseModel(true, response.statusText!);
//     }
//     _isloading = false;
//     update();
//     return responseModel;
//   }
// }
