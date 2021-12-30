import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:my_shop/data/datasources_interfaces/realTimeStorage_datasource.dart';

class RealTimeConnectionDataSourceImpl
    implements RealTimeStorageDataSource {
  @override
  Future<http.Response> createStorage(Map body) async {
    return await http.post(
      Uri.parse(
          'https://my-shop-60e72-default-rtdb.firebaseio.com/'),
      body: jsonEncode(body),
    );
  }
}
