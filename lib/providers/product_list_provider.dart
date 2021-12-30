import 'dart:math';
import 'package:flutter/material.dart';
import 'package:my_shop/data/dummy_data.dart';
import 'package:my_shop/models/product.dart';
import 'package:my_shop/widgets/show_snackbar_dialog.dart';

class ProductListProvider with ChangeNotifier {
  final List<Product> _items = dummyProducts;

  List<Product> get items => [..._items];
  List<Product> get favoriteItems =>
      _items.where((prod) => prod.isFavorite).toList();

  void saveProduct(
    Map<String, Object> data,
    BuildContext context,
  ) {
    bool hasId = data['id'] != null;

    final product = Product(
      id: hasId ? data['id'] as String : Random().nextDouble().toString(),
      name: data['name'] as String,
      description: data['description'] as String,
      price: data['price'] as double,
      imageUrl: data['imageUrl'] as String,
    );

    //metodo que verifica se ele tem um ID ele alterar, caso não, ele cria uma novo item
    if (hasId) {
      updateProduct(product);

      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        showSnackBarDialog(
          backgroundColor: Colors.green,
          textColorLabel: Colors.white,
          labelActionButton: '',
          onPressed: () => Null,
          contentWidget: const Text(
            'Product edited successfully!',
          ),
        ),
      );
    } else {
      addProduct(product);

      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        showSnackBarDialog(
          backgroundColor: Colors.green,
          textColorLabel: Colors.white,
          labelActionButton: '',
          onPressed: () => Null,
          contentWidget: const Text(
            'Product successfully added!',
          ),
        ),
      );
    }

    notifyListeners();
  }

  //metodo add novo produto
  void addProduct(Product product) {
    _items.add(product);
    notifyListeners();
  }

  void updateProduct(Product product) {
    int index = _items.indexWhere((p) => p.id == product.id);

    //verifica se temos o ID correspondente e altera o item!
    if (index >= 0) {
      _items[index] = product;
      notifyListeners();
    }
  }

  void removeProduct(Product product) {
    int index = _items.indexWhere((p) => p.id == product.id);

    //verifica se temos o ID correspondente e remove o item!
    if (index >= 0) {
      _items.removeWhere((p) => p.id == product.id);
      notifyListeners();
    }
  }

  int get itemsCount {
    return _items.length;
  }
}
