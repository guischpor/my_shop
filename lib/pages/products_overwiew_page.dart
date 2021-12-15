import 'package:flutter/material.dart';
import 'package:my_shop/data/dummy_data.dart';
import 'package:my_shop/models/product.dart';
import 'package:my_shop/widgets/product_item.dart';

class ProductsOverViewPage extends StatelessWidget {
  final List<Product> loadedProducts = dummyProducts;

  ProductsOverViewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Shop'),
        centerTitle: true,
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: loadedProducts.length,
        itemBuilder: (context, i) => ProductItem(product: loadedProducts[i]),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
      ),
    );
  }
}
