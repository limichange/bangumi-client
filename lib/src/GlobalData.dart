import 'package:bangumi/src/utils/Utils.dart';
import 'package:flutter/foundation.dart';

class GlobalData extends ChangeNotifier {
  String _token = '';

  String get token => _token;

  GlobalData() {
    init();
  }

  init() async {
    var store = await Utils.getStore();

    updateToken(store.getString('token'));
  }

  void updateToken(token) {
    _token = token;

    notifyListeners();
  }
}
