import 'package:flutter/material.dart';
import 'package:my_shop/core/utils/constants/endpoints.dart';
import 'package:my_shop/models/categories_model.dart';

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
  Future<void> loadingCategories() async {}

  //metodo que salva os items de categorias
  Future<void> saveCategories(
    Map<String, Object> data,
    BuildContext context,
  ) async {}

  //metodo add nova categoria
  Future<void> addProduct(
    CategoriesModel categories,
    BuildContext context,
  ) async {}

  //metodo altera nova categoria
  Future<void> updateProduct(
    CategoriesModel categories,
  ) async {}

  //metodo que remove um item categoria
  Future<void> removeProduct(
    CategoriesModel categories,
  ) async {}
}
