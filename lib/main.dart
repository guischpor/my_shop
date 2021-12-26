import 'package:flutter/material.dart';
import 'package:my_shop/pages/cart_page.dart';
import 'package:my_shop/pages/orders_page.dart';
import 'package:my_shop/pages/product_detail_page.dart';
import 'package:my_shop/pages/product_page.dart';
import 'package:my_shop/pages/products_overwiew_page.dart';
import 'package:my_shop/providers/order_list.dart';
import 'package:my_shop/providers/product_list.dart';
import 'package:my_shop/utils/app_routes.dart';
import 'package:provider/provider.dart';

import 'models/cart.dart';

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
          create: (_) => ProductList(),
        ),
        ChangeNotifierProvider(
          create: (_) => Cart(),
        ),
        ChangeNotifierProvider(
          create: (_) => OrderList(),
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
          AppRoutes.homePage: (context) => const ProductsOverViewPage(),
          AppRoutes.productDetailPage: (context) => const ProductDetailPage(),
          AppRoutes.cartPage: (context) => const CartPage(),
          AppRoutes.ordersPage: (context) => const OrdersPage(),
          AppRoutes.productsPage: (context) => const ProductPage(),
          // AppRoutes.productDetailPage: (context) => const CounterPage(),
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
