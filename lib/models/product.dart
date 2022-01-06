import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:my_shop/core/exceptions/http_exceptions.dart';
import 'package:my_shop/core/utils/constants/endpoints.dart';

class Product with ChangeNotifier {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    this.isFavorite = false,
  });

  void _toggleFavorite() {
    isFavorite = !isFavorite;
    notifyListeners();
  }

  //Alternar o valor de Favorito
  Future<void> toggleFavorite() async {
    _toggleFavorite();

    final response = await http.patch(
      Uri.parse('${Endpoints.productBaseUrl}/$id.json'),
      body: jsonEncode({'isFavorite': isFavorite}),
    );

    if (response.statusCode >= 400) {
      _toggleFavorite();
      throw HttpException(
        msg: 'Error adding product as favorite!',
        statusCode: response.statusCode,
      );
    }
  }
}
