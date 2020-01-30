import 'package:bangumi/src/GlobalData.dart';
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
  TabController _tabController;
  num _index = 0;

  @override
  void initState() {
    super.initState();

    _tabController = new TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var globalData = Provider.of<GlobalData>(context);

    return Scaffold(
        appBar: AppBar(
          key: GlobalKey(),
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text("我的收藏"),
          bottom: TabBar(
            onTap: (index) {
              setState(() {
                _index = index;
              });
            },
            controller: _tabController,
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
        body: Container(
          child: !globalData.isLogin
              ? Container(
                  padding: EdgeInsets.all(30.0),
                  alignment: Alignment.center,
                  child: LoginButton(),
                )
              : IndexedStack(children: <Widget>[
                  LogList(
                    status: 'doing',
                    key: ObjectKey('LogListDoing'),
                  ),
                  LogList(
                    status: 'todo',
                    key: ObjectKey('LogListTodo'),
                  ),
                  LogList(
                    status: 'done',
                    key: ObjectKey('LogListDone'),
                  ),
                ], index: _index),
        ));
  }
}
