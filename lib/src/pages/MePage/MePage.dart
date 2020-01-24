import 'package:bangumi/src/api/API.dart';
import 'package:bangumi/src/pages/LoginAndSignupPage/LoginAndSignupPage.dart';
import 'package:bangumi/src/pages/MePage/LogoutButton.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MePage extends StatefulWidget {
  @override
  _MePage createState() {
    return _MePage();
  }
}

class _MePage extends State<MePage> {
  String key = '';

  @override
  void initState() {
    super.initState();

    loadKey();
  }

  loadKey() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');

    if (token != null) {
      new API().userInfo();

      setState(() {
        key = token;
      });
    } else {
      // todo
    }
  }

  @override
  Widget build(BuildContext context) {
    var body = Column(
      children: <Widget>[
        Text(key),
        Container(
          child: LogoutButton(),
        ),
        (Container(
          padding: EdgeInsets.all(30.0),
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
        ))
      ],
    );

    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text("我的"),
        ),
        body: body);
  }
}
