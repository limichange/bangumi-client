import 'package:bangumi/src/api/API.dart';
import 'package:bangumi/src/utils/Utils.dart';
import 'package:flutter/material.dart';

class UpdatePasswordPage extends StatefulWidget {
  @override
  _UpdatePasswordPage createState() {
    return _UpdatePasswordPage();
  }
}

class _UpdatePasswordPage extends State<UpdatePasswordPage> {
  final formKey = GlobalKey<FormState>();

  String _oldPassword;
  String _password;
  String _passwordAgain;
  var _context;
  var globalData;

  void _submit() async {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();

//      var res = await new API().login(_username, _password);

      print(_password + _oldPassword + _passwordAgain);

//      if (res['status'] == 200) {
////        Navigator.pop(_context);
//      } else {
//        Utils.showToast(context: _context, text: res['message']);
//      }
    }
  }

  @override
  Widget build(BuildContext context) {
    _context = context;

    return Scaffold(
      appBar: AppBar(
        title: Text('修改密码'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Center(
          child: Form(
              key: formKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    obscureText: true,
                    onSaved: (value) => _oldPassword = value,
                    validator: (value) =>
                        value.length == 0 ? '不能空着 _(:з」∠)_' : null,
                    decoration:
                        InputDecoration(labelText: "旧密码", hintText: "请输入旧密码"),
                  ),
                  TextFormField(
                    obscureText: true,
                    onSaved: (value) => _password = value,
                    validator: (value) {
                      if (value.length == 0) {
                        return '不能空着 _(:з」∠)_';
                      }

                      if (value.length < 6) {
                        return '你的密码太短了 至少6位';
                      }

                      if (value.length > 36) {
                        return '你的密码太长了 最多36位';
                      }

                      return null;
                    },
                    decoration:
                        InputDecoration(labelText: "新密码", hintText: "请输入新密码"),
                  ),
                  TextFormField(
                    obscureText: true,
                    onSaved: (value) => _passwordAgain = value,
                    validator: (value) {
                      if (value.length == 0) {
                        return '不能空着 _(:з」∠)_';
                      }

                      if (_passwordAgain != _password) {
                        return '两次的密码不一样';
                      }

                      return null;
                    },
                    decoration: InputDecoration(
                        labelText: "新密码确认", hintText: "请再次输入新密码"),
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
