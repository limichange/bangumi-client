import 'package:bangumi/src/api/API.dart';
import 'package:bangumi/src/utils/Utils.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SignupForm extends StatefulWidget {
  VoidCallback onSignupOk;

  SignupForm({@required this.onSignupOk});

  @override
  State<StatefulWidget> createState() {
    return _SignupForm();
  }
}

class _SignupForm extends State<SignupForm> {
  final formKey = GlobalKey<FormState>();

  var _context;
  String _username;
  String _password;
  String _passwordAgain;
  String _nickname;
  bool _checkbox = true;

  void _submit() async {
    final form = formKey.currentState;

    if (!_checkbox) {
      Utils.showToast(context: _context, text: '需要同意用户协议和隐私协议');
      return;
    }

    if (form.validate()) {
      form.save();

      var res = await api.singup(
          username: _username, password: _password, nickname: _nickname);

      if (res['status'] == 200) {
        Utils.showToast(context: _context, text: '注册成功 ━(*｀∀´*)ノ亻!');
        widget.onSignupOk();
        form.reset();
      } else {
        Utils.showToast(context: _context, text: res['message']);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    _context = context;

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Center(
          child: Form(
            key: formKey,
            child: Column(children: <Widget>[
              TextFormField(
                onSaved: (value) => _username = value,
                validator: (value) {
                  if (value.length == 0) {
                    return '不能空着 _(:з」∠)_';
                  }

                  Pattern pattern =
                      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                  RegExp regex = new RegExp(pattern);

                  if (!regex.hasMatch(value)) return '邮箱格式不对';

                  return null;
                },
                keyboardType: TextInputType.emailAddress,
                decoration:
                    InputDecoration(labelText: "邮箱", hintText: "你的邮箱邮箱地址"),
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
                    return '你的密码太短了 至少6位';
                  }

                  if (value.length > 36) {
                    return '你的密码太长了 最多36位';
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
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text('我同意'),
                  Container(
                    child: Checkbox(
                      value: _checkbox,
                      onChanged: (value) {
                        setState(() {
                          _checkbox = value;
                        });
                      },
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      launch('https://acgdesu.com/userAgreement',
                          forceSafariVC: false);
                    },
                    child: Text(
                      '用户协议和隐私协议',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
              RaisedButton(
                child: Text('注册'),
                color: Colors.pink[300],
                textColor: Colors.white,
                onPressed: _submit,
              )
            ]),
          ),
        ),
      ),
    );
  }
}
