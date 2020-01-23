import 'package:bangumi/src/api/API.dart';
import 'package:flutter/material.dart';

class SignupForm extends StatelessWidget {
  final formKey = GlobalKey<FormState>();

  String _username;
  String _password;
  String _passwordAgain;
  String _nickname;

  void _submit() {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();

      print(_password + _username);
      new API().singup(
          username: _username, password: _password, nickname: _nickname);
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
            child: Column(children: <Widget>[
              TextFormField(
                onSaved: (value) => _username = value,
                validator: (value) =>
                    value.length == 0 ? '不能空着 _(:з」∠)_' : null,
                decoration:
                    InputDecoration(labelText: "用户名", hintText: "使用邮箱或者手机号"),
              ),
              TextFormField(
                onSaved: (value) => _nickname = value,
                validator: (value) =>
                    value.length == 0 ? '不能空着 _(:з」∠)_' : null,
                decoration: InputDecoration(labelText: "昵称", hintText: "你的昵称"),
              ),
              TextFormField(
                onSaved: (value) => _password = value,
                onChanged: (value) => _password = value,
                validator: (value) {
                  if (value.length == 0) {
                    return '不能空着 _(:з」∠)_';
                  }

                  if (value.length < 6) {
                    return '你的密码太短了';
                  }

                  return null;
                },
                obscureText: true,
                decoration: InputDecoration(labelText: "密码", hintText: "请输入密码"),
              ),
              TextFormField(
                obscureText: true,
                onSaved: (value) => _passwordAgain = value,
                onChanged: (value) => _passwordAgain = value,
                validator: (value) {
                  if (value.length == 0) {
                    return '不能空着 _(:з」∠)_';
                  }

                  if (_passwordAgain != _password) {
                    return '两次的密码不一样';
                  }

                  return null;
                },
                decoration:
                    InputDecoration(labelText: "确认密码", hintText: "请再次输入密码"),
              ),
              RaisedButton(
                child: Text('注册'),
                onPressed: _submit,
              )
            ]),
          ),
        ),
      ),
    );
  }
}
