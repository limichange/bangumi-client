import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LogoutButton extends StatelessWidget {
  signout(context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('token');

    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text("ヾ(￣▽￣)Bye~Bye~"),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: () {
        signout(context);
      },
      child: Text('退出账号'),
    );
  }
}
