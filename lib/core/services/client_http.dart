import 'package:http/http.dart' as http;

class ClientHttp {
  Future<http.Response> get({required String url}) async {
    final response = await http.get(Uri.parse(url));
    return response;
  }

  Future<http.Response> post({required String url, Object? body}) async {
    final response = await http.post(Uri.parse(url), body: body);
    return response;
  }

  Future<http.Response> patch({required String url, Object? body}) async {
    final response = await http.patch(Uri.parse(url), body: body);
    return response;
  }

  Future<http.Response> delete({required String url}) async {
    final response = await http.delete(Uri.parse(url));
    return response;
  }
}
