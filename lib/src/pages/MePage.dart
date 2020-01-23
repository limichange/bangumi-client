import 'package:bangumi/src/pages/LoginAndSignupPage/LoginAndSignupPage.dart';
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

    setState(() {
//      prefs.setString('key', 'value');
      key = prefs.getString('token');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("我的"),
      ),
      body: Column(
        children: <Widget>[
          Text(key),
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
      ),
    );
  }
}
