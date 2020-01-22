import 'package:bangumi/src/api/API.dart';
import 'package:flutter/material.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginForm createState() {
    return _LoginForm();
  }
}

class _LoginForm extends State<LoginForm> {
  final formKey = GlobalKey<FormState>();

  String _password;
  String _username;

  void _submit() {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();

      print(_password + _username);
      new API().login(_username, _password);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Center(
          child: Form(
              key: formKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    onSaved: (value) => _username = value,
                    validator: (value) =>
                        value.length == 0 ? '不能空着 _(:з」∠)_' : null,
                    decoration:
                        InputDecoration(labelText: "用户名", hintText: "请输入用户名"),
                  ),
                  TextFormField(
                    obscureText: true,
                    onSaved: (value) => _password = value,
                    validator: (value) =>
                        value.length == 0 ? '不能空着 _(:з」∠)_' : null,
                    decoration:
                        InputDecoration(labelText: "密码", hintText: "请输入密码"),
                  ),
                  RaisedButton(
                    child: Text('登录'),
                    onPressed: _submit,
                  )
                ],
              )),
        ),
      ),
    );
  }
}
