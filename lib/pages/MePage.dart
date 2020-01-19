import 'package:bangumi/pages/LoginAndSignupPage/LoginAndSignupPage.dart';
import 'package:flutter/material.dart';

class MePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("我的"),
      ),
      body: (Container(
        alignment: Alignment.center,
        child: RaisedButton(
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
      )),
    );
  }
}
