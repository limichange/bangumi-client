import 'package:bangumi/src/components/MenuItem.dart';
import 'package:bangumi/src/pages/ContactPage/ContactPage.dart';
import 'package:bangumi/src/pages/UpdatePasswordPage/UpdatePasswordPage.dart';
import 'package:bangumi/src/state/GlobalData.dart';
import 'package:bangumi/src/utils/Utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AccountPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("我的"),
      ),
      body: Container(
        color: Color.fromRGBO(0, 0, 0, 0.04),
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 1),
              child: GestureDetector(
                onTap: () {
                  Utils.go(context, UpdatePasswordPage());
                },
                child: MenuItem(
                  text: '修改密码',
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 1),
              child: GestureDetector(
                onTap: () {
                  Provider.of<GlobalData>(context, listen: false).logout();
                  Navigator.pop(context);
                },
                child: MenuItem(
                  text: '退出登录',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
