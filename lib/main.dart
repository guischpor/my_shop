import 'package:flutter/material.dart';
import 'package:my_shop/pages/product_detail_page.dart';
import 'package:my_shop/pages/products_overwiew_page.dart';
import 'package:my_shop/utils/app_routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
