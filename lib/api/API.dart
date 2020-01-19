import 'package:http/http.dart' as http;

class API {
  static void test() async {
    var url = 'https://example.com/whatsit/create';

    try {
      var response =
          await http.post(url, body: {'name': 'doodle', 'color': 'blue'});
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      print(await http.read('https://example.com/foobar.txt'));
    } finally {
      print('ok');
    }
  }
}
