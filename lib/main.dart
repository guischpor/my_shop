import 'package:flutter/material.dart';
import 'package:my_shop/pages/auth_page.dart';
import 'package:my_shop/pages/cart_page.dart';
import 'package:my_shop/pages/orders_page.dart';
import 'package:my_shop/pages/product_detail_page.dart';
import 'package:my_shop/pages/product_form_page.dart';
import 'package:my_shop/pages/product_page.dart';
import 'package:my_shop/pages/products_overwiew_page.dart';
import 'package:my_shop/providers/auth_form_provider.dart';
import 'package:my_shop/providers/auth_provider.dart';
import 'package:my_shop/providers/order_list_provider.dart';
import 'package:my_shop/providers/product_list_provider.dart';
import 'package:my_shop/providers/form_product_provider.dart';
import 'package:provider/provider.dart';
import 'core/utils/app_routes.dart';
import 'providers/cart_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ProductListProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => CartProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => OrderListProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => FormProductProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => AuthFormProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => AuthProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch(
            accentColor: Colors.deepOrange,
            primarySwatch: Colors.purple,
          ),
          fontFamily: 'Lato',
        ),
        // home: const ProductsOverViewPage(),
        routes: {
          AppRoutes.authPage: (context) => const AuthPage(),
          AppRoutes.homePage: (context) => const ProductsOverViewPage(),
          AppRoutes.productDetailPage: (context) => const ProductDetailPage(),
          AppRoutes.cartPage: (context) => const CartPage(),
          AppRoutes.ordersPage: (context) => const OrdersPage(),
          AppRoutes.productsPage: (context) => const ProductPage(),
          AppRoutes.productsFormPage: (context) => const ProductFormPage(),
          // AppRoutes.productDetailPage: (context) => const CounterPage(),
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
