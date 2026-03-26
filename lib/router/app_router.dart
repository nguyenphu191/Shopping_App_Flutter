import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_shopping_app/models/admin.dart';
import 'package:flutter_shopping_app/models/order.dart';
import 'package:flutter_shopping_app/models/user.dart';
import 'package:flutter_shopping_app/views/login_screen.dart';
import 'package:flutter_shopping_app/views/signup_screen.dart';
import 'package:flutter_shopping_app/views/profile_screen.dart';
import 'package:flutter_shopping_app/views/detail_product_screen.dart';
import 'package:flutter_shopping_app/views/customer_view/home_screen.dart';
import 'package:flutter_shopping_app/views/customer_view/all_product_screen.dart';
import 'package:flutter_shopping_app/views/customer_view/cart_screen.dart';
import 'package:flutter_shopping_app/views/customer_view/order_screen.dart';
import 'package:flutter_shopping_app/views/customer_view/order_list_screen.dart';
import 'package:flutter_shopping_app/views/customer_view/order_detail_screen.dart';
import 'package:flutter_shopping_app/views/seller_view/seller_screen.dart';
import 'package:flutter_shopping_app/views/seller_view/product_manage_screen.dart';
import 'package:flutter_shopping_app/views/seller_view/add_product_screen.dart';
import 'package:flutter_shopping_app/views/seller_view/home_store_screen.dart';
import 'package:flutter_shopping_app/views/seller_view/pending_order.dart';
import 'package:flutter_shopping_app/views/seller_view/shipping_screen.dart';
import 'package:flutter_shopping_app/views/admin_view/admin_screen.dart';
import 'package:flutter_shopping_app/views/admin_view/user_management_screen.dart';
import 'package:flutter_shopping_app/views/admin_view/product_management_screen.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    // Auth
    GoRoute(
      path: '/',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/signup',
      builder: (context, state) => SignUpScreen(),
    ),

    // Customer
    GoRoute(
      path: '/home',
      builder: (context, state) => HomeScreen(),
    ),
    GoRoute(
      path: '/all-products',
      builder: (context, state) => const AllProductScreen(),
    ),
    GoRoute(
      path: '/product/:id',
      builder: (context, state) {
        final productId = state.pathParameters['id']!;
        final role = (state.extra as String?) ?? 'customer';
        return DetailProduct(productId: productId, role: role);
      },
    ),
    GoRoute(
      path: '/cart',
      builder: (context, state) => const CartScreen(),
    ),
    GoRoute(
      path: '/order',
      builder: (context, state) {
        final cartItems = state.extra as List<String>;
        return OrderScreen(cartItems: cartItems);
      },
    ),
    GoRoute(
      path: '/orders',
      builder: (context, state) => const OrderListScreen(),
    ),
    GoRoute(
      path: '/order-detail',
      builder: (context, state) {
        final order = state.extra as OrderModel;
        return OrderDetailScreen(order: order);
      },
    ),
    GoRoute(
      path: '/profile',
      builder: (context, state) {
        final user = state.extra as User;
        return ProfileScreen(user: user);
      },
    ),

    // Seller
    GoRoute(
      path: '/seller',
      builder: (context, state) {
        final seller = state.extra as User;
        return SellerScreen(seller: seller);
      },
    ),
    GoRoute(
      path: '/seller/products',
      builder: (context, state) {
        final seller = state.extra as User;
        return ProductManScreen(seller: seller);
      },
    ),
    GoRoute(
      path: '/seller/add-product',
      builder: (context, state) {
        final seller = state.extra as User;
        return AddProductScreen(seller: seller);
      },
    ),
    GoRoute(
      path: '/seller/orders',
      builder: (context, state) {
        final extra = state.extra as Map<String, dynamic>;
        return SellerOrderListScreen(
          seller: extra['seller'] as User,
          initialStatus: extra['initialStatus'] as String,
        );
      },
    ),
    GoRoute(
      path: '/seller/order-detail',
      builder: (context, state) {
        final extra = state.extra as Map<String, dynamic>;
        return SellerOrderDetailScreen(
          order: extra['order'] as OrderModel,
          seller: extra['seller'] as User,
        );
      },
    ),
    GoRoute(
      path: '/seller/store/:id',
      builder: (context, state) {
        final sellerId = state.pathParameters['id']!;
        final role = (state.extra as String?) ?? 'customer';
        return HomeStoreScreen(sellerId: sellerId, role: role);
      },
    ),

    // Admin
    GoRoute(
      path: '/admin',
      builder: (context, state) {
        final admin = state.extra as Admin;
        return AdminScreen(admin: admin);
      },
    ),
    GoRoute(
      path: '/admin/users',
      builder: (context, state) => const UserManagementScreen(),
    ),
    GoRoute(
      path: '/admin/products',
      builder: (context, state) => const ProductManagementScreen(),
    ),
    GoRoute(
      path: '/admin/orders',
      builder: (context, state) => const Scaffold(
        body: Center(child: Text('Quản lý đơn hàng (coming soon)')),
      ),
    ),
  ],
  errorBuilder: (context, state) => Scaffold(
    body: Center(
      child: Text('Không tìm thấy trang: ${state.error}'),
    ),
  ),
);
