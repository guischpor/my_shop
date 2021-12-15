import 'package:flutter/material.dart';
import 'package:my_shop/models/product.dart';

class ProductDetailPage extends StatelessWidget {
  const ProductDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Product products =
        ModalRoute.of(context)!.settings.arguments as Product;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          products.title,
        ),
        centerTitle: true,
      ),
      body: Container(),
    );
  }
}
