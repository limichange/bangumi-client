import 'package:bangumi/src/GlobalData.dart';
import 'package:bangumi/src/api/API.dart';
import 'package:bangumi/src/utils/Utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  var _context;
  var globalData;

  void _submit() async {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();

      var res = await new API().login(_username, _password);

      if (res['status'] == 200) {
        Utils.showToast(context: _context, text: '欢迎━(*｀∀´*)ノ亻!');

        SharedPreferences prefs = await SharedPreferences.getInstance();

        prefs.setString('token', res['data']['token']);

        globalData.updateToken(res['data']['token']);
        globalData.getUserInfo();

        Navigator.pop(context);
      } else {
        Utils.showToast(context: _context, text: res['message']);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    _context = context;

    globalData = Provider.of<GlobalData>(_context);

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
                    color: Colors.pink[300],
                    textColor: Colors.white,
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
