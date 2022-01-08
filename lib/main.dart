import 'package:flutter/material.dart';
import 'package:my_shop/pages/auth_or_home_page.dart';
import 'package:my_shop/pages/cart_page.dart';
import 'package:my_shop/pages/orders_page.dart';
import 'package:my_shop/pages/product_detail_page.dart';
import 'package:my_shop/pages/product_form_page.dart';
import 'package:my_shop/pages/product_page.dart';
import 'package:provider/provider.dart';
import 'core/providers_list/providers_list.dart';
import 'core/utils/app_routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final list = ProvidersList();

    return MultiProvider(
      providers: list.providers,
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
          AppRoutes.authOrHomePage: (context) => const AuthOrHomePage(),
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
