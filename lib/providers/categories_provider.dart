import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:my_shop/core/utils/constants/endpoints.dart';
import 'package:my_shop/models/categories_model.dart';
import 'package:my_shop/widgets/show_snackbar_dialog.dart';

class CategoriesProvider with ChangeNotifier {
  String _token;
  List<CategoriesModel> _items = [];

  List<CategoriesModel> get items => [..._items];

  CategoriesProvider([
    this._token = '',
    this._items = const [],
  ]);

  int get itemsCount {
    return _items.length;
  }

  //metodo que atualiza a lista de categorias
  Future<void> refreshCategories(BuildContext context) async {
    notifyListeners();
    return await loadingCategories();
  }

  //metodo que carrega os produtos
  Future<void> loadingCategories() async {
    _items.clear();

    final response = await http.get(
      Uri.parse(
        '${Endpoints.categoriesUrl}.json?auth=$_token',
      ),
    );

    if (response.body != 'null') return;

    Map<String, dynamic> data = jsonDecode(response.body);

    data.forEach((categorieId, categorieData) {
      _items.add(CategoriesModel(
        id: categorieId,
        name: categorieData['name'],
      ));
    });

    notifyListeners();
  }

  //metodo que salva os items de categorias
  Future<void> saveCategorie(
    Map<String, Object> data,
    BuildContext context, [
    bool? isEdited,
    bool? isAdd,
  ]) async {
    bool hasId = data['id'] != null;

    final categorie = CategoriesModel(
      id: hasId ? data['id'] as String : Random().nextDouble().toString(),
      name: data['name'] as String,
    );

    if (hasId) {
      notifyListeners();
      return await updateCategorie(categorie).then((response) {
        const Duration(seconds: 2);

        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(
          showSnackBarDialog(
            backgroundColor: Colors.green,
            textColorLabel: Colors.white,
            labelActionButton: '',
            onPressed: () => Null,
            contentWidget: const Text(
              'Categorie edited successfully!',
            ),
          ),
        );
      });
    } else {
      notifyListeners();

      return await addCategorie(categorie, context).then((response) {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(
          showSnackBarDialog(
            backgroundColor: Colors.green,
            textColorLabel: Colors.white,
            labelActionButton: '',
            onPressed: () => Null,
            contentWidget: const Text(
              'Categorie added successfully!',
            ),
          ),
        );
      });
    }
  }

  //metodo add nova categoria
  Future<void> addCategorie(
    CategoriesModel categories,
    BuildContext context,
  ) async {
    final response = await http.post(
      Uri.parse(
        '${Endpoints.categoriesUrl}.json?auth=$_token',
      ),
      body: jsonEncode(
        {
          'name': categories.name,
        },
      ),
    );

    final id = jsonDecode(response.body)['name'];

    _items.add(CategoriesModel(
      id: id,
      name: categories.name,
    ));

    notifyListeners();
  }

  //metodo altera nova categoria
  Future<void> updateCategorie(
    CategoriesModel categories,
  ) async {}

  //metodo que remove um item categoria
  Future<void> removeCategorie(
    CategoriesModel categories,
    BuildContext context,
  ) async {}
}
