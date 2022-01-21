import 'package:flutter/material.dart';
import 'package:my_shop/core/exceptions/http_exceptions.dart';
import 'package:my_shop/core/utils/app_routes.dart';
import 'package:my_shop/models/categories_model.dart';
import 'package:my_shop/providers/categories_provider.dart';
import 'package:my_shop/widgets/show_dialog.dart';
import 'package:my_shop/widgets/show_snackbar_dialog.dart';
import 'package:provider/provider.dart';

class CategorieItem extends StatelessWidget {
  final CategoriesModel categorie;

  const CategorieItem({
    Key? key,
    required this.categorie,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _body(context);
  }

  //estrutura do componente
  Widget _body(BuildContext context) {
    return ListTile(
      title: Text(categorie.name),
      trailing: _panelButtons(context),
    );
  }

  //estrutura do painel
  Widget _panelButtons(BuildContext context) {
    final msg = ScaffoldMessenger.of(context);
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
                AppRoutes.categoriesFormPage,
                arguments: categorie,
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
                    'Do you want to remove the item from your categorie list?',
                textButton1: 'No',
                onTapButton1: () {
                  Navigator.of(context).pop(false);
                },
                textButton2: 'Yes',
                onTapButton2: () {
                  Navigator.of(context).pop(true);
                },
              ).then((value) async {
                if (value ?? false) {
                  try {
                    await Provider.of<CategoriesProvider>(
                      context,
                      listen: false,
                    ).removeCategorie(categorie, context);

                    msg.hideCurrentSnackBar();
                    msg.showSnackBar(
                      showSnackBarDialog(
                        backgroundColor: Colors.green,
                        textColorLabel: Colors.white,
                        labelActionButton: '',
                        onPressed: () => Null,
                        contentWidget: const Text(
                          'Successfully deleted categorie!',
                        ),
                      ),
                    );
                  } on HttpException catch (error) {
                    // ignore: avoid_print
                    print(error.toString());

                    msg.hideCurrentSnackBar();
                    msg.showSnackBar(
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
                }
              });
            },
          ),
        ],
      ),
    );
  }
}
