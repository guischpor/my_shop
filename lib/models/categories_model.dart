import 'package:flutter/material.dart';

class CategoriesModel with ChangeNotifier {
  final String id;
  final String name;

  CategoriesModel({
    required this.id,
    required this.name,
  });
}
