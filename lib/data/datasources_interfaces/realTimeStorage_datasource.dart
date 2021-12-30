import 'package:http/http.dart' as http;

abstract class RealTimeStorageDataSource {
  Future<http.Response> createStorage(Map body);
}
