import 'package:bangumi/src/api/API.dart';
import 'package:bangumi/src/utils/Utils.dart';
import 'package:flutter/foundation.dart';

class GlobalData extends ChangeNotifier {
  String _token = '';
  String _nickname = '';
  bool _isLogin = false;
  num _pageIndex = 0;

  String get token => _token;
  String get nickname => _nickname;
  bool get isLogin => _isLogin;
  num get pageIndex => _pageIndex;

  GlobalData() {
    init();
  }

  updatePageIndex(index) {
    _pageIndex = index;
    notifyListeners();
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
    var res = await api.userInfo();

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
