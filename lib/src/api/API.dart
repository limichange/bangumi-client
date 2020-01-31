import 'package:bangumi/src/model/Anime.dart';
import 'package:bangumi/src/model/User.dart';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class API {
  Dio dio = new Dio(new BaseOptions(
//    baseUrl: "http://0.0.0.0:8080/api",
    baseUrl: "https://acgdesu.com/api",
    connectTimeout: 5000,
    receiveTimeout: 3000,
  ));

  var badMessage = {'status': 400, 'message': '服务器有点忙'};

  API() {
    autoToken();
  }

  autoToken() {
    dio.interceptors
        .add(InterceptorsWrapper(onRequest: (Options options) async {
      // If no token, request token firstly and lock this interceptor
      // to prevent other request enter this interceptor.
      dio.interceptors.requestLock.lock();
      // We use a new Dio(to avoid dead lock) instance to request token.
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString('token');

      if (token != '') {
        options.headers["token"] = token;
      }
      //Set the token to headers

      dio.interceptors.requestLock.unlock();
      return options; //continue
    }));
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

  Future updatePassword(String oldPassword, String newPassword) async {
    try {
      Response response = await dio.post('/user/updatePassword',
          data: {'oldPassword': oldPassword, 'newPassword': newPassword});

      return response.data;
    } catch (e) {
      return badMessage;
    }
  }

  Future userInfo() async {
    try {
      Response response = await dio.get('/user/info');

      return response.data;
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

  Future updateAnimeLog(String uuid, String status) async {
    try {
      Response response = await dio
          .post('/animeLog/update', data: {'uuid': uuid, 'status': status});

      return response.data;
    } catch (e) {
      return badMessage;
    }
  }

  Future getAnimeHome() async {
    try {
      Response response = await dio.get('/anime/home');

      return response.data;
    } catch (e) {
      return badMessage;
    }
  }

  Future myAnimeLog(String status, num page) async {
    try {
      Response response = await dio.get('/animeLog/myLog',
          queryParameters: {'status': status, 'page': page});

      return response.data;
    } catch (e) {
      return badMessage;
    }
  }

  Future myAnimeLogDetail(String uuid) async {
    try {
      Response response = await dio
          .get('/animeLog/myLogDetail', queryParameters: {'uuid': uuid});

      return response.data;
    } catch (e) {
      return badMessage;
    }
  }

  Future searchAnime(String searchStr, num page) async {
    try {
      Response response = await dio.get('/anime/search',
          queryParameters: {'searchStr': searchStr, 'page': page});

      return response.data;
    } catch (e) {
      return badMessage;
    }
  }

  Future AnimeDetail(String uuid) async {
    try {
      Response response =
          await dio.get('/anime/detail', queryParameters: {'uuid': uuid});

      return response.data;
    } catch (e) {
      return badMessage;
    }
  }
}
