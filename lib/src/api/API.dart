import 'package:bangumi/src/model/Anime.dart';
import 'package:bangumi/src/model/User.dart';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class API {
  Dio dio = new Dio(new BaseOptions(
    baseUrl: "http://127.0.0.1:8080",
    connectTimeout: 5000,
    receiveTimeout: 3000,
  ));

  var badMessage = {'status': 400, 'message': '服务器有点忙'};

  API() {
    autoToken();
  }

  autoToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String token = prefs.getString('token');

    if (token != null) {
      dio.options.headers["token"] = token;
    }
  }

  Future login(String username, String password) async {
    try {
      Response response = await dio.post('/user/login',
          data: {'username': username, 'password': password});

      return response.data;
    } catch (e) {
      return badMessage;
    }
  }

  Future userInfo() async {
    try {
      Response response = await dio.get('/user/info');

      print(response);
    } catch (e) {
      return badMessage;
    }
  }

  Future singup({String username, String password, String nickname}) async {
    try {
      Response response = await dio.post('/user/signup', data: {
        'username': username,
        'nickname': nickname,
        'password': password
      });

      return response.data;
    } catch (e) {
      return badMessage;
    }
  }

  Future<List<Anime>> getAnimeHome() async {
    List<Anime> list = new List<Anime>();

    try {
      Response response = await dio.get('/anime/home');

      response.data.forEach((e) {
        list.add(Anime.fromJson(e));
      });
    } catch (e) {
      print(e);
    }

    return list;
  }

  Future<Anime> getAnimeByUUID(String uuid) async {
    Response response = await dio.get('/anime/uuid/${uuid}');

    print(response);

    return Anime.fromJson(json.decode(response.toString()));
  }
}
