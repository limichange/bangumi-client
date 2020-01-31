import 'package:bangumi/src/GlobalData.dart';
import 'package:bangumi/src/api/API.dart';
import 'package:bangumi/src/components/LoginButton.dart';
import 'package:bangumi/src/pages/LoginAndSignupPage/LoginAndSignupPage.dart';
import 'package:bangumi/src/pages/MePage/LogoutButton.dart';
import 'package:bangumi/src/pages/UpdatePasswordPage/UpdatePasswordPage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class MePage extends StatefulWidget {
  const MePage({Key key}) : super(key: key);

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
    var globalData = Provider.of<GlobalData>(context);

    var noTokenWidget = Container(
      padding: EdgeInsets.all(30.0),
      alignment: Alignment.center,
      child: LoginButton(),
    );

    var hasTokenWidget = Column(
      children: <Widget>[
        Container(
          alignment: Alignment.center,
          child: RaisedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => UpdatePasswordPage()),
              );
            },
            child: Text('更新密码'),
          ),
        ),
        Container(
          alignment: Alignment.center,
          child: LogoutButton(),
        ),
      ],
    );

    var body = Column(
      children: <Widget>[
        Container(
            padding: EdgeInsets.all(30), child: Text(globalData.nickname)),
        globalData.token == '' ? noTokenWidget : hasTokenWidget
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
