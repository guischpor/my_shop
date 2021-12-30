import 'dart:math';
import 'package:flutter/material.dart';
import 'package:my_shop/providers/cart_provider.dart';
import 'package:my_shop/models/order_model.dart';

class OrderListProvider with ChangeNotifier {
  List<OrderModel> _items = [];

  List<OrderModel> get items {
    return [..._items];
  }

  //retorna a quantidade de itens de pedido
  int get itemsCount {
    return _items.length;
  }

  void addOrder(CartProvider cart) {
    _items.insert(
      0,
      OrderModel(
        id: Random().nextDouble().toString(),
        total: cart.totalAmount,
        date: DateTime.now(),
        products: cart.items.values.toList(),
      ),
    );
    notifyListeners();
  }
}
