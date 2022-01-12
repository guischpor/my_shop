import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class StoreData {
  //metodo que salve os valores de uma string
  static Future<bool> saveString(
    String key,
    String value,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setString(key, value);
  }

  //metodo que salve os valores em uma lista
  static Future<bool> saveMap(
    String key,
    Map<String, dynamic> value,
  ) async {
    return await saveString(key, jsonEncode(value));
  }

  //metodo que le uma String que foi persistida assim que o celular foi desligado!
  static Future<String> getString(
    String key, [
    String defaultValue = '',
  ]) async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getString(key) ?? defaultValue;
  }

  //metodo que le um map
  static Future<Map<String, dynamic>> getMap(String key) async {
    try {
      return jsonDecode(await getString(key));
    } catch (e) {
      return {};
    }
  }

  //metodo que remove uma string
  static Future<bool> remove(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.remove(key);
  }
}
