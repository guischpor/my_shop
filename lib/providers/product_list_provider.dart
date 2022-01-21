import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:my_shop/core/exceptions/http_exceptions.dart';
import 'package:my_shop/core/utils/constants/endpoints.dart';
// import 'package:my_shop/data/dummy_data.dart';
import 'package:my_shop/models/product.dart';
import 'package:my_shop/widgets/show_snackbar_dialog.dart';

class ProductListProvider with ChangeNotifier {
  // final List<Product> _items = dummyProducts;
  String _token;
  String _userId;
  List<Product> _items = [];

  List<Product> get items => [..._items];
  List<Product> get favoriteItems =>
      _items.where((prod) => prod.isFavorite).toList();

  ProductListProvider([
    this._token = '',
    this._userId = '',
    this._items = const [],
  ]);

  int get itemsCount {
    return _items.length;
  }

  //metodo que atualiza a lista de produtos
  Future<void> refreshProducts(BuildContext context) async {
    notifyListeners();
    return await loadingProducts();
  }

//metodo que carrega os produtos
  Future<void> loadingProducts() async {
    _items.clear();

    final response = await http.get(
      Uri.parse(
        '${Endpoints.productBaseUrl}.json?auth=$_token',
      ),
    );
    // print(jsonDecode(response.body));

    if (response.body == 'null') return;

    //favResponse é uma requisição get que tras a lista de produtos favoritados pelo usuario
    final favResponse = await http.get(
      Uri.parse(
        '${Endpoints.userFavoritesUrl}/$_userId.json?auth=$_token',
      ),
    );

    Map<String, dynamic> favData =
        favResponse.body == 'null' ? {} : jsonDecode(favResponse.body);

    Map<String, dynamic> data = jsonDecode(response.body);

    data.forEach((productId, productData) {
      final isFavorite = favData[productId] ?? false;
      _items.add(Product(
        id: productId,
        name: productData['name'],
        description: productData['description'],
        price: productData['price'],
        imageUrl: productData['imageUrl'],
        categorie: productData['categorie'],
        isFavorite: isFavorite,
      ));
    });

    notifyListeners();
  }

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
      categorie: data['categorie'] as String,
    );

    //metodo que verifica se ele tem um ID ele alterar, caso não, ele cria uma novo item
    if (hasId) {
      notifyListeners();
      return await updateProduct(product).then((response) {
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

      return await addProduct(product, context).then((response) {
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
    final response = await http.post(
      Uri.parse(
        '${Endpoints.productBaseUrl}.json?auth=$_token',
      ),
      body: jsonEncode(
        {
          'name': product.name,
          'description': product.description,
          'price': product.price,
          'imageUrl': product.imageUrl,
          'categorie': product.categorie,
        },
      ),
    );

    final id = jsonDecode(response.body)['name'];

    _items.add(Product(
      id: id,
      name: product.name,
      description: product.description,
      price: product.price,
      imageUrl: product.imageUrl,
      categorie: product.categorie,
    ));
    notifyListeners();
  }

  Future<void> updateProduct(Product product) async {
    int index = _items.indexWhere((p) => p.id == product.id);

    //verifica se temos o ID correspondente e altera o item!
    if (index >= 0) {
      await http.patch(
        Uri.parse(
          '${Endpoints.productBaseUrl}/${product.id}.json?auth=$_token',
        ),
        body: jsonEncode(
          {
            'name': product.name,
            'description': product.description,
            'price': product.price,
            'imageUrl': product.imageUrl,
            'categorie': product.categorie,
          },
        ),
      );

      _items[index] = product;
      notifyListeners();
    }
  }

  Future<void> removeProduct(
    Product product,
    BuildContext context,
  ) async {
    int index = _items.indexWhere((p) => p.id == product.id);

    //verifica se temos o ID correspondente e remove o item!
    if (index >= 0) {
      final product = _items[index];

      //primeiramente será excluido o item localmente
      _items.remove(product);
      notifyListeners();

      //caso a resposta de certo, sera removido no firebase
      final response = await http.delete(
        Uri.parse(
          '${Endpoints.productBaseUrl}/${product.id}.json?auth=$_token',
        ),
      );

      //caso contrario, ele recupera os items excluidos
      if (response.statusCode >= 400) {
        _items.insert(index, product);
        notifyListeners();
        throw HttpException(
          msg: 'Error deleting the product!',
          statusCode: response.statusCode,
        );
      }
    }
  }
}
