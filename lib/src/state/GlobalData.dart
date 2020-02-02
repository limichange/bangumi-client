import 'package:bangumi/src/api/API.dart';
import 'package:bangumi/src/utils/Utils.dart';
import 'package:flutter/foundation.dart';

class GlobalData extends ChangeNotifier {
  String _token = '';
  String _nickname = '';
  bool _isLogin = false;

  String get token => _token;
  String get nickname => _nickname;
  bool get isLogin => _isLogin;

  GlobalData() {
    init();
  }

  init() async {
    var store = await Utils.getStore();
    var token = store.getString('token');
    if (token != null) {
      print('init user info ');
      updateToken(token);
      getUserInfo();
    }
  }

  getUserInfo() async {
    var res = await new API().userInfo();

    if (res['status'] == 200) {
      _nickname = res['data']['nickname'];
      notifyListeners();
    }
  }

  logout() async {
    _nickname = '';
    _token = '';
    _isLogin = false;
    (await Utils.getStore()).remove('token');

    notifyListeners();
  }

  void updateToken(token) async {
    _token = token;

    if (_token != '') {
      _isLogin = true;
    }
    notifyListeners();
  }
}
