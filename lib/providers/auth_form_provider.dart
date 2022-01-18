import 'package:flutter/material.dart';

class AuthFormProvider with ChangeNotifier {
  validateFormEmail(String email) {
    if (email.trim().isEmpty) {
      return 'The email field cannot be empty!';
    }

    if (!email.trim().contains(RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$'))) {
      return 'The email field must contain @!';
    }

    notifyListeners();
    return null;
  }

  validateFormPassword(String password) {
    if (password.trim().isEmpty) {
      return 'The field must be filled in!';
    }

    if (password.trim().length < 6) {
      return 'The password field must be 6 characters long!';
    }

    notifyListeners();
    return null;
  }

  validateFormConfirmationPassword(
    String password,
    TextEditingController passwordController,
  ) {
    if (password != passwordController.text) {
      return 'The passwords entered do not match!';
    }

    notifyListeners();
    return null;
  }
}
