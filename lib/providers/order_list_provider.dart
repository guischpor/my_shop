import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:my_shop/core/utils/constants/endpoints.dart';
import 'package:my_shop/models/cart_item.dart';
import 'package:my_shop/providers/cart_provider.dart';
import 'package:my_shop/models/order_model.dart';

class OrderListProvider with ChangeNotifier {
  String _token;
  String _userId;
  List<OrderModel> _items = [];

  List<OrderModel> get items {
    return [..._items];
  }

  OrderListProvider([
    this._token = '',
    this._userId = '',
    this._items = const [],
  ]);

  //retorna a quantidade de itens de pedido
  int get itemsCount {
    return _items.length;
  }

  //metodo que atualiza a lista de produtos
  Future<void> refreshOrders(BuildContext context) async {
    notifyListeners();
    return await loadingOrders();
  }

  //metodo que carrega os produtos
  Future<void> loadingOrders() async {
    List<OrderModel> items = [];

    final response = await http.get(
      Uri.parse(
        '${Endpoints.ordersBaseUrl}/$_userId.json?auth=$_token',
      ),
    );

    if (response.body == 'null') return;

    Map<String, dynamic> data = jsonDecode(response.body);

    data.forEach(
      (orderId, orderData) {
        items.add(
          OrderModel(
            id: orderId,
            date: DateTime.parse(orderData['date']),
            total: orderData['total'],
            products: (orderData['products'] as List<dynamic>).map((item) {
              return CartItemModel(
                id: item['id'],
                productId: item['productId'],
                name: item['name'],
                quantity: item['quantity'],
                price: item['price'],
              );
            }).toList(),
          ),
        );
      },
    );

    _items = items.reversed.toList();

    notifyListeners();
  }

  Future<void> addOrder(CartProvider cart) async {
    final date = DateTime.now();

    final response = await http.post(
      Uri.parse(
        '${Endpoints.ordersBaseUrl}/$_userId.json?auth=$_token',
      ),
      body: jsonEncode(
        {
          'total': cart.totalAmount,
          'date': date.toIso8601String(),
          'products': cart.items.values
              .map((cartItem) => {
                    'id': cartItem.id,
                    'productId': cartItem.productId,
                    'name': cartItem.name,
                    'quantity': cartItem.quantity,
                    'price': cartItem.price,
                  })
              .toList(),
        },
      ),
    );

    final id = jsonDecode(response.body)['name'];

    _items.insert(
      0,
      OrderModel(
        id: id,
        total: cart.totalAmount,
        date: date,
        products: cart.items.values.toList(),
      ),
    );
    notifyListeners();
  }
}
