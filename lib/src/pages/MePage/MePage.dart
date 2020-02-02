import 'package:bangumi/src/GlobalData.dart';
import 'package:bangumi/src/api/API.dart';
import 'package:bangumi/src/components/LoginButton.dart';
import 'package:bangumi/src/pages/ContactPage/ContactPage.dart';
import 'package:bangumi/src/pages/FeedbackPage/FeedbackPage.dart';
import 'package:bangumi/src/pages/MePage/LogoutButton.dart';
import 'package:bangumi/src/pages/UpdateLogPage/UpdateLogPage.dart';
import 'package:bangumi/src/pages/UpdatePasswordPage/UpdatePasswordPage.dart';
import 'package:bangumi/src/utils/Utils.dart';
import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';
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
  String versionStr = '';

  @override
  void initState() {
    super.initState();

    loadKey();
    loadVersion();
  }

  loadVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String version = packageInfo.version;
    String buildNumber = packageInfo.buildNumber;

    setState(() {
      versionStr = '当前版本 v' + version + '(' + buildNumber + ')';
    });

    var serverAppVersionRes = await new API().appVersion();

    if (serverAppVersionRes['status'] == 200) {
      versionStr += ' 最新版本 v' + serverAppVersionRes['data'];
    }
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
              Utils.go(context, UpdatePasswordPage());
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
        globalData.token == '' ? noTokenWidget : hasTokenWidget,
        Container(
          alignment: Alignment.center,
          child: RaisedButton(
            onPressed: () {
              Utils.go(context, UpdateLogPage());
            },
            child: Text('更新日志'),
          ),
        ),
        Container(
          child: RaisedButton(
            onPressed: () {
              Utils.go(context, ContactPage());
            },
            child: Text('联系我们'),
          ),
        ),
        Container(
          child: RaisedButton(
            onPressed: () {
              Utils.go(context, FeedbackPage());
            },
            child: Text('建议反馈'),
          ),
        ),
        Container(
          margin: EdgeInsets.all(20),
          child: Text(versionStr),
        )
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
