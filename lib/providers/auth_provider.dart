import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:my_shop/core/utils/constants/endpoints.dart';

class AuthProvider with ChangeNotifier {
  Future<void> _authenticate(
    String email,
    String password,
    String urlFragment,
  ) async {
    final url =
        'https://identitytoolkit.googleapis.com/v1/accounts:$urlFragment?key=AIzaSyAkKiw68T60NpZ_AsjY58zO9TciVSwC28I';

    final response = await http.post(
      Uri.parse(url),
      body: jsonEncode({
        'email': email,
        'password': password,
        'returnSecureToken': true,
      }),
    );

    print(response.body);
  }

  // metodo de cadastrar usuários
  Future<void> signup(String email, String password) async {
    await _authenticate(email, password, '${Endpoints.signUp}');
  }

  // metodo de login
  Future<void> signIn(String email, String password) async {
    await _authenticate(email, password, '${Endpoints.signIn}');
  }
}