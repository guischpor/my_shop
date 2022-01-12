import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:my_shop/core/exceptions/auth_exception.dart';
import 'package:my_shop/core/utils/constants/endpoints.dart';
import 'package:my_shop/data/store_data.dart';

class AuthProvider with ChangeNotifier {
  String? _token;
  String? _email;
  String? _userId;
  DateTime? _expireDate;
  Timer? _logoutTimer;

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
  String? get userId {
    return isAuth ? _userId : null;
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
      _userId = body['localId'];
      _expireDate = DateTime.now().add(Duration(
        seconds: int.parse(body['expiresIn']),
      ));

      //metodo que salva as informações de login automatico
      StoreData.saveMap('userData', {
        'token': _token,
        'email': _email,
        'userId': _userId,
        'expireDate': _expireDate!.toIso8601String(),
      });

      _autoLogout();

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

  //metodo que tenta fazer o auto login, assim que iniciamos o app novamente
  Future<void> tryAutoLogin() async {
    //verifica se você já está autenticado, ai retorna e sai do metodo!
    if (isAuth) return;

    //tentamos agora pegar os dados de userData
    final userData = await StoreData.getMap('userData');

    //caso o userData estiver vazio apenas retorna.
    if (userData.isEmpty) return;

    //ele pega agora a data de expiração, e verifica se o horario de expiração esta para o passado, então sai!
    final expireDate = DateTime.parse(userData['expireDate']);

    if (expireDate.isBefore(DateTime.now())) return;

    //depois de todas as verificações é que vamos tentar restaurar os dados
    _token = userData['token'];
    _email = userData['email'];
    _userId = userData['_userId'];
    _expireDate = expireDate;

    //recuperado as informações, chamamos agora o autologout
    _autoLogout();

    notifyListeners();
  }

  //metodo que desloga o usuario do app
  void logout() {
    _email = null;
    _token = null;
    _userId = null;
    _expireDate = null;
    _clearLogoutTimer();
    StoreData.remove('userData').then(
      (_) => notifyListeners(),
    );
  }

  //metodo que limpa o timer do logout
  void _clearLogoutTimer() {
    _logoutTimer?.cancel();
    _logoutTimer = null;
  }

  //metodo que faz o logout automatico apos um determinado tempo
  void _autoLogout() {
    _clearLogoutTimer();
    final timeToLogout = _expireDate?.difference(DateTime.now()).inSeconds;
    print(timeToLogout);
    _logoutTimer = Timer(
      Duration(seconds: timeToLogout ?? 0),
      logout,
    );
  }
}
