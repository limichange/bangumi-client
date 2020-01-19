import 'package:bangumi/pages/LoginAndSignupPage.dart';
import 'package:flutter/material.dart';

class MePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return (Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          RaisedButton(
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
          ),
        ],
      ),
    ));
  }
}
