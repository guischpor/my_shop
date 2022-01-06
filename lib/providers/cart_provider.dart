import 'dart:math';
import 'package:flutter/material.dart';
import 'package:my_shop/models/cart_item.dart';
import 'package:my_shop/models/product.dart';

class CartProvider with ChangeNotifier {
  Map<String, CartItemModel> _items = {};

  Map<String, CartItemModel> get items {
    return {..._items};
  }

  //metodo que calcula a quantidade de itens no carrinho
  int get itemsCount {
    return _items.length;
  }

  //metodo que calcula o total dos preços do carrinho
  double get totalAmount {
    double total = 0.0;
    _items.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity;
    });

    return total;
  }

  //metodo pra add items no carrinho
  void addItem(Product product) {
    if (_items.containsKey(product.id)) {
      _items.update(
        product.id,
        (existingItem) => CartItemModel(
          id: existingItem.id,
          productId: existingItem.productId,
          name: existingItem.name,
          quantity: existingItem.quantity + 1,
          price: existingItem.price,
        ),
      );
    } else {
      _items.putIfAbsent(
        product.id,
        () => CartItemModel(
          id: Random().nextDouble().toString(),
          productId: product.id,
          name: product.name,
          quantity: 1,
          price: product.price,
        ),
      );
    }
    notifyListeners();
  }

  //metodo remove items do carrinho
  void removedItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  //metodo remove o ultimo item add
  void removeSingleItem(String productId) {
    if (!_items.containsKey(productId)) {
      return;
    }

    if (_items[productId]?.quantity == 1) {
      _items.remove(productId);
    } else {
      _items.update(
        productId,
        (existingItem) => CartItemModel(
          id: existingItem.id,
          productId: existingItem.productId,
          name: existingItem.name,
          quantity: existingItem.quantity - 1,
          price: existingItem.price,
        ),
      );
    }
    notifyListeners();
  }

  //metodo remove todos os items
  void clear() {
    _items = {};
    notifyListeners();
  }
}
