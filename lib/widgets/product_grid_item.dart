import 'package:flutter/material.dart';
import 'package:my_shop/core/exceptions/http_exceptions.dart';
import 'package:my_shop/core/utils/app_routes.dart';
import 'package:my_shop/providers/auth_provider.dart';
import 'package:my_shop/providers/cart_provider.dart';
import 'package:my_shop/models/product.dart';
import 'package:my_shop/widgets/show_snackbar_dialog.dart';
import 'package:provider/provider.dart';

class ProductGridItem extends StatelessWidget {
  const ProductGridItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);
    final cart = Provider.of<CartProvider>(context);
    final auth = Provider.of<AuthProvider>(context, listen: false);

    final scaffoldMessenger = ScaffoldMessenger.of(context);

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: InkWell(
          onTap: () {
            Navigator.of(context).pushNamed(
              AppRoutes.productDetailPage,
              arguments: product,
            );
          },
          child: Hero(
            tag: product.id,
            child: FadeInImage(
              placeholder:
                  const AssetImage('assets/images/product-placeholder.png'),
              image: NetworkImage(product.imageUrl),
              fit: BoxFit.cover,
            ),
          ),
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black87,
          leading: Consumer<Product>(
            builder: (context, product, _) => IconButton(
              onPressed: () async {
                try {
                  await product.toggleFavorite(
                    auth.token ?? '',
                    auth.userId ?? '',
                  );
                } on HttpException catch (error) {
                  scaffoldMessenger.hideCurrentSnackBar();
                  scaffoldMessenger.showSnackBar(
                    showSnackBarDialog(
                      backgroundColor: Colors.red[700],
                      textColorLabel: Colors.white,
                      labelActionButton: '',
                      onPressed: () => Null,
                      contentWidget: Text(
                        error.toString(),
                      ),
                    ),
                  );
                }
              },
              icon: Icon(
                product.isFavorite ? Icons.favorite : Icons.favorite_border,
                color: Colors.red,
              ),
            ),
          ),
          title: Text(
            product.name,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 13),
          ),
          trailing: IconButton(
            icon: const Icon(
              Icons.shopping_cart,
              color: Colors.red,
            ),
            onPressed: () {
              scaffoldMessenger.hideCurrentSnackBar();
              scaffoldMessenger.showSnackBar(
                showSnackBarDialog(
                  backgroundColor: Colors.green,
                  labelActionButton: 'UNDO',
                  textColorLabel: Colors.white,
                  onPressed: () {
                    cart.removeSingleItem(product.id);
                  },
                  contentWidget: const Text(
                    'Product successfully added!',
                  ),
                ),
              );

              cart.addItem(product);
            },
          ),
        ),
      ),
    );
  }
}
