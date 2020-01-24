import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LogoutButton extends StatelessWidget {
  var onLoutout;
  var _context;

  signout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('token');

    Scaffold.of(_context).showSnackBar(SnackBar(
      content: Text("ヾ(￣▽￣)Bye~Bye~"),
    ));

//    if (onLoutout == null) {
//      onLoutout();
//    }
  }

  @override
  Widget build(BuildContext context) {
    _context = context;
    return RaisedButton(
      onPressed: () {
        signout();
      },
      child: Text('退出账号'),
    );
  }
}
