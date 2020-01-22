import 'package:flutter/material.dart';

class SignupForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Center(
          child: Column(children: <Widget>[
            TextFormField(
              decoration:
                  InputDecoration(labelText: "用户名", hintText: "使用邮箱或者手机号"),
            ),
            TextFormField(
              decoration: InputDecoration(labelText: "昵称", hintText: "你的昵称"),
            ),
            TextFormField(
              obscureText: true,
              decoration: InputDecoration(labelText: "密码", hintText: "请输入密码"),
            ),
            TextFormField(
              obscureText: true,
              decoration:
                  InputDecoration(labelText: "确认密码", hintText: "请再次输入密码"),
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
