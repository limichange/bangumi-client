import 'package:http/http.dart' as http;
import 'package:bangumi/model/User.dart';
import 'dart:convert';

var client = http.Client();

final SERVER_URL = 'http://127.0.0.1:8080';

class API {
  static get(url) async {
    var response;

    try {
      response = await http.get(url);
    } catch (e) {
      print('error${e.toString()}');
    }

    return response;
  }

  static void post() async {
    // todo
  }
  static void test() {
    final response = get(SERVER_URL + '/user');

    print('Response body: ${response.body}');

    List responseJson = json.decode(response.body.toString());
//   (responseJson);

    print((responseJson[0]));

    User user = User(uuid: 'asdf', nickname: 'adsf');

    print(user.nickname);
  }
}
