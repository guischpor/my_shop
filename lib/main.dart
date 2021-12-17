import 'package:flutter/material.dart';
import 'package:my_shop/pages/counter_page.dart';
import 'package:my_shop/pages/product_detail_page.dart';
import 'package:my_shop/pages/products_overwiew_page.dart';
import 'package:my_shop/providers/counter.dart';
import 'package:my_shop/providers/product_list.dart';
import 'package:my_shop/utils/app_routes.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ProductList(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch(
            accentColor: Colors.deepOrange,
            primarySwatch: Colors.purple,
          ),
          fontFamily: 'Lato',
        ),
        home: ProductsOverViewPage(),
        routes: {
          AppRoutes.productDetailPage: (context) => const ProductDetailPage(),
          // AppRoutes.productDetailPage: (context) => const CounterPage(),
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
