import 'package:flutter/foundation.dart';

class GlobalData extends ChangeNotifier {
  String _token = '123456';

  String get token => _token;

  void updateToken(token) {
    _token = token;

    notifyListeners();
  }
}
