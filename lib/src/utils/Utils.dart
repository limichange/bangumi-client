import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Utils {
  static showToast({context, text}) {
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(text),
    ));
  }

  static Future<SharedPreferences> getStore() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs;
  }
}
