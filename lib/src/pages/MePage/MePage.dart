import 'package:bangumi/src/GlobalData.dart';
import 'package:bangumi/src/api/API.dart';
import 'package:bangumi/src/pages/LoginAndSignupPage/LoginAndSignupPage.dart';
import 'package:bangumi/src/pages/MePage/LogoutButton.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    );

    var hasTokenWidget = Container(
      alignment: Alignment.center,
      child: LogoutButton(),
    );

    var body = Column(
      children: <Widget>[
        Container(
          width: 50,
          height: 50,
          decoration: new BoxDecoration(
            image: new DecorationImage(
              image: new AssetImage("assets/images/logo.png"),
              fit: BoxFit.cover,
            ),
          ),
        ),
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
