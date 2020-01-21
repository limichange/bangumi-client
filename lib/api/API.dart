import 'package:bangumi/api/Request.dart';
import 'package:bangumi/model/Anime.dart';
import 'package:bangumi/model/User.dart';
import 'dart:convert';

class API {
  static Future<List<Anime>> getAnimeHome() async {
    final response = await Request.get('/anime/home');

    List<dynamic> myMap = json.decode(response.body);

    List<Anime> list = myMap.map((e) {
      return Anime.fromJson((e));
    }).toList();

    return list;
  }
}
