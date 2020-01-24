import 'package:bangumi/src/GlobalData.dart';
import 'package:bangumi/src/utils/Utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LogoutButton extends StatelessWidget {
  var onLoutout;
  var _context;
  var globalData;

  signout() async {
    (await Utils.getStore()).remove('token');

    Utils.showToast(context: _context, text: "ヾ(￣▽￣)Bye~Bye~");

    globalData.updateToken('');
  }

  @override
  Widget build(BuildContext context) {
    _context = context;
    globalData = Provider.of<GlobalData>(_context);

    return RaisedButton(
      onPressed: () {
        signout();
      },
      child: Text('退出账号'),
    );
  }
}
