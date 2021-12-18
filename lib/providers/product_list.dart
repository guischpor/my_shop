import 'package:flutter/material.dart';
import 'package:my_shop/data/dummy_data.dart';
import 'package:my_shop/models/product.dart';

class ProductList with ChangeNotifier {
  List<Product> _items = dummyProducts;
  bool _showFavoriteOnly = false;

  List<Product> get items {
    //metodo que filtra todos os items favoritos
    if (_showFavoriteOnly) {
      return _items.where((prod) => prod.isFavorite).toList();
    }

    return [...items];
  }

  void showFavoriteOnly() {
    _showFavoriteOnly = true;
  }

  void showAll() {
    _showFavoriteOnly = false;
  }

  void addProduct(Product product) {
    _items.add(product);
    notifyListeners();
  }
}
