import 'package:flutter/material.dart';

class FormProductProvider with ChangeNotifier {
  //validação do campo name
  validateFormName(String value) {
    if (value.trim().isEmpty) {
      return 'The name field needs to be filled in!';
    }

    if (value.trim().length < 3) {
      return 'The name field must be at least 3 letters!';
    }

    notifyListeners();
    return null;
  }

  //validacao do campo price
  validateFormPrice(String valueString) {
    final price = double.tryParse(valueString) ?? -1;

    if (price <= 0) {
      return 'Please inform a valid price!';
    }

    notifyListeners();
    return null;
  }

  //validacao do campo description
  validateFormDescription(String value) {
    if (value.trim().isEmpty) {
      return 'The description field needs to be filled in!';
    }

    if (value.trim().length < 10) {
      return 'The description field must be at least 10 letters!';
    }

    notifyListeners();
    return null;
  }

  //validacao do campo da Url image
  isValidImageUrl(String url) {
    bool isValidUrl = Uri.tryParse(url)?.hasAbsolutePath ?? false;
    bool endsWithFile = url.toLowerCase().endsWith('.png') ||
        url.toLowerCase().endsWith('.jpg') ||
        url.toLowerCase().endsWith('.jpeg');

    final validImage = isValidUrl && endsWithFile;

    if (!validImage) {
      return 'Please enter a valid URL!';
    }

    notifyListeners();
    return null;
  }
}
