import 'package:flutter/material.dart';
import 'package:my_shop/providers/product_list_provider.dart';
import 'package:my_shop/utils/app_routes.dart';
import 'package:my_shop/widgets/drawer/app_drawer.dart';
import 'package:my_shop/widgets/product_item.dart';
import 'package:provider/provider.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ProductListProvider products = Provider.of(context);

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
          itemBuilder: (context, index) => Column(
            children: [
              ProductItem(
                product: products.items[index],
              ),
              const Divider(color: Colors.grey),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.purple,
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).pushNamed(
            AppRoutes.productsFormPage,
          );
        },
      ),
    );
  }
}
