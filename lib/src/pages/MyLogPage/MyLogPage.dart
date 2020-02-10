import 'package:bangumi/src/state/GlobalData.dart';
import 'package:bangumi/src/api/API.dart';
import 'package:bangumi/src/components/LoginButton.dart';
import 'package:bangumi/src/pages/MyLogPage/LogList.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyLogPage extends StatefulWidget {
  const MyLogPage({Key key}) : super(key: key);

  @override
  _MyLogPage createState() => _MyLogPage();
}

class _MyLogPage extends State<MyLogPage> with SingleTickerProviderStateMixin {
  var data;

  @override
  Widget build(BuildContext context) {
    var globalData = Provider.of<GlobalData>(context);

    return DefaultTabController(
      length: 3,
      child: Scaffold(
          key: PageStorageKey('LogListScaffold'),
          appBar: AppBar(
            key: GlobalKey(),
            // Here we take the value from the MyHomePage object that was created by
            // the App.build method, and use it to set our appbar title.
//            title: Text("我的收藏"),
            flexibleSpace: SafeArea(
              child: Container(
                width: double.infinity,
                height: 56,
                child: TabBar(
                  tabs: [
                    Tab(
                      text: "正在看",
                    ),
                    Tab(
                      text: "计划看",
                    ),
                    Tab(
                      text: "已看完",
                    ),
                  ],
                ),
              ),
            ),
          ),
          body: Container(
            key: ValueKey('test'),
            child: !globalData.isLogin
                ? Container(
                    padding: EdgeInsets.all(30.0),
                    alignment: Alignment.center,
                    child: LoginButton(),
                  )
                : TabBarView(
                    key: PageStorageKey('LogListTabBarView'),
                    children: <Widget>[
                        LogList(
                          status: 'doing',
                        ),
                        LogList(
                          key: new PageStorageKey('LogListTodo'),
                          status: 'todo',
                        ),
                        LogList(
                          key: new PageStorageKey('LogListDone'),
                          status: 'done',
                        ),
                      ]),
          )),
    );
  }
}
