import 'package:flutter/material.dart';
import 'package:my_shop/core/utils/app_routes.dart';
import 'package:my_shop/providers/cart_provider.dart';
import 'package:my_shop/providers/product_list_provider.dart';
import 'package:my_shop/widgets/drawer/app_drawer.dart';
import 'package:my_shop/widgets/badge.dart';
import 'package:my_shop/widgets/product_grid.dart';
import 'package:provider/provider.dart';

enum FilterOptions {
  favorite,
  all,
}

class ProductsOverViewPage extends StatefulWidget {
  const ProductsOverViewPage({Key? key}) : super(key: key);

  @override
  State<ProductsOverViewPage> createState() => _ProductsOverViewPageState();
}

class _ProductsOverViewPageState extends State<ProductsOverViewPage> {
  bool _showFavoriteOnly = false;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    Provider.of<ProductListProvider>(
      context,
      listen: false,
    ).loadingProducts().then((value) => {
          setState(() {
            _isLoading = false;
          })
        });
  }

  @override
  Widget build(BuildContext context) {
    final ProductListProvider products = Provider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Shop'),
        centerTitle: true,
        actions: [
          popupMenuButton(),
          Consumer<CartProvider>(
            child: iconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(AppRoutes.cartPage);
              },
              icon: const Icon(Icons.shopping_cart),
            ),
            builder: (context, cart, child) => Badge(
              value: cart.itemsCount.toString(),
              child: child!,
            ),
          ),
        ],
      ),
      drawer: const AppDrawer(),
      body: RefreshIndicator(
        onRefresh: () => products.refreshProducts(context),
        child: _isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ProductGrid(showFavoriteOnly: _showFavoriteOnly),
      ),
    );
  }

  PopupMenuButton<FilterOptions> popupMenuButton() {
    final ProductListProvider products = Provider.of(context);
    return PopupMenuButton(
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
        setState(
          () {
            if (selectedValue == FilterOptions.favorite) {
              _showFavoriteOnly = true;
              products.refreshProducts(context);
            } else {
              _showFavoriteOnly = false;
              products.refreshProducts(context);
            }
          },
        );
      },
    );
  }
}

Widget iconButton({
  required void Function()? onPressed,
  required Widget icon,
}) {
  return IconButton(
    onPressed: onPressed,
    icon: icon,
  );
}
