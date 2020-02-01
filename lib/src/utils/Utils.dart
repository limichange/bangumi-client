import 'package:bangumi/src/pages/AnimeDetailPage/AnimeDetailPage.dart';
import 'package:bangumi/src/pages/LoginAndSignupPage/LoginAndSignupPage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Utils {
  static showToast({context, text}) {
    Scaffold.of(context).showSnackBar(SnackBar(
      duration: Duration(seconds: 1),
      content: Text(text),
    ));
  }

  static Future<SharedPreferences> getStore() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs;
  }

  static goLogin(context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoginAndSignupPage()),
    );
  }

  static go(context, page) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }

  static goAnimeDetail(context, uuid) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => AnimeDetailPage(
                uuid: uuid,
              )),
    );
  }
}
