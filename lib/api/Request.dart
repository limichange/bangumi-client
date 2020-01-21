import 'package:http/http.dart' as http;

var client = http.Client();

final SERVER_URL = 'http://127.0.0.1:8080';

class Request {
  static Future<http.Response> get(url) async {
    var response;

    try {
      response = await http.get(SERVER_URL + url);
    } catch (e) {
      print('error${e.toString()}');
    }

    return response;
  }

  static Future<http.Response> post(url) async {
    var response;

    try {
      response = await http.post(SERVER_URL + url);
    } catch (e) {
      print('error${e.toString()}');
    }

    return response;
  }
}
