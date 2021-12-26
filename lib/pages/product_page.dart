import 'package:flutter/material.dart';
import 'package:my_shop/providers/product_list.dart';
import 'package:my_shop/widgets/drawer/app_drawer.dart';
import 'package:provider/provider.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ProductList products = Provider.of(context);

    return Scaffold(
        appBar: AppBar(
          title: const Text('Manage Products'),
          centerTitle: true,
        ),
        drawer: const AppDrawer(),
        body: Padding(
          padding: const EdgeInsets.all(8),
          child: ListView.builder(
            itemCount: products.itemsCount,
            itemBuilder: (context, index) => Text(
              products.items[index].name,
            ),
          ),
        ));
  }
}
