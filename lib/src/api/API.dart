import 'package:bangumi/src/model/Anime.dart';
import 'package:bangumi/src/model/User.dart';
import 'dart:convert';
import 'package:dio/dio.dart';

class API {
  Dio dio = new Dio(new BaseOptions(
    baseUrl: "http://127.0.0.1:8080",
    connectTimeout: 5000,
    receiveTimeout: 3000,
  ));

  Future<User> login(String username, String password) async {
    print(username + password);
    await dio.post('/user/login');
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
