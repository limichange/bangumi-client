import 'package:bangumi/src/api/API.dart';
import 'package:bangumi/src/pages/MyLogPage/LogList.dart';
import 'package:flutter/material.dart';

class MyLogPage extends StatefulWidget {
  const MyLogPage({Key key}) : super(key: key);

  @override
  _MyLogPage createState() => _MyLogPage();
}

class _MyLogPage extends State<MyLogPage> with SingleTickerProviderStateMixin {
  var data;
  TabController _tabController;

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
    return Scaffold(
        appBar: AppBar(
          key: GlobalKey(),
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text("我的收藏"),
          bottom: TabBar(
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
        body: TabBarView(
          controller: _tabController,
          children: [
            LogList(status: 'doing'),
            LogList(status: 'todo'),
            LogList(status: 'done'),
          ],
        ));
  }
}
