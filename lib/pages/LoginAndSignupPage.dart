import 'package:flutter/material.dart';

class LoginAndSignupPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('登录/注册'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Center(
          child: Column(children: <Widget>[
            TextFormField(
              decoration: InputDecoration(labelText: "用户名", hintText: "请输入用户名"),
            ),
            TextFormField(
              obscureText: true,
              decoration: InputDecoration(labelText: "密码", hintText: "请输入密码"),
            ),
            RaisedButton(
              child: Text('注册'),
              onPressed: () {
                // Navigate to second route when tapped.
              },
            )
          ]),
        ),
      ),
    );
  }
}
