import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:my_shop/core/endpoints/endpoints.dart';
import 'package:my_shop/data/dummy_data.dart';
import 'package:my_shop/models/product.dart';
import 'package:my_shop/widgets/show_snackbar_dialog.dart';

class ProductListProvider with ChangeNotifier {
  final _baseUrl = 'https://my-shop-60e72-default-rtdb.firebaseio.com/';
  final List<Product> _items = dummyProducts;

  List<Product> get items => [..._items];
  List<Product> get favoriteItems =>
      _items.where((prod) => prod.isFavorite).toList();

  //metodo salve produto
  Future<void> saveProduct(
    Map<String, Object> data,
    BuildContext context,
  ) async {
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
      notifyListeners();
      return updateProduct(product).then((response) {
        const Duration(seconds: 2);

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
      });
    } else {
      notifyListeners();
      return addProduct(product, context).then((response) {
        const Duration(seconds: 2);

        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(
          showSnackBarDialog(
            backgroundColor: Colors.green,
            textColorLabel: Colors.white,
            labelActionButton: '',
            onPressed: () => Null,
            contentWidget: const Text(
              'Product added successfully!',
            ),
          ),
        );
      });
    }
  }

  //metodo add novo produto
  Future<void> addProduct(
    Product product,
    BuildContext context,
  ) async {
    final future = http.post(
      Uri.parse('$_baseUrl/products.json'),
      body: jsonEncode(
        {
          'name': product.name,
          'description': product.description,
          'price': product.price,
          'imageUrl': product.imageUrl,
          'isFavorite': product.isFavorite,
        },
      ),
    );

    return future.then<void>((response) {
      final id = jsonDecode(response.body)['name'];

      _items.add(Product(
        id: id,
        name: product.name,
        description: product.description,
        price: product.price,
        imageUrl: product.imageUrl,
        isFavorite: product.isFavorite,
      ));
      notifyListeners();
    });
  }

  Future<void> updateProduct(Product product) async {
    int index = _items.indexWhere((p) => p.id == product.id);

    //verifica se temos o ID correspondente e altera o item!
    if (index >= 0) {
      _items[index] = product;
      notifyListeners();
    }

    return Future.value();
  }

  Future<void> removeProduct(Product product) async {
    int index = _items.indexWhere((p) => p.id == product.id);

    //verifica se temos o ID correspondente e remove o item!
    if (index >= 0) {
      _items.removeWhere((p) => p.id == product.id);
      notifyListeners();
    }

    return Future.value();
  }

  int get itemsCount {
    return _items.length;
  }
}
