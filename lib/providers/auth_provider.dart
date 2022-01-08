import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:my_shop/core/exceptions/auth_exception.dart';
import 'package:my_shop/core/utils/constants/endpoints.dart';

class AuthProvider with ChangeNotifier {
  String? _token;
  String? _email;
  String? _uid;
  DateTime? _expireDate;

  //metodo que verifica se o usuario ainda está logado
  bool get isAuth {
    final isValid = _expireDate?.isAfter(DateTime.now()) ?? false;
    return _token != null && isValid;
  }

  //metodo que verifica o token do usuario, caso esteja autenticado
  String? get token {
    return isAuth ? _token : null;
  }

  //metodo que verifica o email do usuario, caso esteja autenticado
  String? get email {
    return isAuth ? _email : null;
  }

  //metodo que verifica o ID do usuario, caso esteja autenticado
  String? get id {
    return isAuth ? _uid : null;
  }

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

    final body = jsonDecode(response.body);

    if (body['error'] != null) {
      throw AuthException(body['error']['message']);
    } else {
      _token = body['idToken'];
      _email = body['email'];
      _uid = body['localId'];

      _expireDate = DateTime.now().add(Duration(
        seconds: int.parse(body['expiresIn']),
      ));

      notifyListeners();
    }
  }

  // metodo de cadastrar usuários
  Future<void> signup(String email, String password) async {
    return await _authenticate(email, password, '${Endpoints.signUp}');
  }

  // metodo de login
  Future<void> signIn(String email, String password) async {
    return await _authenticate(email, password, '${Endpoints.signIn}');
  }
}
