import 'package:flutter/material.dart';
import 'package:my_shop/models/product.dart';
import 'package:my_shop/providers/product_list_provider.dart';
import 'package:my_shop/utils/app_routes.dart';
import 'package:my_shop/widgets/show_dialog.dart';
import 'package:my_shop/widgets/show_snackbar_dialog.dart';
import 'package:provider/provider.dart';

class ProductItem extends StatelessWidget {
  final Product product;

  const ProductItem({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _body(context);
  }

  //estrutura do componente
  Widget _body(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(product.imageUrl),
      ),
      title: Text(product.name),
      trailing: _panelButtons(context),
    );
  }

  //estrutura do painel
  Widget _panelButtons(BuildContext context) {
    bool isDisable = false;
    return SizedBox(
      width: 100,
      child: Row(
        children: [
          IconButton(
            icon: const Icon(
              Icons.edit,
              color: Colors.purple,
            ),
            onPressed: () {
              Navigator.of(context).pushNamed(
                AppRoutes.productsFormPage,
                arguments: product,
              );
            },
          ),
          IconButton(
            icon: Icon(
              Icons.delete,
              color: Colors.red[700],
            ),
            onPressed: () {
              showDialogModal(
                context: context,
                title: 'Are you sure?',
                message:
                    'Do you want to remove the item from your product list?',
                textButton1: 'No',
                onTapButton1: () {
                  Navigator.of(context).pop(false);
                },
                textButton2: 'Yes',
                onTapButton2: () {
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  ScaffoldMessenger.of(context).showSnackBar(
                    showSnackBarDialog(
                      backgroundColor: Colors.red[700],
                      textColorLabel: Colors.white,
                      labelActionButton: '',
                      onPressed: () => Null,
                      contentWidget: const Text(
                        'Successfully deleted product!',
                      ),
                    ),
                  );

                  Navigator.of(context).pop(true);
                },
              ).then((value) {
                if (value ?? false) {
                  Provider.of<ProductListProvider>(
                    context,
                    listen: false,
                  ).removeProduct(product);
                }
              });
            },
          ),
        ],
      ),
    );
  }
}
