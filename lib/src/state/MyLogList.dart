import 'package:flutter/material.dart';

class MyLogList extends ChangeNotifier {
  Map _map = new Map();

  updateStatus(String uuid, String status) {
    _map[uuid] = status;
    notifyListeners();
  }

  get map => _map;

  get(String uuid) {
    return _map[uuid] == null ? '...' : _map[uuid];
  }
}
