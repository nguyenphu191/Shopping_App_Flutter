import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_shopping_app/core/services/notification_service.dart';
import 'package:flutter_shopping_app/core/network/http_client.dart';
import 'package:flutter_shopping_app/router/app_router.dart';
import 'package:flutter_shopping_app/repositories/auth_repository.dart';
import 'package:flutter_shopping_app/repositories/cart_repository.dart';
import 'package:flutter_shopping_app/repositories/order_repository.dart';
import 'package:flutter_shopping_app/repositories/product_repository.dart';
import 'package:flutter_shopping_app/repositories/admin_repository.dart';
import 'package:flutter_shopping_app/repositories/wishlist_repository.dart';
import 'package:flutter_shopping_app/repositories/review_repository.dart';
import 'package:flutter_shopping_app/repositories/user_repository.dart';
import 'package:flutter_shopping_app/view_models/admin_view_model.dart';
import 'package:flutter_shopping_app/view_models/auth_view_model.dart';
import 'package:flutter_shopping_app/view_models/wishlist_view_model.dart';
import 'package:flutter_shopping_app/view_models/cart_view_model.dart';
import 'package:flutter_shopping_app/view_models/order_view_model.dart';
import 'package:flutter_shopping_app/view_models/product_view_model.dart';
import 'package:flutter_shopping_app/view_models/review_view_model.dart';
import 'package:flutter_shopping_app/view_models/user_view_model.dart';
import 'package:flutter_shopping_app/view_models/variant_view_model.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');
  await Firebase.initializeApp();
  await NotificationService.instance.initialize();
  final httpClient = AppHttpClient();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_) => AuthViewModel(AuthRepository(httpClient))),
        ChangeNotifierProvider(
            create: (_) => UserViewModel(UserRepository(httpClient))),
        ChangeNotifierProvider(
            create: (_) => ProductViewModel(ProductRepository(httpClient))),
        ChangeNotifierProvider(
            create: (_) => CartViewModel(CartRepository(httpClient))),
        ChangeNotifierProvider(
            create: (_) => OrderViewModel(OrderRepository(httpClient))),
        ChangeNotifierProvider(
            create: (_) => ReviewViewModel(ReviewRepository(httpClient))),
        ChangeNotifierProvider(create: (_) => VariantViewModel()),
        ChangeNotifierProvider(
            create: (_) => AdminViewModel(AdminRepository(httpClient))),
        ChangeNotifierProvider(
            create: (_) => WishlistViewModel(WishlistRepository(httpClient))),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Shopping App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routerConfig: appRouter,
    );
  }
}
