import 'package:flutter/material.dart';
import 'package:my_shop/providers/product_list.dart';
import 'package:my_shop/widgets/product_grid.dart';
import 'package:provider/provider.dart';

enum FilterOptions {
  favorite,
  all,
}

class ProductsOverViewPage extends StatelessWidget {
  const ProductsOverViewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProductList>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Shop'),
        centerTitle: true,
        actions: [
          PopupMenuButton(
            //icon: const Icon(Icons.more_vert),
            itemBuilder: (_) => [
              const PopupMenuItem(
                child: Text('Somente Favoritos'),
                value: FilterOptions.favorite,
              ),
              const PopupMenuItem(
                child: Text('Todos'),
                value: FilterOptions.all,
              ),
            ],
            onSelected: (FilterOptions selectedValue) {
              if (selectedValue == FilterOptions.favorite) {
                provider.showFavoriteOnly();
              } else {
                provider.showAll();
              }
            },
          ),
        ],
      ),
      body: const ProductGrid(),
    );
  }
}
