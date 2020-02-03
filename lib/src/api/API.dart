import 'package:bangumi/src/model/Anime.dart';
import 'package:bangumi/src/model/User.dart';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

API api = API();

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

  Future get(String url, {queryParameters}) async {
    try {
      Response response = queryParameters == null
          ? await dio.get(url)
          : await dio.get(url, queryParameters: queryParameters);

      return response.data;
    } catch (e) {
      return badMessage;
    }
  }

  Future post(String url, data) async {
    try {
      Response response = await dio.post(url, data: data);

      return response.data;
    } catch (e) {
      return badMessage;
    }
  }

  Future appVersion() => get('/app/version');
  Future appUpdateLog() => get('/app/updateLog');
  Future addFeedback(String content, String type, String animeUuid) => post(
      '/feedback/add',
      {'content': content, 'type': type, 'animeUuid': animeUuid});
  Future login(String username, String password) =>
      post('/user/login', {'username': username, 'password': password});

  Future updatePassword(String oldPassword, String newPassword) => post(
      '/user/updatePassword',
      {'oldPassword': oldPassword, 'newPassword': newPassword});

  Future userInfo() => get('/user/info');
  Future singup({String username, String password, String nickname}) {
    return post('/user/signup',
        {'username': username, 'nickname': nickname, 'password': password});
  }

  Future updateAnimeLog(String uuid, String status) =>
      post('/animeLog/update', {'uuid': uuid, 'status': status});

  Future getAnimeHome() {
    return get('/anime/home');
  }

  Future myAnimeLog(String status, num page) =>
      get('/animeLog/myLog', queryParameters: {'status': status, 'page': page});

  Future myAnimeLogDetail(String uuid) =>
      get('/animeLog/myLogDetail', queryParameters: {'uuid': uuid});

  Future getEpisodeByAnime(String uuid) =>
      get('/episode/getByAnime', queryParameters: {'uuid': uuid});

  Future searchAnime(String searchStr, num page) => get('/anime/search',
      queryParameters: {'searchStr': searchStr, 'page': page});

  Future AnimeDetail(String uuid) =>
      get('/anime/detail', queryParameters: {'uuid': uuid});
}
