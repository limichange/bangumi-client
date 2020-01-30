import 'package:bangumi/src/pages/LoginAndSignupPage/LoginAndSignupPage.dart';
import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      child: Text(
        '登录/注册',
      ),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LoginAndSignupPage()),
        );
      },
      color: Colors.pink[300],
      textColor: Colors.white,
    );
  }
}
