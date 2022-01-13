import 'package:flutter/material.dart';

class CategoriesFormProvider with ChangeNotifier {
  //validação do campo categories name
  validateFormName(String name) {
    if (name.trim().isEmpty) {
      return 'The category name field is required!!';
    }

    if (name.trim().length < 3) {
      return 'The Category Name field must be longer than 3 characters!';
    }

    notifyListeners();
    return null;
  }
}
