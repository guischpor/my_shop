import 'package:flutter/material.dart';
import 'package:my_shop/widgets/product_grid.dart';

class ProductsOverViewPage extends StatelessWidget {
  const ProductsOverViewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Shop'),
        centerTitle: true,
      ),
      body: const ProductGrid(),
    );
  }
}


